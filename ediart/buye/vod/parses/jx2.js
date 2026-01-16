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

const name = "parse_jx2";
const api = "http://sspa8.top:8100/api/?cat_ext=eyJmbGFnIjpbInFxIiwi6IW+6K6vIiwicWl5aSIsIueIseWlh+iJuiIsIuWlh+iJuiIsInlvdWt1Iiwi5LyY6YW3Iiwic29odSIsIuaQnOeLkCIsImxldHYiLCLkuZDop4YiLCJtZ3R2Iiwi6IqS5p6cIiwidG5tYiIsInNldmVuIiwiYmlsaWJpbGkiLCIxOTA1Il0sImhlYWRlciI6eyJVc2VyLUFnZW50Ijoib2todHRwLzQuOS4xIn19&key=星睿4k&"; //json解析接口，后面不要带url=

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
