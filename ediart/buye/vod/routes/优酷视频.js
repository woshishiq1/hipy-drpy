const axios = require("axios");
const http = require("http");
const https = require("https");

const _http = axios.create({
    timeout: 10 * 1000,
    httpsAgent: new https.Agent({ keepAlive: true, rejectUnauthorized: false }),
    httpAgent: new http.Agent({ keepAlive: true }),
});

const config = {
    host: 'https://www.youku.com',
    headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Referer': 'https://www.youku.com'
    }
};

// 解析器列表配置
const parsers = [
  { name: "parse_mg1", label: "芒果解析" },
  { name: "parse_tx1", label: "腾讯解析1" },
  { name: "parse_jx1", label: "通用解析1" },
  { name: "parse_jx2", label: "通用解析2" },
  { name: "parse_xmflv", label: "虾米解析" },
  { name: "parse_fish", label: "岁岁解析" },
  { name: "parse_moyu", label: "摸鱼解析" },
];
let sessionStore = {};

const json2vods = (lists) => {
    return (lists || []).map(it => {
        let vid = "";
        if (it.videoLink && it.videoLink.includes("id_")) {
            vid = it.videoLink.split("id_")[1].split(".html")[0];
        } else {
            vid = "msearch:" + it.title;
        }
        return {
            vod_id: vid,
            vod_name: it.title,
            vod_pic: it.img,
            vod_remarks: it.summary,
            vod_content: it.subTitle
        };
    });
};

const getClasses = async () => {
    const categories = '电视剧&电影&综艺&动漫&少儿&纪录片&文化&亲子&教育&搞笑&生活&体育&音乐&游戏'.split('&');
    return categories.map(name => ({
        type_id: name,
        type_name: name
    }));
};

const getCategoryList = async (tid, pg = 1, filter = "") => {
    try {
        let filterObj = filter ? JSON.parse(filter) : {};
        filterObj.type = tid;
        const paramsStr = JSON.stringify(filterObj);

        let url = `https://www.youku.com/category/data?optionRefresh=1&pageNo=${pg}&params=${encodeURIComponent(paramsStr)}`;

        if (pg > 1 && sessionStore[tid]) {
            url = url.replace("optionRefresh=1", `session=${encodeURIComponent(sessionStore[tid])}`);
        }

        const res = await _http.get(url, { headers: config.headers });
        const resData = res.data.data.filterData;

        if (resData.session) {
            sessionStore[tid] = JSON.stringify(resData.session);
        }

        return {
            list: json2vods(resData.listData),
            page: pg,
            limit: 20
        };
    } catch (e) {
        store.log.error("分类列表获取失败:", e.message);
        return { list: [] };
    }
};

function safeFixYoukuInitialData(rawStr) {
    if (!rawStr) return '{}';
    let s = rawStr
        .replace(/^[\s\S]*?window\.__INITIAL_DATA__\s*[=:]\s*/, '')
        .replace(/;[\s\S]*$/, '')
        .replace(/\.{3,}[\s\S]*$/, '')
        .replace(/,\s*$/, '')
        .trim();

    if (!s || s.length < 2 || !/^\{/.test(s)) {
        return '{}';
    }

    let open = 0, close = 0;
    for (let char of s) {
        if (char === '{') open++;
        if (char === '}') close++;
    }

    if (open > close) {
        s += '}'.repeat(open - close);
    }
    if (!s.startsWith('{')) {
        s = '{' + s;
    }
    if (!s.endsWith('}')) {
        s += '}';
    }

    return s;
}

function getSafe(obj, path, defaultValue = '') {
    if (!obj || typeof obj !== 'object') return defaultValue;
    try {
        return path.split('.').reduce((o, key) => {
            if (o == null) throw new Error('null');
            return o[key];
        }, obj) ?? defaultValue;
    } catch {
        return defaultValue;
    }
}

const getDetail = async (id) => {
    const api = `https://search.youku.com/api/search?appScene=show_episode&showIds=${id}`;
    const res = await _http.get(api, { headers: config.headers });
    const json = res.data;
    const video_lists = json.serisesList || [];

    let vod = {
        vod_id: id,
        vod_name: "未知标题",
        vod_pic: "",
        vod_type: "",
        vod_remarks: "",
        vod_content: "暂无简介",
        vod_play_from: "优酷",
        vod_play_url: ""
    };

    try {
        if (video_lists?.length > 0) {
            const playUrls = video_lists.map(it => {
                const title = it.showVideoStage?.replace("期", "集") ||
                    it.displayName ||
                    it.title ||
                    `第${it.index || '?'}集`;
                return `${title}$${`https://v.youku.com/v_show/id_${it.videoId}.html`}`;
            }).filter(Boolean);

            if (playUrls.length > 0) {
                const play_forms = [];
                const play_urls = [];
                const rawUrlStr = playUrls.join("#");

                // --- 新增：智能线路 (参考 movie360) ---
                // 放在第一个位置，默认首选
                play_forms.push("智能线路");
                play_urls.push(rawUrlStr);

                // --- 现有：手动选择线路 ---
                for (const parser of parsers) {
                    play_forms.push(`优酷-${parser.label}`);
                    play_urls.push(rawUrlStr);
                }

                vod.vod_play_from = play_forms.join("$$$");
                vod.vod_play_url = play_urls.join("$$$");
            }
        }

        const detailUrl = `https://v.youku.com/v_show/id_${id}.html`;
        const htmlRes = await _http.get(detailUrl, {
            headers: {
                ...config.headers,
                'Referer': 'https://v.youku.com/'
            }
        });
        const html = htmlRes.data;

        if (html.includes("人机验证") || html.includes("captcha") || html.includes("verify")) {
            vod.vod_content = "触发优酷人机验证,建议在浏览器中访问优酷官网解除限制后再重试";
            store.log.error("触发优酷人机验证,建议在浏览器中访问优酷官网解除限制后再重试")
            return vod;
        }

        if (html.includes("window.__INITIAL_DATA__ =")) {
            let dataStr = html.split("window.__INITIAL_DATA__ =")[1]?.split(";")?.[0]?.trim() || '{}';
            dataStr = safeFixYoukuInitialData(dataStr);

            let detailJson;
            try {
                detailJson = JSON.parse(dataStr);
            } catch (parseErr) {
                store.log.error(`[Youku] JSON.parse 失败 → id:${id} 错误: ${parseErr.message.slice(0, 120)}`);
                return vod;
            }

            const item = getSafe(detailJson, 'moduleList.0.components.0.itemList.0', {});
            const extra = getSafe(detailJson, 'pageMap.extra', {});

            vod.vod_name = item.introTitle || extra.showName || video_lists?.[0]?.title || vod.vod_name;
            vod.vod_pic = item.showImgV || extra.showImgV || extra.showImg || vod.vod_pic;
            vod.vod_type = item.showGenre || extra.videoCategory || "";
            vod.vod_remarks = item.introSubTitle || extra.showSubtitle || item.mark?.text || vod.vod_remarks;
        } else {
            vod.vod_name = video_lists[0].title?.split(" ")[0];
            vod.vod_content = [
                vod.vod_remarks || "",
                `类型:${vod.vod_type || "未知"}`,
                video_lists.length ? `共${video_lists.length}集` : "",
                "来源:优酷"
            ].filter(Boolean).join(" | ");
        }

    } catch (e) {
        store.log.error(`[Youku getDetail] 网络/解析异常 → id:${id}`, e.message);
        vod.vod_content = `获取详情失败:${e.message.slice(0, 80)}`;
    }

    return vod;
};

const getPlayUrl = async (url) => {
    return {
        parse: 1,
        url: url,
        header: config.headers
    };
};

const search = async (wd, pg = 1) => {
    try {
        const url = `https://search.youku.com/api/search?pg=${pg}&keyword=${encodeURIComponent(wd)}`;
        const res = await _http.get(url, { headers: config.headers });
        const lists = [];

        res.data.pageComponentList.forEach(it => {
            if (it.commonData) {
                const data = it.commonData;
                lists.push({
                    vod_id: data.showId,
                    vod_name: data.titleDTO.displayName,
                    vod_pic: data.posterDTO.vThumbUrl,
                    vod_remarks: data.stripeBottom,
                    vod_content: data.updateNotice
                });
            }
        });

        return { list: lists };
    } catch (e) {
        return { list: [] };
    }
};

const handleT4Request = async (req) => {
    const { ac, t, ids, play, pg, flag, wd } = req.query;
    if (play) {
        return await _play({ flag: flag || "", flags: [], id: play }, req.server);
    }
    if (ids) {
        const detail = await getDetail(ids);
        return { list: detail ? [detail] : [] };
    }
    if (wd) {
        return await search(wd, pg || 1);
    }
    if (t) {
        return await getCategoryList(t, pg || 1);
    }
    if (!ac || ac === 'class') {
        return { class: await getClasses() };
    }
    return { list: [] };
};

const _play = async ({ flag, flags, id }, app) => {
    // 1. 智能线路逻辑 (参考 movie360)
    // 自动尝试 parsers 列表中的所有解析器，直到有一个成功
    if (flag === "智能线路") {
        for (const parser of parsers) {
            if (app[parser.name]) {
                try {
                    // store.log.info(`[优酷] 智能线路尝试: ${parser.label}`);
                    const res = await app[parser.name]({ flag, flags, id });
                    if (res && res.url) {
                        return res; // 成功则直接返回
                    }
                } catch (e) {
                    // 当前解析器失败，继续尝试下一个
                }
            }
        }
        // 所有解析器都失败，返回原链接（交给壳处理或报错）
        return {
            parse: 1,
            jx: 1,
            url: id,
            header: config.headers
        };
    }

    // 2. 手动指定线路逻辑 (如 "优酷-虾米解析")
    let selectedParser = null;
    if (flag) {
        const parts = flag.split('-');
        if (parts.length >= 2) {
            const labelPart = parts[1].trim();
            const target = parsers.find(p => p.label === labelPart);
            if (target) {
                selectedParser = target.name;
            }
        }
    }

    if (selectedParser && app[selectedParser]) {
        try {
            return await app[selectedParser]({ flag, flags, id });
        } catch (e) {
            if (app && app.log) {
                app.log.error(`[优酷] 指定解析失败 (${selectedParser}): ${e.message}`);
            }
        }
    }

    // 3. 兜底逻辑 (如果 flag 无法识别，尝试默认的几个)
    // 这里的行为类似智能线路，但针对未识别 flag 的情况
    const defaultParses = [app.parse_xmflv, app.parse_fish];
    for (const parse of defaultParses) {
        if (!parse) continue;
        try {
            return await parse({ flag, flags, id });
        } catch (e) { }
    }

    return {
        parse: 1,
        jx: 1,
        url: id,
        header: config.headers
    };
};

const meta = {
    key: "youku",
    name: "优酷视频",
    type: 4,
    api: "/video/youku",
    searchable: 1,
    quickSearch: 1
};

const store = {
    init: false,
};

const init = async (server) => {
    if (store.init) return;
    store.log = server.log;
    store.init = true;
};

module.exports = async (app, opt) => {
    app.get(meta.api, async (req, reply) => {
        if (!store.init) {
            await init(req.server);
        }
        try {
            return await handleT4Request(req);
        } catch (error) {
            return { error: 'Internal Server Error' };
        }
    });
    opt.sites.push(meta);
};