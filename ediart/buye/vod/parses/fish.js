const fp = require("fastify-plugin");
const axios = require("axios");
const http = require("http");
const https = require("https");

const _http = axios.create({
  timeout: 15 * 1000,
  httpsAgent: new https.Agent({ keepAlive: true, rejectUnauthorized: false }),
  httpAgent: new http.Agent({ keepAlive: true }),
  headers: {
    "user-agent":
      "Mozilla/5.0 (Linux; Android 10; MI 8 Build/QKQ1.190828.002; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.101 Mobile Safari/537.36 bsl/1.0;webank/h5face;webank/2.0",
  },
});

const name = "parse_fish";
const api = "http://baidu.com/parse"; //json解析接口，后面不要带url=

const parse = async ({ flag, flags, id }) => {
  const params = {
    flag: flag,
    url: id,
  };

  const ret = (await _http.get(api, { params: params })).data;
  if (
    ret.parse == 0 ||
    ret.jx == 0 ||
    /\.(m3u8|mp4|rmvb|avi|wmv|flv|mkv|webm|mov|m3u)(?!\w)/i.test(ret.url)
  ) {
    const result = {
      url: ret.url,
      parse: 0,
      jx: 0,
    };
    if (ret.header || ret.headers) {
      result["header"] = ret.header || ret.headers;
    }
    return result;
  }
  throw new Error(`解析失败：${JSON.stringify(ret)}`);
};

module.exports = fp(async (app, opts) => {
  app.decorate(name, parse);
});
