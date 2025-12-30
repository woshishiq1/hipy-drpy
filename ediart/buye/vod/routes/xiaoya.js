const axios = require("axios");
const http = require("http");
const https = require("https");

const _http = axios.create({
  timeout: 15 * 1000,
  httpsAgent: new https.Agent({ keepAlive: true, rejectUnauthorized: false }),
  httpAgent: new http.Agent({ keepAlive: true }),
  baseURL: "https://192.168.1.254:6789", //替换成其他地址
  validateStatus: (status) => status >= 200,
});

const vodPath = "/vod1/xiaoya";
const playPath = "/play/xiaoya";

// 不使用自定义分类，清空这个数组
const _class = [];

const _play = async ({ flag, flags, id }, app) => {
  const res = await _http(playPath, {
    params: {
      id: id,
    },
  });

  const ret = res.data;
  const result = {
    url: ["RAW", ret.url],
    header:
      typeof ret.header === "string" ? JSON.parse(ret.header) : ret.header,
  };

  if (!/115/.test(ret.url) && !/192.168.1.254/.test(ret.url)) {
    const uri = new URL("http://127.0.0.1:5575/proxy");
    uri.searchParams.append("thread", 10);
    uri.searchParams.append("chunkSize", 256);
    uri.searchParams.append("url", ret.url);
    result.url.unshift(uri.toString());
    result.url.unshift("代理RAW");
  }

  return Object.assign(ret, result);
};

const fetch = async (req) => {
  delete req.query["token"];
  const { ac, flag, play } = req.query;
  if (play) {
    if (/\.(m3u8|mp4|rmvb|avi|wmv|flv|mkv|webm|mov|m3u)(?!\w)/i.test(play)) {
      return {
        url: play,
        jx: 0,
        parse: 0,
      };
    } else {
      return await _play({ flag: flag || "", flags: [], id: play }, req.server);
    }
  }

  const ret = await _http(vodPath, {
    params: req.query,
  });

  if (!ac && _class.length > 0) {
    ret.data["class"] = _class;
  }

  return ret.data;
};

const meta = {
  key: "xiaoya", //key不能与其他site冲突
  name: "小雅",
  type: 4,
  api: "/video/xiaoya", //使用相对地址，服务会自动处理，不能与其他site冲突
  searchable: 1,
  quickSearch: 1,
  changeable: 0,
};

module.exports = async (app, opt) => {
  app.get(meta.api, fetch);
  opt.sites.push(meta);
};
