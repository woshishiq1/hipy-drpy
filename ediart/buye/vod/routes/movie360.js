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
      {
        type_id: 2,
        type_name: "电视剧",
      },
      {
        type_id: 1,
        type_name: "电影",
      },
      {
        type_id: 4,
        type_name: "动漫",
      },
      {
        type_id: 3,
        type_name: "综艺",
      },
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
  //const extend = filters;

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

      if (data.allepidetail) {
        for (const v in data.allupinfo) {
          const play_url = [];

          const count = data.allupinfo[v];
          //大于50集以上
          if ((data.allepidetail[v] || []).length < count) {
            const pageSize = 50;
            for (let page = 0; page < Math.ceil(count / pageSize); page++) {
              const start = page * pageSize + 1;
              let end = start + pageSize - 1;

              if (end > count) {
                end = count;
              }

              Object.assign(params, {
                start: start,
                end: end,
                site: v,
              });

              const ret = (await _http.get(api, { params: params })).data;
              if (ret.errno === 1) {
                continue;
              } else {
                for (const i in ret.data.allepidetail[v]) {
                  const video = ret.data.allepidetail[v][i];
                  play_url.push(`${video.playlink_num}\$${video.url}`);
                }
              }
            }
          } else {
            for (const i in data.allepidetail[v]) {
              const video = data.allepidetail[v][i];
              play_url.push(`${video.playlink_num}\$${video.url}`);
            }
          }

          play_forms.push(v);
          play_urls.push(play_url.join("#"));
        }
      } else if (data.playlinksdetail) {
        for (const v in data.playlinksdetail) {
          const play_url = [];

          const video = data.playlinksdetail[v];
          play_url.push(`${v}\$${video.default_url}`);

          play_forms.push(v);
          play_urls.push(play_url.join("#"));
        }
      }

      vod.vod_play_from = play_forms.join("$$$");
      vod.vod_play_url = play_urls.join("$$$");
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

const _play = async ({ flag, flags, id }, app) => {
  const parses = [];
  try {
    parses.push(app.parse_fish); // parses目录下的fish.js
    parses.push(app.parse_jx1);
    parses.push(app.parse_jx2);
    // ... 可添加多个
  } catch {
    // 此处是防止添加不存在的解析造成的异常
  }

  for (const parse of parses) {
    try {
      return await parse({ flag, flags, id });
    } catch (e) {
      app.log.error(`解析失败：${e.message}`);
    }
  }

  //全部失败则返回给壳处理
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

    let result;
    result = await store.redis?.get(cacheKey);
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
    api: "/video/movie360", //使用相对地址，服务会自动处理
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

    const { extend, filter, t, ac, pg, ext, ids, flag, play, wd, quick } =
      req.query;

    if (play) {
      return await _play({ flag: flag || "", flags: [], id: play }, req.server);
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
          } catch {}
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
