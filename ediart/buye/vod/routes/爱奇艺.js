const CryptoJS = require("crypto-js");
const base_host = "https://www.iqiyi.com";

// 定义通用请求头 [1]
const headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
    'Referer': 'https://www.iqiyi.com/'
};

// 解析器列表配置 [2]
const parsers = [
  { name: "parse_mg1", label: "芒果解析" },
  { name: "parse_tx1", label: "腾讯解析1" },
  { name: "parse_jx1", label: "通用解析1" },
  { name: "parse_jx2", label: "通用解析2" },
  { name: "parse_xmflv", label: "虾米解析" },
  { name: "parse_fish", label: "岁岁解析" },
  { name: "parse_moyu", label: "摸鱼解析" },
];

// 爱奇艺分类配置 [1]
const classes = [
    { type_id: '1', type_name: '电影' },
    { type_id: '2', type_name: '电视剧' },
    { type_id: '6', type_name: '综艺' },
    { type_id: '4', type_name: '动漫' },
    { type_id: '3', type_name: '纪录片' },
    { type_id: '5', type_name: '音乐' },
    { type_id: '16', type_name: '网络电影' }
];

// 筛选配置 [1]
const filters = {
    '1': [{ key: 'year', name: '年代', value: [{ n: '全部', v: '' }, { n: '2025', v: '2025' }, { n: '2024', v: '2024' }, { n: '2023', v: '2023' }] }],
    '2': [{ key: 'year', name: '年代', value: [{ n: '全部', v: '' }, { n: '2025', v: '2025' }, { n: '2024', v: '2024' }, { n: '2023', v: '2023' }] }]
};

const _home = async ({ filter }) => {
    return {
        class: classes,
        filters: filters,
        list: []
    };
};

const _category = async ({ id, page, filter, filters }) => {
    let channelId = id;
    let dataType = 1;
    let extraParams = "";

    if (id === "16") {
        channelId = "1";
        extraParams = "&three_category_id=27401";
    } else if (id === "5") {
        dataType = 2;
    }

    if (filters && filters.year) {
        extraParams += `&market_release_date_level=${filters.year}`;
    }

    const url = `https://pcw-api.iqiyi.com/search/recommend/list?channel_id=${channelId}&data_type=${dataType}&page_id=${page}&ret_num=24${extraParams}`;
    try {
        const response = await fetch(url, { headers });
        const json = await response.json();
        const videos = [];

        if (json.data && json.data.list) {
            for (const item of json.data.list) {
                const vid = `${item.channelId}$${item.albumId}`;
                let remarks = "";
                if (item.channelId === 1) {
                    remarks = item.score ? `${item.score}分` : "";
                } else if (item.channelId === 2 || item.channelId === 4) {
                    if (item.latestOrder && item.videoCount) {
                        remarks = item.latestOrder === item.videoCount ? `${item.latestOrder}集全` : `更新至${item.latestOrder}集`;
                    } else {
                        remarks = item.focus || "";
                    }
                } else {
                    remarks = item.period || item.focus || "";
                }

                videos.push({
                    vod_id: vid,
                    vod_name: item.name,
                    vod_pic: item.imageUrl ? item.imageUrl.replace(".jpg", "_390_520.jpg") : "",
                    vod_remarks: remarks
                });
            }
        }
        return {
            list: videos,
            page: parseInt(page),
            pagecount: 999,
            limit: 24,
            total: 9999
        };
    } catch (e) {
        return { list: [] };
    }
};

const _detail = async ({ id }) => {
    let channelId = "";
    let albumId = id;
    if (id.includes('$')) {
        const parts = id.split('$');
        channelId = parts[0];
        albumId = parts[1];
    }

    const result = { list: [] };

    try {
        const infoUrl = `https://pcw-api.iqiyi.com/video/video/videoinfowithuser/${albumId}?agent_type=1&authcookie=&subkey=${albumId}&subscribe=1`;
        const infoResp = await fetch(infoUrl, { headers });
        const infoJson = await infoResp.json();
        const data = infoJson.data || {};

        const vod = {
            vod_id: id,
            vod_name: data.name || '',
            type_name: data.categories ? data.categories.map(it => it.name).join(',') : '',
            vod_actor: data.people && data.people.main_charactor ? data.people.main_charactor.map(it => it.name).join(',') : '',
            vod_year: data.formatPeriod || '',
            vod_content: data.description || '',
            vod_remarks: data.latestOrder ? `更新至${data.latestOrder}集` : (data.period || ''),
            vod_pic: data.imageUrl ? data.imageUrl.replace(".jpg", "_480_270.jpg") : '',
            vod_play_from: '',
            vod_play_url: ''
        };

        let playlists = [];
        const cid = parseInt(channelId || data.channelId || 0);

        if (cid === 1 || cid === 5) {
            playlists.push({ title: data.name, url: data.playUrl });
        } else if (cid === 6 && data.period) {
            let qs = data.period.toString().split("-")[0];
            let listUrl = `https://pcw-api.iqiyi.com/album/source/svlistinfo?cid=6&sourceid=${albumId}&timelist=${qs}`;
            try {
                const listResp = await fetch(listUrl, { headers });
                const listJson = await listResp.json();
                if (listJson.data && listJson.data[qs]) {
                    listJson.data[qs].forEach(it => {
                        playlists.push({ title: it.shortTitle || it.period || it.focus, url: it.playUrl });
                    });
                }
            } catch (e) { }
        } else {
            let listUrl = `https://pcw-api.iqiyi.com/albums/album/avlistinfo?aid=${albumId}&size=200&page=1`;
            const listResp = await fetch(listUrl, { headers });
            const listJson = await listResp.json();
            if (listJson.data && listJson.data.epsodelist) {
                playlists = playlists.concat(listJson.data.epsodelist);
                const total = listJson.data.total;
                if (total > 200) {
                    const totalPages = Math.ceil(total / 200);
                    for (let i = 2; i <= totalPages; i++) {
                        let nextUrl = `https://pcw-api.iqiyi.com/albums/album/avlistinfo?aid=${albumId}&size=200&page=${i}`;
                        try {
                            const nextResp = await fetch(nextUrl, { headers });
                            const nextJson = await nextResp.json();
                            if (nextJson.data && nextJson.data.epsodelist) {
                                playlists = playlists.concat(nextJson.data.epsodelist);
                            }
                        } catch (e) { }
                    }
                }
            }
        }

        // 格式化播放列表数据 [1]
        const cleanList = playlists.map(it => {
            let title = it.title || it.shortTitle || (it.order ? `第${it.order}集` : "");
            return `${title}$${it.playUrl || it.url}`;
        });

        // 参考 360 影视实现多线路 [2]
        const play_forms = [];
        const play_urls = [];
        const play_data = cleanList.join('#');

        // 1. 注入智能线路
        play_forms.push("智能线路");
        play_urls.push(play_data);

        // 2. 注入各解析器线路
        for (const p of parsers) {
            play_forms.push(`爱奇艺-${p.label}`);
            play_urls.push(play_data);
        }

        vod.vod_play_from = play_forms.join('$$$');
        vod.vod_play_url = play_urls.join('$$$');
        result.list.push(vod);

    } catch (e) {
        console.error('详情获取失败', e);
    }
    return result;
};

const _search = async ({ page, quick, wd }) => {
    const url = `https://search.video.iqiyi.com/o?if=html5&key=${encodeURIComponent(wd)}&pageNum=${page}&pos=1&pageSize=24&site=iqiyi`;
    try {
        const response = await fetch(url, { headers });
        const json = await response.json();
        const videos = [];
        if (json.data && json.data.docinfos) {
            for (const item of json.data.docinfos) {
                if (item.albumDocInfo) {
                    const doc = item.albumDocInfo;
                    const channelId = doc.channel ? doc.channel.split(',')[0] : '0';
                    videos.push({
                        vod_id: `${channelId}$${doc.albumId}`,
                        vod_name: doc.albumTitle || '',
                        vod_pic: doc.albumVImage || '',
                        vod_remarks: doc.tvFocus || ''
                    });
                }
            }
        }
        return { list: videos, page: parseInt(page), pagecount: 10, limit: 24, total: videos.length };
    } catch (e) {
        return { list: [] };
    }
};

const _play = async ({ flag, flags, id, parser }, app) => {
    // 智能线路处理逻辑 [2]
    if (flag === "智能线路") {
        const urls = id.split('|||'); // 爱奇艺目前通常为单 URL，但结构上保持一致
        for (const url of urls) {
            for (const p of parsers) {
                if (app[p.name]) {
                    try {
                        const res = await app[p.name]({ flag, flags, id: url });
                        if (res && res.url) return res;
                    } catch (e) { }
                }
            }
        }
        return { url: urls[0], parse: 1, jx: 1 };
    }

    // 处理指定解析线路 [2]
    if (!parser && flag && flag.includes('-')) {
        const labelPart = flag.split('-')[1].trim();
        for (const p of parsers) {
            if (p.label === labelPart) {
                parser = p.name;
                break;
            }
        }
    }

    if (parser && app[parser]) {
        try {
            const res = await app[parser]({ flag, flags, id });
            if (res && res.url) return res;
        } catch (e) { }
    }

    // 默认回退逻辑 [1]
    return { parse: 1, jx: 1, url: id, header: headers };
};

const meta = {
    key: "iqiyi",
    name: "爱奇艺",
    type: 4,
    api: "/video/iqiyi",
    searchable: 2,
    quickSearch: 0,
    changeable: 0,
};

module.exports = async (app, opt) => {
    app.get(meta.api, async (req, reply) => {
        const { t, ac, pg, ext, ids, flag, play, wd, quick, parser } = req.query;
        if (play) {
            return await _play({ flag: flag || "", flags: [], id: play, parser }, req.server);
        } else if (wd) {
            return await _search({ page: parseInt(pg || "1"), wd });
        } else if (!ac) {
            return await _home({ filter: false });
        } else if (ac === "detail") {
            if (t) {
                return await _category({ id: t, page: parseInt(pg || "1") });
            } else if (ids) {
                return await _detail({ id: ids.split(",")[0] });
            }
        }
        return req.query;
    });
    opt.sites.push(meta);
};