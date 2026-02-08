const axios = require('axios');
const https = require('https');
const crypto = require('crypto');

// ========== 全局配置 ==========
const host = 'https://live.douyin.com';
const axiosInstance = axios.create({
    httpsAgent: new https.Agent({ rejectUnauthorized: false }),
    timeout: 15000
});

let cookieCache = '';

// ========== 工具函数 ==========
// 获取Cookie（关键：参考0.js的实现）
const getCookie = async () => {
    if (cookieCache) return cookieCache;
    
    try {
        const res = await axiosInstance.get(host);
        const cookies = res.headers['set-cookie'];
        if (cookies && cookies.length > 0) {
            const regex = /ttwid=([^;]+)/;
            const match = cookies[0].match(regex);
            if (match) {
                cookieCache = match[0];
            }
        }
    } catch (e) {
        console.error('[抖音直播] 获取cookie失败:', e.message);
    }
    return cookieCache;
};

// 获取请求头（带Cookie）
const getHeaders = async () => {
    const cookie = await getCookie();
    return {
        'Cookie': cookie,
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Referer': host,
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'zh-CN,zh;q=0.9'
    };
};

// 生成随机设备ID
const generateDeviceId = () => {
    const timestamp = Date.now().toString(36);
    const random = Math.random().toString(36).substring(2, 15);
    return `${timestamp}${random}`;
};

// ========== 主要功能函数 ==========
// 首页 - 返回分类
const _home = async () => {
    const classList = [
        { type_id: '1$1', type_name: '射击游戏' },
        { type_id: '2$1', type_name: '竞技游戏' },
        { type_id: '3$1', type_name: '单机游戏' },
        { type_id: '4$1', type_name: '棋牌游戏' },
        { type_id: '5$1', type_name: '休闲益智' },
        { type_id: '6$1', type_name: '角色扮演' },
        { type_id: '7$1', type_name: '策略卡牌' },
        { type_id: '10000$3', type_name: '娱乐天地' },
        { type_id: '10001$3', type_name: '科技文化' }
    ];
    return { class: classList };
};

// 分类列表（保持你的多策略实现）
const _category = async ({ id, page }) => {
    const pg = page || 1;
    const offset = 15 * (pg - 1);
    const [partition, type] = id.split('$');

    // 方案1: 使用Web API（带Cookie）
    const webUrl = `https://live.douyin.com/webcast/web/partition/detail/room/v2/`;
    const webParams = {
        aid: '6383',
        app_name: 'douyin_web',
        live_id: 1,
        device_platform: 'web',
        language: 'zh-CN',
        browser_language: 'zh-CN',
        browser_platform: 'Win32',
        browser_name: 'Chrome',
        browser_version: '120.0.0.0',
        partition: partition,
        partition_type: type,
        count: 15,
        offset: offset,
        web_rid: generateDeviceId(),
        cookie_enabled: true, // 改为true
        screen_width: 1920,
        screen_height: 1080
    };

    const headers = await getHeaders(); // 使用带Cookie的headers

    // 重试机制
    const strategies = [
        // 策略1: Web API（带Cookie）
        async () => {
            const url = webUrl + '?' + new URLSearchParams(webParams).toString();
            const res = await axiosInstance.get(url, {
                headers,
                validateStatus: (status) => status < 500
            });
            return res.data;
        },
        // 策略2: 备用域名
        async () => {
            const backupUrl = webUrl.replace('live.douyin.com', 'webcast.amemv.com');
            const url = backupUrl + '?' + new URLSearchParams(webParams).toString();
            const res = await axiosInstance.get(url, {
                headers,
                validateStatus: (status) => status < 500
            });
            return res.data;
        }
    ];

    for (let i = 0; i < strategies.length; i++) {
        try {
            console.log(`[抖音直播] 尝试策略 ${i + 1}...`);
            const data = await strategies[i]();
            
            if (!data || data.status_code !== 0) {
                console.warn(`[抖音直播] 策略 ${i + 1} 返回错误:`, data?.status_msg || '未知错误');
                continue;
            }

            if (!data.data || !data.data.data) {
                console.warn(`[抖音直播] 分类${id} 第${pg}页 无数据`);
                return { list: [], page: pg, pagecount: 0 };
            }

            const list = data.data.data.map(it => ({
                vod_id: `${it.web_rid || generateDeviceId()}@@${it.room.id_str}`,
                vod_name: it.room.title,
                vod_pic: it.room.cover.url_list[0],
                vod_remarks: `${it.room.owner.nickname} (🔥${it.room.stats.user_count_str})`
            }));

            console.log(`[抖音直播] 策略 ${i + 1} 成功: ${list.length}条`);
            return {
                list,
                page: pg,
                pagecount: pg + 1
            };
        } catch (e) {
            console.error(`[抖音直播] 策略 ${i + 1} 失败:`, e.message);
            if (i === strategies.length - 1) {
                return { list: [], page: pg, pagecount: 0 };
            }
            await new Promise(resolve => setTimeout(resolve, 500));
        }
    }

    return { list: [], page: pg, pagecount: 0 };
};

// 详情页（修复：使用Cookie和正确的参数格式）
const _detail = async ({ id }) => {
    const idStr = Array.isArray(id) ? id[0] : id;
    const [web_rid, room_id_str] = idStr.split('@@');

    // 参考0.js的参数格式
    const url = `https://live.douyin.com/webcast/room/web/enter/?aid=6383&app_name=douyin_web&live_id=1&device_platform=web&enter_from=web_live&browser_language=zh-CN&browser_platform=Win32&browser_name=Chrome&browser_version=120.0.0.0&web_rid=${web_rid}&room_id_str=${room_id_str}&enter_source=&is_need_double_stream=false`;

    const headers = await getHeaders(); // 使用带Cookie的headers

    try {
        const res = await axiosInstance.get(url, { headers });
        const data = res.data;

        if (!data.data || !data.data.data || data.data.data.length === 0) {
            console.error('[抖音直播] 直播间数据为空');
            return { list: [] };
        }

        const info = data.data.data[0];

        const resolutionName = {
            "FULL_HD1": "蓝光",
            "HD1": "超清",
            "ORIGION": "原画",
            "SD1": "标清",
            "SD2": "高清"
        };

        // 提取播放URL
        const flvUrls = Object.entries(info.stream_url.flv_pull_url || {})
            .map(([key, value]) => `${resolutionName[key] || key}$${value}`)
            .join('#');

        const hlsUrls = Object.entries(info.stream_url.hls_pull_url_map || {})
            .map(([key, value]) => `${resolutionName[key] || key}$${value}`)
            .join('#');

        const video = {
            vod_id: idStr,
            vod_name: info.title,
            vod_pic: info.cover.url_list[0],
            vod_actor: info.owner.nickname,
            vod_content: info.title,
            vod_play_from: 'FLV$$$HLS',
            vod_play_url: `${flvUrls}$$$${hlsUrls}`
        };

        return { list: [video] };
    } catch (e) {
        console.error('[抖音直播] 详情获取失败:', e.message);
        return { list: [] };
    }
};

// 搜索
const _search = async ({ page, wd }) => {
    const pg = page || 1;
    const offset = 10 * (pg - 1);

    const url = `https://www.douyin.com/aweme/v1/web/general/search/?device_platform=webapp&aid=6383&channel=channel_pc_web&search_channel=aweme_live&keyword=${encodeURIComponent(wd)}&offset=${offset}&count=10&os_version=10`;

    const headers = await getHeaders(); // 使用带Cookie的headers
    headers.referer = `${host}/`;

    try {
        const res = await axiosInstance.get(url, { headers });
        const data = res.data;

        if (!data.data) {
            return { list: [], page: pg };
        }

        const list = data.data
            .filter(it => it.lives && it.lives.rawdata)
            .map(it => {
                const rawdata = JSON.parse(it.lives.rawdata);
                return {
                    vod_id: `${rawdata.owner.web_rid || generateDeviceId()}@@${rawdata.id_str}`,
                    vod_name: rawdata.owner.nickname,
                    vod_pic: rawdata.owner.avatar_large.url_list[0],
                    vod_remarks: `${rawdata.video_feed_tag} (${rawdata.user_count})`,
                    vod_content: rawdata.title
                };
            });

        return { list, page: pg };
    } catch (e) {
        console.error('[抖音直播] 搜索失败:', e.message);
        return { list: [], page: pg };
    }
};

// 播放
const _play = async ({ id }) => {
    return {
        parse: 0,
        url: id
    };
};

// ========== 站点元数据 ==========
const meta = {
    key: "DouyinLive",
    name: "抖音直播",
    type: 4,
    api: "/video/DouyinLive",
    searchable: 1,
    quickSearch: 1
};

const store = { init: false };

const init = async (server) => {
    if (store.init) return;
    store.log = server.log;
    store.init = true;
    
    // 预先获取Cookie
    await getCookie();
    console.log('[抖音直播] 初始化完成，Cookie已准备');
};

// ========== 模块导出 ==========
module.exports = async (app, opt) => {
    app.get(meta.api, async (req, reply) => {
        if (!store.init) await init(req.server);

        const { t, ac, pg, ids, play, wd, quick } = req.query;

        try {
            if (play) {
                return await _play({ id: play });
            } else if (wd) {
                return await _search({ page: parseInt(pg || "1"), wd });
            } else if (!ac) {
                return await _home();
            } else if (ac === "detail") {
                if (t) {
                    return await _category({ id: t, page: parseInt(pg || "1") });
                } else if (ids) {
                    return await _detail({ id: ids.split(",").map(v => v.trim()) });
                }
            }

            return req.query;
        } catch (e) {
            if (store.log) store.log.error('[抖音直播] 接口错误:', e.message);
            return { error: e.message };
        }
    });

    opt.sites.push(meta);
};