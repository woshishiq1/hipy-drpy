const axios = require("axios");
const http = require("http");
const https = require("https");
const CryptoJS = require("crypto-js");
const dayjs = require("dayjs");

const _http = axios.create({
  timeout: 60 * 1000,
  httpsAgent: new https.Agent({ keepAlive: true, rejectUnauthorized: false }),
  httpAgent: new http.Agent({ keepAlive: true }),
  baseURL: "http://192.168.50.50:1514",   //盘搜服务地址
});

const init = async (server) => {
  if (store.init) return;
  store.redis = server.redis;
  store.log = server.log;
  store.drives = server.drives;
  store.init = true;
};

const detail = async ({ id }) => {
  const ids = !Array.isArray(id) ? [id] : id;
  const _id = ids[0];
  const result = { list: [] };

  for (const drive of store.drives) {
    if (drive.matchShare(_id)) {
      const vod = await drive.getVod(_id);
      if (vod) {
        vod.vod_id = _id;
        result.list.push(vod);
      }
      break;
    }
  }
  return result;
};

const search = async ({ page, quick, wd }) => {
  const result = {
    list: [],
    page: 1,
    pagecount: 1,
    total: 1,
  };

  const panTypes = {
    // ali: "aliyun",
    quark: "quark",
    uc: "uc",
    pikpak: "pikpak",
    xunlei: "xunlei",
    a123: "123",
    a189: "tianyi",
    a139: "mobile",
    a115: "115",
    baidu: "baidu"
  };

  const panPic = {
    ali: "https://i.kkb.xx.kg/image/d9nRUFClrXqbwO2MOlou2P.jpg",
    quark: "https://i.kkb.xx.kg/image/yHQ77Y4eq553zKJmiwhMb6.jpg",
    uc: "https://i.kkb.xx.kg/image/5MAg7EseQeJUtrwevSyMFG.jpg",
    pikpak: "https://i.kkb.xx.kg/image/mzqDP7FxxdIJUJ2nTqiHsF.jpg",
    xunlei: "https://i.kkb.xx.kg/image/W72QBMGFWSyAsGwaPVNKPE.jpg",
    '123': "https://i.kkb.xx.kg/image/PBy07a6a8NeF4A8W9l6tuT.jpg",
    tianyi: "https://i.kkb.xx.kg/image/k21mequdXQK3SxQ1elm1Yz.jpg",
    mobile: "https://i.kkb.xx.kg/image/wEzwFudS6fgs402vWuJGCq.jpg",
    '115': "https://i.kkb.xx.kg/image/t9vfqYfQCiurhth3oOx0jj.jpg",
    'baidu': "https://i.kkb.xx.kg/image/zYrck8nQPegrsoYZ3pxfsA.jpg",
  };

  // 1. 先调用盘搜接口获取原始结果
  const res = await _http.post("/api/search", {
    kw: wd,
    cloud_types: store.drives.map((d) => panTypes[d.key]).filter(Boolean),
  });

  const ret = res.data;
  if (ret.code !== 0) {
    throw new Error(ret.message || "请求失败");
  }

  // 2. 把所有原始条目先存下来（后面要用来映射回完整信息）
  const rawItems = []; // { row, panKey, drive }

  for (const key in ret.data.merged_by_type || {}) {
    const panKey = Object.keys(panTypes).find((k) => panTypes[k] === key);
    const drive = store.drives.find((o) => o.key === panKey);
    const pic = panPic[key];

    for (const row of ret.data.merged_by_type[key] || []) {
      rawItems.push({
        row,
        panKey,
        drive,
        pic,
      });
    }
  }

  if (rawItems.length === 0) {
    return result;
  }

  // 3. 收集所有要校验的链接（去重）
  const uniqueLinks = [...new Set(rawItems.map((it) => it.row.url))];

  // 4. 调用链接校验接口（可配置要保留的状态）
  const VALID_STATUS = ["valid_links"];           // 当前只保留 valid
  // const VALID_STATUS = ["valid_links", "pending_links"]; // 以后想保留 pending 直接打开这行

  let validLinksSet = new Set();

  try {
    const checkRes = await _http.post(
      "http://192.168.50.50:7024/api/v1/links/check", // 盘搜校验服务地址，没有则删除，保留双引号
      {
        links: uniqueLinks,
        selected_platforms: [
          "quark",
          "uc",
          "baidu",
          "tianyi",
          "pan123",
          "pan115",
        //   "aliyun",
          "xunlei",
          "cmcc",
        ],
      },
      {
        timeout: 30000,
        headers: {
          "Content-Type": "application/json",
          // 如果你的校验接口需要 cookie，这里可以统一放进 axios 的默认 headers
          // Cookie: 'fnos-long-token=xxx; ...'
        },
      }
    );

    const checkData = checkRes.data;

    for (const status of VALID_STATUS) {
      (checkData[status] || []).forEach((link) => validLinksSet.add(link));
    }
  } catch (e) {
    store.log?.error("[盘搜校验链接失败] " + e.message);
    // 如果校验接口挂了，直接放通全部（避免搜索完全失效）
    uniqueLinks.forEach((l) => validLinksSet.add(l));
  }

  // 5. 只保留有效链接对应的原始条目
  const filteredItems = rawItems.filter((it) =>
    validLinksSet.has(it.row.url)
  );

  // 6. 组装成原来的 vod 结构
  const currentTime = dayjs();

  for (const it of filteredItems) {
    const { row, panKey, drive, pic } = it;

    const rowTime = dayjs(row.datetime);
    const timeDiff = currentTime.diff(rowTime, "minute");

    const dt = dayjs(
      timeDiff <= 70 && timeDiff >= 0 ? "0001-01-01T00:00:00Z" : row.datetime
    );
    const source = row.source ? row.source.replace(/plugin:/gi, "plg:") : "";

    result.list.push({
      vod_id: row.url,
      vod_name: row.note,
      vod_pic: pic,
      vod_remarks: `${source || ""} | ${dt.format("MMDDYY")}`,
      time: dt.unix(),
      pan: panKey,
    });
  }

  // ============================ 下面是原来的排序逻辑（保持不变） ============================

  const orderMap = store.drives
    .map((o) => o.key)
    .reduce((map, key, idx) => {
      map[key] = idx;
      return map;
    }, {});

  const qualityKeywords = [
    'HDR', '杜比视界', 'DV',
    'REMUX', 'HQ', "臻彩",'高码', '高画质',
    '60FPS', '60帧', '高帧率', '60HZ',
    "4K", "2160P",
    "SDR", "1080P", "HD", "高清",
    "720P", "标清",
  ];

  const completedKeywords = ["完结", "全集", "已完成", "全"];

  const getQualityScore = (name) => {
    const upper = name.toUpperCase();
    let score = 0,
      cnt = 0;
    for (let i = 0; i < qualityKeywords.length; i++) {
      if (upper.includes(qualityKeywords[i].toUpperCase())) {
        score += qualityKeywords.length - i;
        cnt++;
      }
    }
    return score + cnt;
  };

  const getCount = (name, arr) => {
    const upper = name.toUpperCase();
    let c = 0;
    for (const kw of arr) {
      if (upper.includes(kw.toUpperCase())) c++;
    }
    return c;
  };

  result.list.sort((a, b) => {
    // 1. 云盘顺序
    const oa = orderMap[a.pan] ?? 999;
    const ob = orderMap[b.pan] ?? 999;
    if (oa !== ob) return oa - ob;

    // 2. 画质分数
    const qa = getQualityScore(a.vod_name);
    const qb = getQualityScore(b.vod_name);
    if (qa !== qb) return qb - qa;

    // 3. 完结关键词数量
    const ca = getCount(a.vod_name, completedKeywords);
    const cb = getCount(b.vod_name, completedKeywords);
    if (ca !== cb) return cb - ca;

    // 4. 画质关键词数量（次要）
    const qa2 = getCount(a.vod_name, qualityKeywords);
    const qb2 = getCount(b.vod_name, qualityKeywords);
    if (qa2 !== qb2) return qb2 - qa2;

    // 5. 时间倒序（最新在前面）
    if (b.time !== a.time) return b.time - a.time;

    return 0; // 稳定排序
  });

  return result;
};

const play = async ({ flag, flags, id }) => {
  const drive = store.drives.find((o) => new RegExp(`^${o.key}`, "i").test(flag));
  return await drive?.play(id, flag);
};

const cachedFunction = (fn, timeout = 1) => {
  return async (...args) => {
    const name = fn.name.replace("_", "").trim();
    store.log?.info(args);
    const cacheKey = `${store.meta.key}${name}:${CryptoJS.MD5(JSON.stringify(args))}`;
    let result;
    result = await store.redis?.get(cacheKey);
    if (result) {
      result = JSON.parse(result);
    } else {
      result = await fn.apply(this, args);
      await store.redis?.set(cacheKey, JSON.stringify(result));
      if ((timeout ?? 0) > 0) await store.redis?.expire(cacheKey, timeout);
    }
    return result;
  };
};

const store = {
  init: false,
  meta: {
    key: "panso",
    name: "盘搜",
    type: 4,
    api: "/video/pansou",
    searchable: 1,
    quickSearch: 1,
    changeable: 0,
  },
  home: async ({ filter }) => ({
    class: [{ type_id: 1, type_name: "纯搜|无资源" }],
    list: [],
  }),
  category: async ({ id, page, filter, filters }) => ({
    list: [{
      vod_id: 1,
      vod_name: "无资源",
      vod_pic: "",
      vod_remarks: "纯搜",
    }],
    page: 1,
    pagecount: 1,
  }),
  detail: cachedFunction(detail),
  search: cachedFunction(search),
  play: cachedFunction(play),
};

module.exports = async (app, opt) => {
  app.get(store.meta.api, async (req, reply) => {
    if (!store.init) await init(req.server);
    const { extend, filter, t, ac, pg, ext, ids, flag, play, wd, quick } = req.query;
    if (play) {
      return await store.play({ flag: flag || "", flags: [], id: play });
    } else if (wd) {
      return await store.search({ page: parseInt(pg || "1"), quick: quick || false, wd });
    } else if (!ac) {
      return await store.home({ filter: filter ?? false });
    } else if (ac === "detail") {
      if (t) {
        const body = { id: t, page: parseInt(pg || "1"), filter: filter || false, filters: {} };
        if (ext) {
          try {
            body.filters = JSON.parse(CryptoJS.enc.Base64.parse(ext).toString(CryptoJS.enc.Utf8));
          } catch {}
        }
        return await store.category(body);
      } else if (ids) {
        return await store.detail({ id: ids.split(",").map((_id) => _id.trim()).filter(Boolean) });
      }
    }
    return req.query;
  });
  opt.sites.push(store.meta);
};
