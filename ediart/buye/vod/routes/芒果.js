const CryptoJS = require("crypto-js");
const base_host = "https://www.mgtv.com";

// 通用请求头 [1]
const headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
    'Referer': 'https://www.mgtv.com/',
    'Cookie': ''
};

// 解析器配置 [2]
const parsers = [
    { name: "parse_mg1", label: "芒果解析" },
    { name: "parse_tx1", label: "腾讯解析1" },
    { name: "parse_jx1", label: "通用解析1" },
    { name: "parse_jx2", label: "通用解析2" },
    { name: "parse_xmflv", label: "虾米解析" },
    { name: "parse_fish", label: "岁岁解析" },
    { name: "parse_moyu", label: "摸鱼解析" },
];


const classes = [
    { type_id: '3', type_name: '电影' },
    { type_id: '2', type_name: '电视剧' },
    { type_id: '1', type_name: '综艺' },
    { type_id: '50', type_name: '动漫' },
    { type_id: '51', type_name: '纪录片' },
    { type_id: '10', type_name: '少儿' }
];

const filters = {
    '3': [{ key: 'year', name: '年份', value: [{ n: '全部', v: 'all' }, { n: '2025', v: '2025' }, { n: '2024', v: '2024' }, { n: '2023', v: '2023' }, { n: '2022', v: '2022' }, { n: '2021', v: '2021' }, { n: '2020', v: '2020' }] }, { key: 'sort', name: '排序', value: [{ n: '综合', v: 'c1' }, { n: '最新', v: 'c2' }, { n: '最热', v: 'c4' }] }],
    '2': [{ key: 'year', name: '年份', value: [{ n: '全部', v: 'all' }, { n: '2025', v: '2025' }, { n: '2024', v: '2024' }, { n: '2023', v: '2023' }, { n: '2022', v: '2022' }] }, { key: 'sort', name: '排序', value: [{ n: '综合', v: 'c1' }, { n: '最新', v: 'c2' }, { n: '最热', v: 'c4' }] }]
};

const _home = async ({ filter }) => {
    return { class: classes, filters: filters, list: [] };
};

const _category = async ({ id, page, filters }) => {
    const baseUrl = 'https://pianku.api.mgtv.com/rider/list/pcweb/v3';
    const params = new URLSearchParams({
        platform: 'pcweb', channelId: id, pn: page, pc: '20',
        year: filters.year || 'all', sort: filters.sort || 'c2', area: 'a1'
    });
    try {
        const response = await fetch(`${baseUrl}?${params.toString()}`, { headers });
        const json = await response.json();
        const videos = (json.data?.hitDocs || []).map(item => ({
            vod_id: item.playPartId,
            vod_name: item.title,
            vod_pic: item.img,
            vod_remarks: item.updateInfo || item.rightCorner?.text || ''
        }));
        return { list: videos, page: parseInt(page), pagecount: json.data?.totalPage || 1 };
    } catch (e) { return { list: [] }; }
};

const _detail = async ({ id }) => {
    const videoId = id;
    const result = { list: [] };
    try {
        const infoUrl = `https://pcweb.api.mgtv.com/video/info?video_id=${videoId}`;
        const infoResp = await fetch(infoUrl, { headers });
        const infoJson = await infoResp.json();
        const infoData = infoJson.data?.info || {};

        const vod = {
            vod_id: videoId,
            vod_name: infoData.title || '',
            type_name: infoData.root_kind || '',
            vod_year: infoData.release_time || '',
            vod_content: infoData.desc || '',
            vod_pic: infoData.img || '',
        };

        const pageSize = 50;
        let allEpisodes = [];
        const firstPageUrl = `https://pcweb.api.mgtv.com/episode/list?video_id=${videoId}&page=1&size=${pageSize}`;
        const firstResp = await fetch(firstPageUrl, { headers });
        const firstJson = await firstResp.json();

        if (firstJson.data?.list) {
            allEpisodes = firstJson.data.list;
            const totalPage = firstJson.data.total_page || 1;
            if (totalPage > 1) {
                const promises = [];
                for (let i = 2; i <= totalPage; i++) {
                    const pUrl = `https://pcweb.api.mgtv.com/episode/list?video_id=${videoId}&page=${i}&size=${pageSize}`;
                    promises.push(fetch(pUrl, { headers }).then(r => r.json()));
                }
                const results = await Promise.all(promises);
                results.forEach(res => { if (res.data?.list) allEpisodes = allEpisodes.concat(res.data.list); });
            }
        }

        const play_forms = [];
        const play_urls = [];
        const smart_url_list = [];

        if (allEpisodes.length > 0) {
            const validEpisodes = allEpisodes.filter(item => item.isIntact == "1" || item.isIntact == 1);
            
            // 1. 生成智能线路数据 [2]
            validEpisodes.forEach(item => {
                const name = item.t4 || item.t3 || item.title;
                const playLink = `https://www.mgtv.com${item.url}`;
                smart_url_list.push(`${name}$${playLink}`);
            });

            if (smart_url_list.length > 0) {
                play_forms.push("智能线路");
                play_urls.push(smart_url_list.join("#"));
            }

            // 2. 为每个解析器生成独立线路 [2]
            for (const parser of parsers) {
                play_forms.push(`芒果-${parser.label}`);
                play_urls.push(smart_url_list.join("#"));
            }
        }

        vod.vod_play_from = play_forms.join("$$$");
        vod.vod_play_url = play_urls.join("$$$");
        result.list.push(vod);
    } catch (e) { console.error('详情获取失败', e); }
    return result;
};

const _search = async ({ page, wd }) => {
    const searchUrl = `https://mobileso.bz.mgtv.com/msite/search/v2?q=${encodeURIComponent(wd)}&pn=${page}&pc=20`;
    try {
        const response = await fetch(searchUrl, { headers });
        const json = await response.json();
        const videos = [];
        if (json.data?.contents) {
            for (const group of json.data.contents) {
                if (group.type === 'media' && group.data) {
                    for (const item of group.data) {
                        if (item.source === 'imgo') {
                            const match = item.url.match(/\/(\d+)\.html/);
                            if (match) {
                                videos.push({
                                    vod_id: match[1],
                                    vod_name: item.title.replace(/<B>|<\/B>/g, ''),
                                    vod_pic: item.img,
                                    vod_remarks: item.desc ? item.desc.join(' ') : ''
                                });
                            }
                        }
                    }
                }
            }
        }
        return { list: videos, page: parseInt(page), pagecount: 10 };
    } catch (e) { return { list: [] }; }
};

const _play = async ({ flag, id, parser }, app) => {
    // 智能线路处理逻辑：遍历解析器 [2]
    if (flag === "智能线路") {
        const urls = id.split('|||'); // 如果有多源则切分，芒果通常为单源
        for (const url of urls) {
            for (const p of parsers) {
                if (app[p.name]) {
                    try {
                        const res = await app[p.name]({ flag, id: url });
                        if (res && res.url) return res;
                    } catch (e) {}
                }
            }
        }
        return { url: urls[0], parse: 1, jx: 1 };
    }

    // 指定线路处理 [2]
    let selectedParser = parser;
    if (!selectedParser && flag.includes('-')) {
        const labelPart = flag.split('-')[1].trim();
        const p = parsers.find(it => it.label === labelPart);
        if (p) selectedParser = p.name;
    }

    if (selectedParser && app[selectedParser]) {
        try {
            const res = await app[selectedParser]({ flag, id });
            if (res?.url) return res;
        } catch (e) {}
    }

    return { parse: 1, jx: 1, url: id, header: headers };
};

const meta = {
    key: "mgtv",
    name: "芒果TV",
    type: 4,
    api: "/video/mgtv",
    searchable: 2,
    quickSearch: 0,
    changeable: 0,
};

module.exports = async (app, opt) => {
    app.get(meta.api, async (req, reply) => {
        const { t, ac, pg, ext, ids, flag, play, wd, parser } = req.query;
        if (play) {
            return await _play({ flag: flag || "", id: play, parser }, req.server);
        } else if (wd) {
            return await _search({ page: pg || "1", wd });
        } else if (ac === "detail") {
            if (t) {
                let filterObj = {};
                if (ext) {
                    try { filterObj = JSON.parse(CryptoJS.enc.Base64.parse(ext).toString(CryptoJS.enc.Utf8)); } catch {}
                }
                return await _category({ id: t, page: pg || "1", filters: filterObj });
            } else if (ids) {
                return await _detail({ id: ids.split(",")[0] });
            }
        } else {
            return await _home({ filter: false });
        }
    });
    opt.sites.push(meta);
};