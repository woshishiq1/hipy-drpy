const axios = require("axios");
const http = require("http");
const https = require("https");
const CryptoJS = require("crypto-js");

const _http = axios.create({
  timeout: 15 * 1000,
  httpsAgent: new https.Agent({ keepAlive: true, rejectUnauthorized: false }),
  httpAgent: new http.Agent({ keepAlive: true }),
  headers: {
    "user-agent":
      "Mozilla/5.0 (Linux; Android 10; MI 8 Build/QKQ1.190828.002; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.101 Mobile Safari/537.36 bsl/1.0;webank/h5face;webank/2.0",
    referer: "https://www.360kan.com",
  },
});

// 解析器列表配置
const parsers = [
  { name: "parse_mg1", label: "芒果解析" },
  { name: "parse_tx1", label: "腾讯解析1" },
  { name: "parse_jx1", label: "通用解析1" },
  { name: "parse_jx2", label: "通用解析2" },
  { name: "parse_xmflv", label: "虾米解析" },
  { name: "parse_fish", label: "岁岁解析" },
  { name: "parse_moyu", label: "摸鱼解析" },
];

const fetch = async (url, params) => {
  const ret = (await _http.get(url, { params: params })).data;
  if (ret.errno !== 0) {
    throw new Error(ret.msg);
  }
  return ret;
};

const init = async (server) => {
  if (store.init) return;
  store.redis = server.redis;
  store.log = server.log;
  store.init = true;
};

const home = async ({ filter }) => {
  const result = {
    class: [
      { type_id: 2, type_name: "电视剧" },
      { type_id: 1, type_name: "电影" },
      { type_id: 4, type_name: "动漫" },
      { type_id: 3, type_name: "综艺" },
    ],
    list: [],
  };

  const ret = await fetch("https://api.web.360kan.com/v1/rank", {
    cat: 1,
    size: 8,
  });

  for (let v of ret.data) {
    result.list.push({
      vod_id: `${v.cat}_${v.ent_id}`,
      vod_name: v.title,
      vod_pic: v.cover,
      vod_remarks: v.upinfo,
      vod_content: v.description,
    });
  }

  return result;
};

const category = async ({ id, page, filter, filters }) => {
  const size = 21;
  const tid = id;
  const pg = page || 1;

  const result = {
    list: [],
    page: pg,
    pagecount: pg,
  };

  const ret = await fetch("https://api.web.360kan.com/v1/filter/list", {
    catid: tid,
    size: size,
    pageno: pg,
  });

  const data = ret.data;

  for (let v of data.movies) {
    const vod = {
      vod_id: `${tid}_${v.id}`,
      vod_name: v.title,
      vod_pic: "",
      vod_remarks: v.doubanscore || v.comment,
    };

    let pic = v.cdncover || v.cover || "";
    if (!/^https?:\/\//i.test(pic)) {
      pic = `https:${pic}`;
    }
    vod.vod_pic = pic;

    result.list.push(vod);
  }

  result["total"] = data.total;
  result["pagecount"] = Math.ceil(data.total / size);
  return result;
};

const detail = async ({ id }) => {
  const ids = !Array.isArray(id) ? [id] : id;
  const api = "https://api.web.360kan.com/v1/detail";
  const result = {
    list: [],
  };

  for (const id_ of ids) {
    const _id = id_.split("_", 2);
    const params = {
      cat: _id[0],
      id: _id[1],
    };
    const ret = await fetch(api, params);
    const data = ret.data;
    const vod = {
      vod_id: id_,
      vod_name: data.title,
      vod_pic: data.cdncover,
      type_name: data.moviecategory ? data.moviecategory.slice(-1)[0] : "",
      vod_year: data.pubdate,
      vod_area: (data.area || []).join(", "),
      vod_remarks: data.doubanscore,
      vod_actor: (data.actor || []).join(", "),
      vod_director: (data.director || []).join(", "),
      vod_content: data.description,
      vod_play_from: "",
      vod_play_url: "",
    };

    if (ids.length === 1) {
      const play_forms = [];
      const play_urls = [];
      // [新增] 用于存储所有线路的聚合数据 { '1': [url1, url2], '2': [url1, url2] }
      const smart_episodes = {};

      // 获取所有支持的线路站点
      const allSites = data.playlink_sites || Object.keys(data.playlinksdetail || {});
      
      for (const site of allSites) {
        let play_url_list = [];
        let episodes = data.allepidetail?.[site] || [];
        const totalEp = Number(data.allupinfo?.[site]) || 0;

        // 如果当前站点没有剧集数据,但总数大于0,说明需要带 site 参数重新请求补全
        if (episodes.length === 0 && totalEp > 0) {
          try {
            const siteParams = { ...params, site: site, start: 1, end: 50 };
            const siteRet = (await _http.get(api, { params: siteParams })).data;
            if (siteRet.errno === 0) {
              episodes = siteRet.data?.allepidetail?.[site] || [];
            }
          } catch (e) {
            store.log?.error(`获取站点 ${site} 数据失败`);
          }
        }

        // 处理多集详细数据
        if (episodes.length > 0) {
          if (episodes.length < totalEp && totalEp > 50) {
            const pageSize = 50;
            for (let page = 1; page < Math.ceil(totalEp / pageSize); page++) {
              const start = page * pageSize + 1;
              let end = start + pageSize - 1;
              if (end > totalEp) end = totalEp;
              const paramsNext = { ...params, start, end, site };
              try {
                const retNext = (await _http.get(api, { params: paramsNext })).data;
                if (retNext.errno === 0) {
                  const moreEp = retNext.data?.allepidetail?.[site] || [];
                  episodes = episodes.concat(moreEp);
                }
              } catch (e) {}
            }
          }

          for (const ep of episodes) {
            if (ep.url && ep.playlink_num) {
              const cleanUrl = ep.url.trim();
              play_url_list.push(`${ep.playlink_num}$${cleanUrl}`);
              
              // [新增] 收集智能线路数据
              if (!smart_episodes[ep.playlink_num]) {
                smart_episodes[ep.playlink_num] = [];
              }
              // 避免重复链接
              if (!smart_episodes[ep.playlink_num].includes(cleanUrl)) {
                smart_episodes[ep.playlink_num].push(cleanUrl);
              }
            }
          }
        }

        // 备用链接
        if (play_url_list.length === 0 && data.playlinksdetail?.[site]?.default_url) {
          const link = data.playlinksdetail[site];
          const cleanUrl = link.default_url.trim();
          play_url_list.push(`${site}$${cleanUrl}`);
          
          // [新增] 收集备用链接到智能线路（使用 '1' 作为默认集数或直接使用 site 名）
          const key = '1'; 
          if (!smart_episodes[key]) smart_episodes[key] = [];
          if (!smart_episodes[key].includes(cleanUrl)) {
             smart_episodes[key].push(cleanUrl);
          }
        }

        if (play_url_list.length > 0) {
          // 为每个线路和解析器组合创建播放源
          for (const parser of parsers) {
            play_forms.push(`${site}-${parser.label}`);
            play_urls.push(play_url_list.join("#"));
          }
        }
      }
      
      // [新增] 生成智能线路并插入到最前面
      // 对集数进行排序，确保顺序正确
      const smart_keys = Object.keys(smart_episodes).sort((a, b) => parseFloat(a) - parseFloat(b));
      if (smart_keys.length > 0) {
          const smart_url_list = [];
          for (const k of smart_keys) {
              // 将同一集的不同线路链接用 '|||' 分隔，传递给 _play 处理
              const combined_urls = smart_episodes[k].join('|||');
              smart_url_list.push(`${k}$${combined_urls}`);
          }
          // 插入到数组开头
          play_forms.unshift("智能线路");
          play_urls.unshift(smart_url_list.join("#"));
      }

      if (play_forms.length > 0) {
        vod.vod_play_from = play_forms.join("$$$");
        vod.vod_play_url = play_urls.join("$$$");
      }
    }

    result.list.push(vod);
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
  const res = await _http.get("https://api.so.360kan.com/index", {
    params: {
      kw: wd,
    },
  });
  const ret = res.data;

  if (ret.data && ret.data.longData) {
    for (const i in ret.data.longData.rows || []) {
      const row = ret.data.longData.rows[i];
      result.list.push({
        vod_id: `${row.cat_id}_${row.en_id}`,
        vod_name: row.titleTxt,
        vod_pic: row.cover,
        vod_remarks: (row.coverInfo || {}).txt,
        year: row.year,
      });
    }
  }

  return result;
};

const _play = async ({ flag, flags, id, parser }, app) => {
  // [新增] 智能线路处理逻辑
  if (flag === "智能线路") {
      // id 中包含该集所有线路的 url，用 ||| 分隔
      const urls = id.split('|||');
      
      // 第一层循环：遍历该集所有的源链接（线路）
      for (const url of urls) {
          // 第二层循环：遍历所有定义的解析器
          for (const p of parsers) {
             const pName = `${p.name}`;
             if (app[pName]) {
                 try {
                     // 尝试获取播放地址
                     const res = await app[pName]({ flag, flags, id: url });
                     // 如果获取到有效的 url，直接返回，不再尝试
                     if (res && res.url) {
                         store.log?.info(`智能线路命中: 线路URL=${url}, 解析=${p.label}`);
                         return res;
                     }
                 } catch (e) {
                     // 忽略错误，继续尝试下一个组合
                 }
             }
          }
      }
      // 如果所有线路和解析都失败，回退到第一个链接直连（或返回原始信息）
      return {
          url: urls[0],
          parse: 1,
          jx: 1,
      };
  }

  if (!parser && flag) {
    const parts = flag.split('-');
    if (parts.length >= 2) {
      const labelPart = parts[1].trim().toLowerCase();
      // 然后用 labelPart 去匹配 parsers 里的 label
      for (const p of parsers) {
        if (p.label.toLowerCase().includes(labelPart)) {
          parser = p.name;
          break;
        }
      }
    }
  }

  // 原有逻辑
  const parses = [];
  // 根据选中的解析器优先级排序
  const selectedParser = parser ? `${parser}` : null;
  try {
    if (selectedParser && app[selectedParser]) {
      // 优先使用用户选中的解析器
      // [修复] 原代码此处引用 realUrl 可能报错，改为使用传入的 id
      const res = await app[selectedParser]({ flag, flags, id: id });
      if (res?.url) {
        return res;
      }
    }
  } catch (e) {
    // 防止 parse 不存在报错
  }
  // 全部失败则原样返回给壳处理
  return {
    url: id,
    parse: 1,
    jx: 1,
  };
};

const cachedFunction = (fn, timeout = 3600) => {
  return async (...args) => {
    const name = fn.name.replace("_", "").trim();
    store.log?.info(args);
    const cacheKey = `${store.meta.key}${name}:${CryptoJS.MD5(
      JSON.stringify(args)
    )}`;
//    if (store.redis) {
//      await store.redis.del(cacheKey);
//    }

    let result = await store.redis?.get(cacheKey);
    if (result) {
      result = JSON.parse(result);
    } else {
      result = await fn.apply(this, args);
      await store.redis?.set(cacheKey, JSON.stringify(result));
      if ((timeout ?? 0) > 0) {
        await store.redis?.expire(cacheKey, timeout);
      }
    }
    return result;
  };
};

const store = {
  init: false,
  meta: {
    key: "movie360",
    name: "360影视",
    type: 4,
    api: "/video/movie360",
    searchable: 1,
    quickSearch: 1,
    changeable: 0,
  },
  home: cachedFunction(home),
  category: cachedFunction(category),
  detail: cachedFunction(detail),
  search: cachedFunction(search),
};

module.exports = async (app, opt) => {
  app.get(store.meta.api, async (req, reply) => {
    if (!store.init) {
      await init(req.server);
    }
    const { extend, filter, t, ac, pg, ext, ids, flag, play, wd, quick, parser } =
      req.query;

    if (play) {
      return await _play({ flag: flag || "", flags: [], id: play, parser }, req.server);
    } else if (wd) {
      return await store.search({
        page: parseInt(pg || "1"),
        quick: quick || false,
        wd,
      });
    } else if (!ac) {
      return await store.home({ filter: filter ?? false });
    } else if (ac === "detail") {
      if (t) {
        const body = {
          id: t,
          page: parseInt(pg || "1"),
          filter: filter || false,
          filters: {},
        };
        if (ext) {
          try {
            body.filters = JSON.parse(
              CryptoJS.enc.Base64.parse(ext).toString(CryptoJS.enc.Utf8)
            );
          } catch { }
        }
        return await store.category(body);
      } else if (ids) {
        return await store.detail({
          id: ids
            .split(",")
            .map((_id) => _id.trim())
            .filter(Boolean),
        });
      }
    }

    return req.query;
  });
  opt.sites.push(store.meta);
};