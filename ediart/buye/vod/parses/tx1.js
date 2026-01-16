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
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.57",
  },
});

const name = "parse_tx1";
const api = "http://shybot.top/v2/video/jx/?shykey=4595a71a4e7712568edcfa43949236b42fcfcb04997788ebe7984d6da2c6a51c&"; //json解析接口，后面不要带url=

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
  throw new Error(`${name} 解析 ${JSON.stringify(params)} 失败`);
};

module.exports = fp(async (app, opts) => {
  app.decorate(name, parse);
});
