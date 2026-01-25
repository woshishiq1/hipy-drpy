const axios = require("axios");

const M3U_URL =
  "https://bc.188766.xyz/?url=https://live.188766.xyz&mishitong=true&mima=bingcha1130&huikan=en&json=true";

let cache = {
  time: 0,
  groups: {},
};

const loadM3U = async () => {
  if (Date.now() - cache.time < 10 * 60 * 1000) {
    return cache.groups;
  }

  const res = await axios.get(M3U_URL, {
    timeout: 15000,
    responseType: "text",
  });

  const lines = res.data.split("\n");
  const groups = {};

  let current = null;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    if (line.startsWith("#EXTINF")) {
      current = {
        name: line.split(",").pop()?.trim(),
        logo: line.match(/tvg-logo="(.*?)"/)?.[1] || "",
        group: line.match(/group-title="(.*?)"/)?.[1] || "其他",
        referer: null,
      };
      continue;
    }

    if (current && line.startsWith("#EXTVLCOPT:")) {
      const m = line.match(/referer=(.*)/i);
      if (m) current.referer = m[1];
      continue;
    }

    if (current && line.startsWith("#KODIPROP:")) {
      const m = line.match(/Referer=(.*)/i);
      if (m) current.referer = m[1];
      continue;
    }

    if (current && line.startsWith("http")) {
      if (!groups[current.group]) groups[current.group] = [];

      groups[current.group].push({
        id: `${current.group}_${groups[current.group].length}`,
        name: current.name,
        pic: current.logo,
        play: line,
        referer: current.referer,
      });

      current = null;
    }
  }

  cache = {
    time: Date.now(),
    groups,
  };

  return groups;
};

const _home = async () => {
  const groups = await loadM3U();

  return {
    class: Object.keys(groups).map((g) => ({
      type_id: g,
      type_name: g,
    })),
    list: [],
  };
};

const _category = async ({ id }) => {
  const groups = await loadM3U();
  const list = groups[id] || [];

  return {
    list: list.map((c) => ({
      vod_id: c.id,
      vod_name: c.name,
      vod_pic: c.pic,
      vod_remarks: "直播",
    })),
    page: 1,
    pagecount: 1,
  };
};

const _detail = async ({ id }) => {
  const groups = await loadM3U();
  const list = [];

  for (const g of Object.values(groups)) {
    for (const c of g) {
      if (id.includes(c.id)) {
        const playData = c.referer
          ? JSON.stringify({
              url: c.play,
              referer: c.referer,
            })
          : c.play;

        list.push({
          vod_id: c.id,
          vod_name: c.name,
          vod_pic: c.pic,
          vod_play_from: "直链",
          vod_play_url: `${c.name}$${playData}`,
        });
      }
    }
  }

  return { list };
};

const _play = async ({ id }) => {
  let playUrl = id;
  let headers = {
    "User-Agent": "Mozilla/5.0",
  };

  try {
    const parsed = JSON.parse(id);
    playUrl = parsed.url;
    if (parsed.referer) {
      headers.Referer = parsed.referer;
    }
  } catch {}

  try {
    const resp = await axios.get(playUrl, {
      maxRedirects: 5,
      timeout: 10000,
      headers,
    });

    const realUrl =
      resp.request?.res?.responseUrl || playUrl;

    return {
      parse: 0,
      jx: 0,
      url: realUrl,
      header: headers,
    };
  } catch {
    return {
      parse: 0,
      jx: 0,
      url: playUrl,
      header: headers,
    };
  }
};

const meta = {
  key: "bingcha",
  name: "冰茶TV",
  type: 4,
  api: "/video/bingcha",
  searchable: 0,
  quickSearch: 0,
  changeable: 0,
};

module.exports = async (app, opt) => {
  app.get(meta.api, async (req) => {
    const { ac, t, ids, play } = req.query;

    if (play) return await _play({ id: play });

    if (!ac) return await _home();

    if (ac === "detail" && t)
      return await _category({ id: t });

    if (ac === "detail" && ids)
      return await _detail({ id: ids.split(",") });

    return {};
  });

  opt.sites.push(meta);
};
