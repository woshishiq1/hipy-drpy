const CryptoJS = require("crypto-js");

/** 可用
 async-mutex
 axios
 cheerio
 crypto-js
 dayjs
 hls-parser
 json-bigint
 xmlbuilder2
 */

const _home = async ({ filter }) => {
  return {
    class: [
      {
        type_id: "分类ID",
        type_name: "分类名称",
      },
    ],
    list: [],
  };
};
const _category = async ({ id, page, filter, filters }) => {
  return {
    list: [
      {
        vod_id: 1,
        vod_name: "",
        vod_pic: "",
        vod_remarks: "",
      },
    ],
    page: 1,
    pagecount: 1,
  };
};
const _detail = async ({ id }) => {
  const result = {
    list: [],
  };

  for (const id_ of id) {
    result.list.push({
      vod_id: id_,
    });
  }

  return result;
};
const _search = async ({ page, quick, wd }) => {
  return {
    list: [],
    page: 1,
    pagecount: 1,
    total: 1,
  };
};
const _play = async ({ flag, flags, id }) => {
  return {
    parse: 0,
    jx: 0,
    url: "",
    header: {},
  };
};

const _proxy = async (req, reply) => {
  return Object.assign({}, req.query, req.params);
};

const meta = {
  key: "example",
  name: "示例",
  type: 4,
  api: "/video/example", //使用相对地址，服务会自动处理
  searchable: 1,
  quickSearch: 1,
  changeable: 0,
};

module.exports = async (app, opt) => {
  app.get(meta.api, async (req, reply) => {
    const { extend, filter, t, ac, pg, ext, ids, flag, play, wd, quick } =
      req.query;

    if (play) {
      return await _play({ flag: flag || "", flags: [], id: play });
    } else if (wd) {
      return await _search({
        page: parseInt(pg || "1"),
        quick: quick || false,
        wd,
      });
    } else if (!ac) {
      return await _home({ filter: filter ?? false });
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
        return await _category(body);
      } else if (ids) {
        return await _detail({
          id: ids
            .split(",")
            .map((_id) => _id.trim())
            .filter(Boolean),
        });
      }
    }

    return req.query;
  });
  app.get(`${meta.api}/proxy`, _proxy);
  opt.sites.push(meta);
};
