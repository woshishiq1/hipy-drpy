const server = {}; //这里不要动，加空格都不行，后台自动生成

async function getConfig() {
  const { data } = await $fetch.get(server.url, {
    headers: server.headers,
  });
  const json = argsify(data);

  const ret = {
    ver: 1,
    title: "",
    site: "",
    tabs: [],
  };
  for (const c of json.class || []) {
    ret.tabs.push({
      name: c.type_name,
      ext: {
        id: c.type_id,
      },
    });
  }
  return jsonify(ret);
}

async function getCards(ext) {
  const { id, page = 1 } = argsify(ext);
  const url = `${server.url}?ac=detail&t=${encodeURIComponent(id)}&pg=${page}`;
  const { data } = await $fetch.get(url, {
    headers: server.headers,
  });
  const json = argsify(data);
  for (const v of json.list || []) {
    if (typeof v.vod_id === "number") v.vod_id = `${v.vod_id}`;
    v.ext = {
      id: v.vod_id,
    };
  }
  return jsonify({
    list: json.list || [],
  });
}

async function getTracks(ext) {
  const { id } = argsify(ext);
  const url = `${server.url}?ac=detail&ids=${encodeURIComponent(id)}`;
  const { data } = await $fetch.get(url, {
    headers: server.headers,
  });
  const json = argsify(data);
  const vod = json["list"][0];

  const play_url = vod.vod_play_url.split("$$$");

  const ret = [];
  vod.vod_play_from.split("$$$").forEach((pf) =>
    ret.push({
      title: pf,
      tracks: [],
    })
  );

  for (let i = 0; i < ret.length; i++) {
    const pf = ret[i];
    const tracks = pf.tracks;
    play_url[i].split("#").forEach((u) => {
      const tmp = u.split(/\$/g);
      tracks.push({
        name: tmp[0],
        pan: "", // 网盘
        ext: {
          flag: pf.title,
          play: tmp[1],
        },
      });
    });
  }

  return jsonify({
    list: ret,
  });
}

async function getPlayinfo(ext) {
  const { flag, play } = argsify(ext);
  const url = `${server.url}?flag=${encodeURIComponent(
    flag
  )}&play=${encodeURIComponent(play)}`;
  const { data } = await $fetch.get(url, {
    headers: server.headers,
  });
  const json = argsify(data);
  const ret = {
    urls: [],
    headers: [json.header ?? {}],
  };

  if (Array.isArray(json.url)) {
    for (let i = 0; i < json.url.length; i += 2) {
      if (/^代理/i.test(json.url[i])) continue;
      ret.urls.push(json.url[i + 1]);
    }
  } else {
    ret.urls.push(json.url);
  }

  return jsonify(ret);
}

async function search(ext) {
  const { text, page } = argsify(ext);
  if (page > 1) {
    return jsonify({ list: [] });
  }

  const url = `${server.url}?wd=${encodeURIComponent(text)}`;
  const { data } = await $fetch.get(url, {
    headers: server.headers,
  });
  const json = argsify(data);
  for (const v of json.list || []) {
    if (typeof v.vod_id === "number") v.vod_id = `${v.vod_id}`;
    v.ext = {
      id: v.vod_id,
    };
  }
  return jsonify({
    list: json.list || [],
  });
}
