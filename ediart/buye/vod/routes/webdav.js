const CryptoJS = require("crypto-js");
const dayjs = require("dayjs");

let db;
let webdav;

const getEpisodeName = (fileName, fileSize) => {
  let ext = "";
  if (fileSize <= 0) {
    ext = "";
  } else if (fileSize > 1024 * 1024 * 1024 * 1024.0) {
    fileSize /= 1024 * 1024 * 1024 * 1024.0;
    ext = "T";
  } else if (fileSize > 1024 * 1024 * 1024.0) {
    fileSize /= 1024 * 1024 * 1024.0;
    ext = "G";
  } else if (fileSize > 1024 * 1024.0) {
    fileSize /= 1024 * 1024.0;
    ext = "M";
  } else {
    fileSize /= 1024.0;
    ext = "K";
  }

  fileName = fileName.trim();
  fileName = fileName.includes(".")
    ? fileName.substring(0, fileName.lastIndexOf("."))
    : fileName;
  return `[${fileSize.toFixed(2)}${ext}] ${fileName}`;
};

const baseUrl = (req) => {
  let scheme;

  if (req.headers["cf-visitor"]) {
    scheme = JSON.parse(req.headers["cf-visitor"]).scheme;
  } else if (req.headers["x-forwarded-proto"]) {
    scheme = req.headers["x-forwarded-proto"].split(",")[0].trim();
  } else if (req.headers["x-forwarded-ssl"] === "on") {
    scheme = "https"; // 兼容Heroku等平台
  } else {
    scheme = req.protocol;
  }

  return `${scheme}://${req.headers.host || req.host}/webdav`;
};

const _home = async ({ filter }) => {
  const pan = webdav.getTypes();
  return {
    class: pan.map((n) => ({
      type_id: `/${n}`,
      type_name: `${n}网盘`,
    })),
    list: [],
  };
};
const _category = async ({ id, page, filter, filters }) => {
  const list = [];

  const nodes = await webdav.listNodes(id);
  for (const row of nodes) {
    list.push({
      vod_id: row.isDir ? `${id}/${row.name}` : row.id,
      vod_name: row.name,
      vod_pic: "",
      vod_pict: Array.from(row.name)[0],
      ratio: 2,
      vod_remarks:
        row.isDir && row.updatedAt
          ? dayjs(row.updatedAt).format("MM-DD HH:mm")
          : row.mimeType,
      cate: row.isDir ? {} : undefined,
    });
  }

  return {
    list: list,
    page: page,
    pagecount: 1,
  };
};
const _detail = async ({ id }) => {
  const ids = !Array.isArray(id) ? [id] : id;
  const _id = ids[0];

  const node = await db.get(
    `SELECT 
        n.id, n.name, n.size, m.name as mName, m.type
      FROM
        nodes n
        JOIN mounts m ON n.mountId = m.id
      WHERE
        n.id = ?`,
    [_id.replace(/^n_/, "")]
  );
  if (!node) throw new Error("资源已不存在");

  const tree = await db.all(
    `WITH RECURSIVE tree AS (
        SELECT id, pid, name, 0 as level
        FROM nodes 
        WHERE id = ?

        UNION ALL

        SELECT n.id, n.pid, n.name, level + 1
        FROM nodes n
        JOIN tree ON n.id = tree.pid
      )
      SELECT name, level
      FROM tree
      ORDER BY level DESC;`,
    [node.id]
  );

  const path = `/${node.type}/${node.mName}/${tree
    .map((o) => o.name)
    .join("/")}`;

  const vod = {
    vod_id: node.id,
    vod_name: node.name,
    vod_remarks: node.type,
    vod_content: path,
    vod_play_from: node.type,
  };

  const url = CryptoJS.enc.Utf8.parse(path).toString();
  const episodes = [`${getEpisodeName(node.name, node.size)}\$${url}`];

  vod.vod_play_url = episodes.join("#");
  return {
    list: [vod],
  };
};
const _search = async ({ page, quick, wd }) => {
  const data = await db.all(
    `SELECT
      n.id,
      n.name,
      m.type,
      n.size 
    FROM
      nodes n
      JOIN mounts m ON n.mountId = m.id 
    WHERE
      n.name LIKE ?
      AND n.isDir = 0 
    ORDER BY
      n.name`,
    [`%${wd.trim()}%`]
  );

  const result = {
    list: [],
    page: 1,
    pagecount: 1,
    total: 1,
  };

  for (const row of data) {
    result.list.push({
      vod_id: row.id,
      vod_name: row.name,
      vod_pic: "",
      vod_remarks: row.type,
    });
  }

  result.total = result.list.length;
  return result;
};
const _play = async ({ flag, flags, id }, req) => {
  const url = `${baseUrl(req)}${CryptoJS.enc.Utf8.stringify(
    CryptoJS.enc.Hex.parse(id)
  )}`;

  return {
    url: url,
    header: { token: req.user.token },
    parse: 0,
    jx: 0,
  };
};

const meta = {
  key: "webdav",
  name: "WebDav",
  type: 4,
  api: "/video/webdav", //使用相对地址，服务会自动处理
  searchable: 1,
  quickSearch: 1,
  changeable: 0,
  style: {
    type: "list",
  },
  sort: 1,
};

module.exports = async (app, opt) => {
  app.get(meta.api, async (req, reply) => {
    if (!db) db = app.db;
    if (!webdav) webdav = app.webdav;

    const { extend, filter, t, ac, pg, ext, ids, flag, play, wd, quick } =
      req.query;

    if (play) {
      return await _play({ flag: flag || "", flags: [], id: play }, req);
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
  opt.sites.push(meta);
};
