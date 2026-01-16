const CryptoJS = require("crypto-js");
const base_host = "https://v.qq.com";
const header = {
    'User-Agent': 'PC_UA'
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

const _home = async ({ filter }) => {
    const homeUrl = '/x/bu/pagesheet/list?_all=1&append=1&channel=cartoon&listpage=1&offset=0&pagesize=21&iarea=-1&sort=18';
    const response = await fetch(`${base_host}${homeUrl}`, { headers: header });
    const html = await response.text();
    const videos = [];
    const listItems = html.match(/<div[^>]*class=["']?list_item["']?[^>]*>([\s\S]*?)<\/div>/gi) || [];
    for (const item of listItems) {
        const titleMatch = item.match(/<img[^>]*alt=["']?([^"']*)["']?/i);
        const picMatch = item.match(/<img[^>]*src=["']?([^"'\s>]+)["']?/i);
        const descMatch = item.match(/<a[^>]*>([\s\S]*?)<\/a>/i);
        const urlMatch = item.match(/<a[^>]*data-float=["']?([^"'\s>]+)["']?/i);
        if (titleMatch && picMatch) {
            videos.push({
                vod_id: urlMatch ? urlMatch[1] : '',
                vod_name: titleMatch[1] || '',
                vod_pic: picMatch[1] || '',
                vod_remarks: descMatch ? descMatch[1].replace(/<[^>]*>/g, '').trim() : ''
            });
        }
    }
    return {
        class: [
            { type_id: 'choice', type_name: '精选' },
            { type_id: 'movie', type_name: '电影' },
            { type_id: 'tv', type_name: '电视剧' },
            { type_id: 'variety', type_name: '综艺' },
            { type_id: 'cartoon', type_name: '动漫' },
            { type_id: 'child', type_name: '少儿' },
            { type_id: 'doco', type_name: '纪录片' }
        ],
        list: videos.slice(0, 20)
    };
};

const _category = async ({ id, page, filter, filters }) => {
    const offset = (parseInt(page) - 1) * 21;
    let url = `${base_host}/x/bu/pagesheet/list?_all=1&append=1&channel=${id}&listpage=1&offset=${offset}&pagesize=21&iarea=-1`;
    if (filters && filters.sort) url += `&sort=${filters.sort}`;
    if (filters && filters.iyear) url += `&iyear=${filters.iyear}`;
    if (filters && filters.year) url += `&year=${filters.year}`;
    if (filters && filters.type) url += `&itype=${filters.type}`;
    if (filters && filters.feature) url += `&ifeature=${filters.feature}`;
    if (filters && filters.area) url += `&iarea=${filters.area}`;
    if (filters && filters.itrailer) url += `&itrailer=${filters.itrailer}`;
    if (filters && filters.sex) url += `&gender=${filters.sex}`;

    const response = await fetch(url, { headers: header });
    const html = await response.text();
    const videos = [];
    const listItems = html.match(/<div[^>]*class=["']?list_item["']?[^>]*>([\s\S]*?)<\/div>/gi) || [];
    for (const item of listItems) {
        const titleMatch = item.match(/<img[^>]*alt=["']?([^"']*)["']?/i);
        const picMatch = item.match(/<img[^>]*src=["']?([^"'\s>]+)["']?/i);
        const descMatch = item.match(/<a[^>]*>([\s\S]*?)<\/a>/i);
        const urlMatch = item.match(/<a[^>]*data-float=["']?([^"'\s>]+)["']?/i);
        if (titleMatch && picMatch) {
            videos.push({
                vod_id: `${id}$${urlMatch ? urlMatch[1] : ''}`,
                vod_name: titleMatch[1] || '',
                vod_pic: picMatch[1] || '',
                vod_remarks: descMatch ? descMatch[1].replace(/<[^>]*>/g, '').trim() : ''
            });
        }
    }
    return {
        list: videos,
        page: parseInt(page),
        pagecount: 9999,
        limit: 21,
        total: 999999
    };
};

const _getBatchVideoInfo = async (vids) => {
    const results = [];
    const batches = [];
    for (let i = 0; i < vids.length; i += 30) {
        batches.push(vids.slice(i, i + 30));
    }
    for (const batch of batches) {
        const url = `https://union.video.qq.com/fcgi-bin/data?otype=json&tid=1804&appid=20001238&appkey=6c03bbe9658448a4&union_platform=1&idlist=${batch.join(",")}`;
        try {
            const response = await fetch(url, { headers: header });
            const text = await response.text();
            const jsonString = text.replace(/^QZOutputJson=/, '').replace(/;$/, '');
            const json = JSON.parse(jsonString);
            if (json.results) {
                json.results.forEach(item => {
                    const fields = item.fields;
                    results.push({
                        vid: fields.vid,
                        title: fields.title,
                        type: fields.category_map && fields.category_map.length > 1 ? fields.category_map[1] : ""
                    });
                });
            }
        } catch (e) {
            console.error('批量获取视频详情失败:', e);
        }
    }
    return results;
};

const _detail = async ({ id }) => {
    const result = { list: [] };
    for (const id_ of id) {
        const [cid, sourceId] = id_.split('$');
        const targetCid = sourceId || cid;
        const detailUrl = `https://node.video.qq.com/x/api/float_vinfo2?cid=${targetCid}`;
        try {
            const response = await fetch(detailUrl, { headers: header });
            const json = await response.json();
            const vod = {
                vod_id: id_,
                vod_name: json.c?.title || '',
                type_name: json.typ?.join(",") || '',
                vod_actor: json.nam?.join(",") || '',
                vod_year: json.c?.year || '',
                vod_content: json.c?.description || '',
                vod_remarks: json.rec || '',
                vod_pic: json.c?.pic ? new URL(json.c.pic, base_host).href : '',
                vod_play_from: '',
                vod_play_url: ''
            };

            const videoIds = json.c?.video_ids || [];
            if (videoIds.length > 0) {
                const videoDetails = await _getBatchVideoInfo(videoIds);
                const orderedDetails = videoIds.map(vid => {
                    return videoDetails.find(v => v.vid === vid) || { vid: vid, title: '', type: '' };
                });

                const zhengPian = orderedDetails.filter(it => !it.type || it.type === "正片");
                const yuGao = orderedDetails.filter(it => it.type && it.type !== "正片");

                const formatUrlList = (items) => {
                    return items.map(it => {
                        let displayTitle = it.title ? it.title.trim() : "选集";
                        if (/^\d+$/.test(displayTitle)) displayTitle = `第${displayTitle}集`;
                        const playUrl = `${base_host}/x/cover/${targetCid}/${it.vid}.html`.trim();
                        return `${displayTitle}$${playUrl}`;
                    });
                };

                const zhengPianList = formatUrlList(zhengPian);
                const yuGaoList = formatUrlList(yuGao);

                const play_forms = [];
                const play_urls = [];

                // 1. 生成智能线路 (正片) [2]
                if (zhengPianList.length > 0) {
                    play_forms.push("智能线路");
                    // 智能线路格式: 标题$URL1|||URL2... (腾讯单源此处通常只有一个URL，但结构保持一致)
                    play_urls.push(zhengPianList.join("#"));

                    // 2. 生成各解析器线路 (正片) [2]
                    for (const parser of parsers) {
                        play_forms.push(`qq-${parser.label}`);
                        play_urls.push(zhengPianList.join("#"));
                    }
                }

                // 3. 生成花絮线路
                if (yuGaoList.length > 0) {
                    play_forms.push("花絮/预告");
                    play_urls.push(yuGaoList.join("#"));
                }

                vod.vod_play_from = play_forms.join("$$$");
                vod.vod_play_url = play_urls.join("$$$");
            }
            result.list.push(vod);
        } catch (error) {
            console.error('获取详情失败:', error);
        }
    }
    return result;
};

const _search = async ({ page, quick, wd }) => {
    const url = 'https://pbaccess.video.qq.com/trpc.videosearch.mobile_search.MultiTerminalSearch/MbSearch?vplatform=2';
    const headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.139 Safari/537.36',
        'Content-Type': 'application/json',
        'Origin': 'https://v.qq.com',
        'Referer': 'https://v.qq.com/'
    };
    const payload = {
        "version": "25042201", "clientType": 1, "query": wd, "pagenum": parseInt(page) - 1, "pagesize": 30,
        "extraInfo": { "isNewMarkLabel": "1", "multi_terminal_pc": "1", "themeType": "1" }
    };
    try {
        const response = await fetch(url, { method: 'POST', headers: headers, body: JSON.stringify(payload) });
        const json = await response.json();
        const videos = [];
        const processItem = (it) => {
            if (it?.doc?.id && it.videoInfo) {
                if (it.doc.id.length > 11) {
                    videos.push({
                        vod_id: it.doc.id,
                        vod_name: it.videoInfo.title ? it.videoInfo.title.replace(/<\/?em>/g, '') : '',
                        vod_pic: it.videoInfo.imgUrl || '',
                        vod_remarks: it.videoInfo.firstLine || it.videoInfo.secondLine || ''
                    });
                }
            }
        };
        if (json.data?.normalList?.itemList) json.data.normalList.itemList.forEach(processItem);
        if (json.data?.areaBoxList) json.data.areaBoxList.forEach(area => area.itemList?.forEach(processItem));
        return { list: videos, page: parseInt(page), pagecount: videos.length >= 20 ? parseInt(page) + 1 : parseInt(page), limit: 30, total: 999 };
    } catch (error) {
        return { list: [], page: 1, pagecount: 1, limit: 30, total: 0 };
    }
};

const _play = async ({ flag, flags, id, parser }, app) => {
    // 智能线路处理逻辑 [2]
    if (flag === "智能线路") {
        const urls = id.split('|||'); 
        for (const url of urls) {
            for (const p of parsers) {
                if (app[p.name]) {
                    try {
                        const res = await app[p.name]({ flag, flags, id: url });
                        if (res && res.url) return res;
                    } catch (e) {}
                }
            }
        }
        return { url: urls[0], parse: 1, jx: 1 };
    }

    // 处理指定解析器线路 (如 qq-芒果解析) [2]
    if (!parser && flag && flag.includes('-')) {
        const labelPart = flag.split('-')[1].trim().toLowerCase();
        for (const p of parsers) {
            if (p.label.toLowerCase().includes(labelPart)) {
                parser = p.name;
                break;
            }
        }
    }

    if (parser && app[parser]) {
        try {
            const res = await app[parser]({ flag, flags, id: id });
            if (res?.url) return res;
        } catch (e) {}
    }

    // 保底尝试 [1]
    const fallbackParsers = [app.parse_tx1, app.parse_jx1, app.parse_jx2, app.parse_xmflv];
    for (const parse of fallbackParsers) {
        if (parse) {
            try {
                const res = await parse({ flag, flags, id });
                if (res?.url) return res;
            } catch (e) {}
        }
    }

    return { parse: 1, jx: 1, url: id, header: header };
};

const meta = {
    key: "tengxun",
    name: "腾讯视频",
    type: 4,
    api: "/video/tengxun",
    searchable: 2,
    quickSearch: 0,
    changeable: 0,
};

module.exports = async (app, opt) => {
    app.get(meta.api, async (req, reply) => {
        const { extend, filter, t, ac, pg, ext, ids, flag, play, wd, quick, parser } = req.query;
        if (play) {
            return await _play({ flag: flag || "", flags: [], id: play, parser }, req.server);
        } else if (wd) {
            return await _search({ page: parseInt(pg || "1"), quick: quick || false, wd });
        } else if (!ac) {
            return await _home({ filter: filter ?? false });
        } else if (ac === "detail") {
            if (t) {
                return await _category({ id: t, page: parseInt(pg || "1"), filter: filter || false, filters: {} });
            } else if (ids) {
                return await _detail({ id: ids.split(",").map(i => i.trim()).filter(Boolean) });
            }
        }
        return req.query;
    });
    opt.sites.push(meta);
};