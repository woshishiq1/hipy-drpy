const CryptoJS = require("crypto-js");
const axios = require("axios");

/**
 * 模块级别的全局配置和状态
 */
const aggConfig = {
    keys: 'd3dGiJc651gSQ8w1',
    charMap: {
        '+': 'P', '/': 'X', '0': 'M', '1': 'U', '2': 'l', '3': 'E', '4': 'r', '5': 'Y', '6': 'W', '7': 'b', '8': 'd', '9': 'J',
        'A': '9', 'B': 's', 'C': 'a', 'D': 'I', 'E': '0', 'F': 'o', 'G': 'y', 'H': '_', 'I': 'H', 'J': 'G', 'K': 'i', 'L': 't',
        'M': 'g', 'N': 'N', 'O': 'A', 'P': '8', 'Q': 'F', 'R': 'k', 'S': '3', 'T': 'h', 'U': 'f', 'V': 'R', 'W': 'q', 'X': 'C',
        'Y': '4', 'Z': 'p', 'a': 'm', 'b': 'B', 'c': 'O', 'd': 'u', 'e': 'c', 'f': '6', 'g': 'K', 'h': 'x', 'i': '5', 'j': 'T',
        'k': '-', 'l': '2', 'm': 'z', 'n': 'S', 'o': 'Z', 'p': '1', 'q': 'V', 'r': 'v', 's': 'j', 't': 'Q', 'u': '7', 'v': 'D',
        'w': 'w', 'x': 'n', 'y': 'L', 'z': 'e'
    },
    headers: {
        niuniu: {
            'Cache-Control': 'no-cache',
            'Content-Type': 'application/json;charset=UTF-8',
            'User-Agent': 'okhttp/4.12.0'
        },
        default: {
            'User-Agent': 'okhttp/3.12.11',
            'content-type': 'application/json; charset=utf-8'
        }
    },
    platform: {
        百度: {
            host: 'https://api.jkyai.top',
            url1: '/API/bddjss.php?name=fyclass&page=fypage',
            url2: '/API/bddjss.php?id=fyid',
            search: '/API/bddjss.php?name=**&page=fypage'
        },
        甜圈: {
            host: 'https://mov.cenguigui.cn',
            url1: '/duanju/api.php?classname',
            url2: '/duanju/api.php?book_id',
            search: '/duanju/api.php?name'
        },
        锦鲤: {
            host: 'https://api.jinlidj.com',
            search: '/api/search',
            url2: '/api/detail'
        },
        番茄: {
            host: 'https://reading.snssdk.com',
            url1: '/reading/bookapi/bookmall/cell/change/v',
            url2: 'https://fqgo.52dns.cc/catalog',
            search: 'https://fqgo.52dns.cc/search'
        },
        星芽: {
            host: 'https://app.whjzjx.cn',
            url1: '/cloud/v2/theater/home_page?theater_class_id',
            url2: '/v2/theater_parent/detail',
            search: '/v3/search',
            loginUrl: 'https://u.shytkjgs.com/user/v1/account/login'
        },
        西饭: {
            host: 'https://xifan-api-cn.youlishipin.com',
            url1: '/xifan/drama/portalPage',
            url2: '/xifan/drama/getDuanjuInfo',
            search: '/xifan/search/getSearchList'
        },
        软鸭: {
            host: 'https://api.xingzhige.com',
            url1: '/API/playlet',
            search: '/API/playlet'
        },
        七猫: {
            host: 'https://api-store.qmplaylet.com',
            url1: '/api/v1/playlet/index',
            url2: 'https://api-read.qmplaylet.com/player/api/v1/playlet/info',
            search: '/api/v1/playlet/search'
        },
        牛牛: {
            host: 'https://new.tianjinzhitongdaohe.com',
            url1: '/api/v1/app/screen/screenMovie',
            url2: '/api/v1/app/play/movieDetails',
            search: '/api/v1/app/search/searchMovie'
        },
        围观: {
            host: 'https://api.drama.9ddm.com',
            url1: '/drama/home/shortVideoTags',
            url2: '/drama/home/shortVideoDetail',
            search: '/drama/home/search'
        },
        碎片: {
            host: 'https://free-api.bighotwind.cc',
            url1: '/papaya/papaya-api/theater/tags',
            url2: '/papaya/papaya-api/videos/info',
            search: '/papaya/papaya-api/videos/page'
        }
    },
    platformList: [
        { name: '甜圈短剧', id: '甜圈' },
        { name: '百度短剧', id: '百度' },
        { name: '七猫短剧', id: '七猫' },
        { name: '星芽短剧', id: '星芽' },
        { name: '碎片剧场', id: '碎片' },
        { name: '锦鲤短剧', id: '锦鲤' },
        { name: '番茄短剧', id: '番茄' },
        { name: '软鸭短剧', id: '软鸭' },
        { name: '围观短剧', id: '围观' },
        { name: '牛牛短剧', id: '牛牛' },
        { name: '西饭短剧', id: '西饭' },
    ],
    search: { limit: 30, timeout: 6000 }
};

// 默认筛选配置
const filter_def = {
    百度: { area: '逆袭' },
    甜圈: { area: '推荐榜' },
    锦鲤: { area: '' },
    番茄: { area: 'videoseries_hot' },
    星芽: { area: '1' },
    西饭: { area: '' },
    软鸭: { area: '战神' },
    七猫: { area: '0' },
    牛牛: { area: '现言' },
    围观: { area: '' },
    碎片: { area: '' }
};

// 手动构建的筛选数据
const customFilters = {
    "百度": [{
        key: "area",
        name: "题材",
        value: [
            { n: "逆袭", v: "逆袭" }, { n: "战神", v: "战神" }, { n: "都市", v: "都市" },
            { n: "穿越", v: "穿越" }, { n: "重生", v: "重生" }, { n: "古装", v: "古装" },
            { n: "言情", v: "言情" }, { n: "虐恋", v: "虐恋" }, { n: "甜宠", v: "甜宠" },
            { n: "神医", v: "神医" }, { n: "萌宝", v: "萌宝" }
        ]
    }],
    "甜圈": [{
        key: "area",
        name: "榜单",
        value: [
            { n: "推荐榜", v: "推荐榜" }, { n: "热播榜", v: "热播榜" }, { n: "新书榜", v: "新书榜" },
            { n: "完结榜", v: "完结榜" }, { n: "连载榜", v: "连载榜" }, { n: "免费榜", v: "免费榜" }
        ]
    }],
    "锦鲤": [{
        key: "area",
        name: "分类",
        value: [
            { n: "全部", v: "" }, { n: "推荐", v: "1" }, { n: "霸总", v: "2" },
            { n: "战神", v: "3" }, { n: "神医", v: "4" }, { n: "虐恋", v: "5" },
            { n: "萌宝", v: "6" }, { n: "逆袭", v: "7" }, { n: "穿越", v: "8" },
            { n: "古装", v: "9" }, { n: "重生", v: "10" }
        ]
    }],
    "番茄": [{
        key: "area",
        name: "分类",
        value: [
            { n: "热门", v: "videoseries_hot" }, { n: "最新", v: "videoseries_new" }, { n: "完结", v: "videoseries_finish" },
            { n: "连载", v: "videoseries_serialize" }, { n: "推荐", v: "videoseries_recommend" }
        ]
    }],
    "星芽": [{
        key: "area",
        name: "频道",
        value: [
            { n: "推荐", v: "1" }, { n: "男频", v: "2" }, { n: "女频", v: "3" }
        ]
    }],
    "西饭": [{
        key: "area",
        name: "频道",
        value: [
             { n: "都市", v: "10003@都市" }, { n: "古装", v: "10001@古装" }, { n: "重生", v: "10008@重生" },
             { n: "逆袭", v: "10004@逆袭" }, { n: "虐恋", v: "10011@虐恋" }, { n: "萌宝", v: "10012@萌宝" },
             { n: "复仇", v: "10014@复仇" }, { n: "战神", v: "10005@战神" }, { n: "穿越", v: "10009@穿越" }
        ]
    }],
    "软鸭": [{
        key: "area",
        name: "题材",
        value: [
            { n: "战神", v: "战神" }, { n: "逆袭", v: "逆袭" }, { n: "重生", v: "重生" },
            { n: "穿越", v: "穿越" }, { n: "甜宠", v: "甜宠" }, { n: "虐恋", v: "虐恋" },
            { n: "古装", v: "古装" }, { n: "都市", v: "都市" }
        ]
    }],
    "七猫": [{
        key: "area",
        name: "分类",
        value: [
            { n: "全部", v: "0" }, { n: "都市", v: "1" }, { n: "言情", v: "2" },
            { n: "战神", v: "3" }, { n: "逆袭", v: "4" }, { n: "重生", v: "5" },
            { n: "穿越", v: "6" }, { n: "古装", v: "7" }
        ]
    }],
    "牛牛": [{
        key: "area",
        name: "分类",
        value: [
            { n: "现言", v: "现言" }, { n: "古言", v: "古言" }, { n: "战神", v: "战神" },
            { n: "逆袭", v: "逆袭" }, { n: "萌宝", v: "萌宝" }, { n: "神医", v: "神医" },
            { n: "其它", v: "其它" }
        ]
    }],
    "围观": [{
        key: "area",
        name: "分类",
        value: [
            { n: "全部", v: "" }
        ]
    }],
    "碎片": [{
        key: "area",
        name: "分类",
        value: [
            { n: "全部", v: "" }
        ]
    }]
};

const rule = {
    search_match: true,
    headers: aggConfig.headers.default,
};

let xingya_headers = {};

// --- 辅助工具函数 ---

// 碎片剧场专用GUID生成
const guid = function() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0,
            v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
};

// 碎片剧场专用AES加密
const encHex = function(txt) {
    const k = CryptoJS.enc.Utf8.parse("p0sfjw@k&qmewu#w");
    const e = CryptoJS.AES.encrypt(
        CryptoJS.enc.Utf8.parse(txt),
        k, {
            mode: CryptoJS.mode.ECB,
            padding: CryptoJS.pad.Pkcs7
        }
    );
    return e.ciphertext.toString(CryptoJS.enc.Hex);
};

const request = async (url, options = {}) => {
    const { method = 'GET', headers = {}, body, timeout = 5000 } = options;
    const isPost = method.toUpperCase() === 'POST';

    const axiosOptions = {
        url: url,
        method: method,
        headers: { ...aggConfig.headers.default, ...headers },
        data: isPost ? body : undefined,
        params: isPost ? undefined : options.params,
        timeout: timeout,
    };

    try {
        const response = await axios(axiosOptions);
        if (typeof response.data === 'object') {
             return JSON.stringify(response.data);
        }
        return response.data;
    } catch (error) {
        console.error(`Request to ${url} failed: ${error.message}`);
        throw error;
    }
};

const md5 = async (str) => {
    return CryptoJS.MD5(str).toString();
};

const log = console.log;

const getQmParamsAndSign = async () => {
    try {
        const sessionId = Math.floor(Date.now()).toString();
        let data = {
            "static_score": "0.8", "uuid": "00000000-7fc7-08dc-0000-000000000000",
            "device-id": "20250220125449b9b8cac84c2dd3d035c9052a2572f7dd0122edde3cc42a70",
            "mac": "", "sourceuid": "aa7de295aad621a6", "refresh-type": "0", "model": "22021211RC",
            "wlb-imei": "", "client-id": "aa7de295aad621a6", "brand": "Redmi", "oaid": "",
            "oaid-no-cache": "", "sys-ver": "12", "trusted-id": "", "phone-level": "H",
            "imei": "", "wlb-uid": "aa7de295aad621a6", "session-id": sessionId
        };
        const jsonStr = JSON.stringify(data);
        const base64Str = Buffer.from(jsonStr, 'utf8').toString('base64');
        let qmParams = '';
        for (const c of base64Str) qmParams += aggConfig.charMap[c] || c;
        
        const paramsStr = `AUTHORIZATION=app-version=10001application-id=com.duoduo.readchannel=unknownis-white=net-env=5platform=androidqm-params=${qmParams}reg=${aggConfig.keys}`;
        return { qmParams, sign: await md5(paramsStr) };
    } catch (e) {
        console.error('qm参数生成失败:', e);
        throw e;
    }
};

const getHeaderX = async () => {
    const { qmParams, sign } = await getQmParamsAndSign();
    return {
        'net-env': '5', 'reg': '', 'channel': 'unknown', 'is-white': '', 'platform': 'android',
        'application-id': 'com.duoduo.read', 'authorization': '', 'app-version': '10001',
        'user-agent': 'webviewversion/0', 'qm-params': qmParams, 'sign': sign
    };
};

const atob = (str) => {
    return Buffer.from(str, 'base64').toString('utf8');
};

const initXingYaToken = async () => {
    if (Object.keys(xingya_headers).length > 0) return;

    try {
        const plat = aggConfig.platform['星芽'];
        const data = { 'device': '24250683a3bdb3f118dff25ba4b1cba1a' };
        const options = {
            method: 'POST',
            headers: {
                'User-Agent': 'okhttp/4.10.0',
                'platform': '1',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data),
            timeout: 5000 
        };
        
        let html = await request(plat.loginUrl, options);
        const res = JSON.parse(html);
        const token = res?.data?.token || res?.data?.data?.token;
        xingya_headers = { ...rule.headers, authorization: token };
        log('星芽短剧token获取成功');
    } catch (e) {
        log(`星芽短剧token获取失败: ${e.message}`);
    }
};

const getSuipianToken = async () => {
    try {
        let openId = await md5(guid());
        openId = openId.substring(0, 16);
        let api = "https://free-api.bighotwind.cc/papaya/papaya-api/oauth2/uuid";
        let body = JSON.stringify({ "openId": openId });
        let key = encHex(Date.now().toString());
        let res = JSON.parse(await request(api, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                "key": key
            },
            body: body
        }));
        return res.data.token;
    } catch (e) {
        log(`碎片token获取失败: ${e.message}`);
        return '';
    }
};


// --- Fastify 路由处理函数 ---

const _home = async ({ filter }) => {
    const classes = aggConfig.platformList.map(item => ({
        type_id: item.id,
        type_name: item.name,
    }));
    return { class: classes, list: [], filters: customFilters };
};

const _category = async ({ id, page, filter, filters }) => {
    const d = [];
    const MY_CATE = id;
    const MY_PAGE = page;
    const PAGE_SIZE = aggConfig.search.limit || 30;

    const MY_FL = filters || {};
    const defaultArea = filter_def[MY_CATE]?.area || '';
    const area = MY_FL.area || defaultArea; 

    const plat = aggConfig.platform[MY_CATE];
    const cfg = aggConfig;

    if (MY_CATE === '星芽') await initXingYaToken(); 

    let pagecount = MY_PAGE; 
    let listLength = 0; 
    let presumedPageSize = PAGE_SIZE;

    try {
        switch (MY_CATE) {
            case '百度': {
                presumedPageSize = 10;
                const url = `${plat.host}${plat.url1.replace('fyclass', area).replace('fypage', MY_PAGE)}`;
                const res = JSON.parse(await request(url, { headers: rule.headers }));
                res.data.forEach(it => {
                  d.push({
                    vod_id: `百度@${it.id}`, vod_name: it.title, vod_pic: it.cover, vod_remarks: '更新至' + it.totalChapterNum + '集',
                  });
                });
                listLength = res.data.length;
                if (listLength >= presumedPageSize) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
            case '甜圈': {
                presumedPageSize = 10;
                const url = `${plat.host}${plat.url1}=${area}&offset=${MY_PAGE}`; 
                const res = JSON.parse(await request(url, { headers: rule.headers }));
                res.data.forEach(it => {
                    d.push({
                        vod_id: `甜圈@${it.book_id}`, vod_name: it.title, vod_pic: it.cover, vod_remarks: it.sub_title,
                    });
                });
                listLength = res.data.length;
                if (listLength >= presumedPageSize) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
            case '锦鲤': {
                presumedPageSize = 24;
                const body = JSON.stringify({ page: MY_PAGE, limit: presumedPageSize, type_id: area, year: '', keyword: '' }); 
                const res = JSON.parse(await request(plat.host + plat.search, { method: 'POST', body, headers: rule.headers }));
                res.data.list.forEach(item => {
                    d.push({
                        vod_id: `锦鲤@${item.vod_id}`, vod_name: item.vod_name || '', vod_pic: item.vod_pic, vod_remarks: `${item.vod_total}集`,
                    });
                });
                listLength = res.data.list.length;
                if (listLength > 0) pagecount = MY_PAGE + 1; 
                else pagecount = MY_PAGE;
                break;
            }
            case '番茄': {
                presumedPageSize = 12;
                const offset = (MY_PAGE - 1) * presumedPageSize;
                const sessionId = new Date().toISOString().slice(0, 16).replace(/-|T:/g, '');
                let url = `${plat.host}${plat.url1}?change_type=0&selected_items=${area}&tab_type=8&cell_id=6952850996422770718&version_tag=video_feed_refactor&device_id=1423244030195267&aid=1967&app_name=novelapp&ssmix=a&session_id=${sessionId}`;
                if (MY_PAGE > 1) url += `&offset=${offset}`; 
                
                const res = JSON.parse(await request(url, { headers: cfg.headers.default }));
                let items = [];
                if (res?.data?.cell_view?.cell_data) items = res.data.cell_view.cell_data;
                else if (Array.isArray(res?.data)) items = res.data;
                else items = [res || {}];

                items.forEach(item => {
                    const videoData = item.video_data?.[0] || item;
                    const id = videoData.series_id || videoData.book_id || videoData.id || '';
                    if (id) {
                        d.push({
                            vod_id: `番茄@${id}`, vod_name: videoData.title || '未知短剧', vod_pic: videoData.cover || videoData.horiz_cover || '', vod_remarks: videoData.sub_title || videoData.rec_text || '',
                        });
                    }
                });
                listLength = items.length;
                if (listLength === presumedPageSize) pagecount = MY_PAGE + 1; 
                else pagecount = MY_PAGE;
                break;
            }
            case '星芽': {
                presumedPageSize = 24;
                const url = `${plat.host}${plat.url1}=${area}&type=1&class2_ids=0&page_num=${MY_PAGE}&page_size=${presumedPageSize}`;
                const res = JSON.parse(await request(url, { headers: xingya_headers }));
                res.data.list.forEach(it => {
                    const id = `${plat.host}${plat.url2}?theater_parent_id=${it.theater.id}`;
                    d.push({
                        vod_id: `星芽@${id}`, vod_name: it.theater.title, vod_pic: it.theater.cover_url, vod_remarks: `${it.theater.total}集 | 播放量:${it.theater.play_amount_str}`,
                    });
                });
                listLength = res.data.list.length;
                if (listLength > 0) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
            case '西饭': {
                presumedPageSize = 30;
                const ts = Math.floor(Date.now() / 1000);
                const offset = (MY_PAGE - 1) * presumedPageSize;
                const url = `${plat.host}${plat.url1}?reqType=aggregationPage&offset=${offset}&quickEngineVersion=-1&scene=&categoryVersion=1&density=1.5&pageID=page_theater&version=2001001&androidVersionCode=28&requestId=${ts}aa498144140ef297&appId=drama&teenMode=false&userBaseMode=false&session=eyJpbmZvIjp7InVpZCI6IiIsInJ0IjoiMTc0MDY1ODI5NCIsInVuIjoiT1BHXzFlZGQ5OTZhNjQ3ZTQ1MjU4Nzc1MTE2YzFkNzViN2QwIiwiZnQiOiIxNzQwNjU4Mjk0In19&feedssession=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dHlwIjowLCJidWlkIjoxNjMzOTY4MTI2MTQ4NjQxNTM2LCJhdWQiOiJkcmFtYSIsInZlciI6MiwicmF0IjoxNzQwNjU4Mjk0LCJ1bm0iOiJPUEdfMWVkZDk5NmE2NDdlNDUyNTg3NzUxMTZjMWQ3NWI3ZDAiLCJpZCI6IjNiMzViZmYzYWE0OTgxNDQxNDBlZjI5N2JkMDY5NGNhIiwiZXhwIjoxNzQxMjYzMDk0LCJkYyI6Imd6cXkifQ.JS3QY6ER0P2cQSxAE_OGKSMIWNAMsYUZ3mJTnEpf-Rc`;
                
                const res = JSON.parse(await request(url, { headers: cfg.headers.default }));
                if (res.result && res.result.elements) {
                    res.result.elements.forEach(soup => {
                        soup.contents.forEach(vod => {
                            const dj = vod.duanjuVo;
                            d.push({
                                vod_id: `西饭@${dj.duanjuId}#${dj.source}`, vod_name: dj.title, vod_pic: dj.coverImageUrl, vod_remarks: `${dj.total}集`,
                            });
                        });
                    });
                }
                listLength = d.length;
                // 西饭每页数量可能不固定，采用乐观翻页
                if (listLength > 0) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
            case '软鸭': {
                presumedPageSize = 10;
                const url = `${plat.host}${plat.url1}/?keyword=${encodeURIComponent(area)}&page=${MY_PAGE}`;
                const res = JSON.parse(await request(url, { headers: cfg.headers.default }));
                res.data.forEach(item => {
                    const purl = `${item.title}@${item.cover}@${item.author}@${item.type}@${item.desc}@${item.book_id}`;
                    d.push({
                        vod_id: `软鸭@${encodeURIComponent(purl)}`, vod_name: item.title, vod_pic: item.cover, vod_remarks: item.type,
                    });
                });
                listLength = res.data.length;
                if (listLength === presumedPageSize) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
            case '七猫': {
                presumedPageSize = 20;
                let signStr = `operation=1playlet_privacy=1tag_id=${area}${cfg.keys}`;
                const sign = await md5(signStr);
                const url = `${plat.host}${plat.url1}?tag_id=${area}&playlet_privacy=1&operation=1&sign=${sign}`;
                const headers = { ...await getHeaderX(), ...cfg.headers.default };
                const res = JSON.parse(await request(url, { method: 'GET', headers }));
                (res?.data?.list || []).forEach(item => {
                    d.push({
                        vod_id: `七猫@${encodeURIComponent(item.playlet_id)}`, vod_name: item.title || '', vod_pic: item.image_link || '', vod_remarks: `${item.total_episode_num || 0}集`,
                    });
                });
                listLength = (res?.data?.list || []).length;
                if (listLength === presumedPageSize) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
            case '牛牛': {
                presumedPageSize = 24;
                const body = JSON.stringify({
                    condition: { classify: area, typeId: 'S1' },
                    pageNum: MY_PAGE,
                    pageSize: presumedPageSize
                });
                const res = JSON.parse(await request(plat.host + plat.url1, { method: 'POST', headers: cfg.headers.niuniu, body }));
                (res.data?.records || []).forEach(item => {
                    d.push({
                        vod_id: `牛牛@${item.id}`, vod_name: item.name, vod_pic: item.cover, vod_remarks: `${item.totalEpisode || 0}集`,
                    });
                });
                listLength = (res.data?.records || []).length;
                const total = res.data.total || 0;
                if (total > 0) pagecount = Math.ceil(total / presumedPageSize);
                else if (listLength === presumedPageSize) pagecount = MY_PAGE + 1;
                break;
            }
            case '围观': {
                presumedPageSize = 30;
                const postData = JSON.stringify({
                    "audience": "全部受众", "page": MY_PAGE, "pageSize": presumedPageSize,
                    "searchWord": "", "subject": "全部主题"
                });
                const res = JSON.parse(await request(`${plat.host}${plat.search}`, { method: 'POST', headers: cfg.headers.default, body: postData }));
                res.data.forEach(it => {
                    d.push({
                        vod_id: `围观@${it.oneId}`, vod_name: it.title, vod_pic: it.vertPoster, vod_remarks: `集数:${it.episodeCount} 播放:${it.viewCount}`,
                    });
                });
                listLength = res.data.length;
                if (listLength === presumedPageSize) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
            case '碎片': {
                presumedPageSize = 24;
                const token = await getSuipianToken();
                const headers = { ...rule.headers, 'Authorization': token };
                // 碎片剧场 search 用于分类
                const url = `${plat.host}${plat.search}?type=5&tagId=${area}&pageNum=${MY_PAGE}&pageSize=${presumedPageSize}`;
                const res = JSON.parse(await request(url, { headers }));
                
                (res.list || []).forEach(it => {
                    let compoundId = it.itemId + '@' + it.videoCode;
                    d.push({
                        vod_id: `碎片@${compoundId}`, 
                        vod_name: it.title, 
                        vod_pic: "https://speed.hiknz.com/papaya/papaya-file/files/download/" + it.imageKey + "/" + it.imageName, 
                        vod_remarks: `集数:${it.episodesMax}`,
                    });
                });
                listLength = (res.list || []).length;
                if (listLength === presumedPageSize) pagecount = MY_PAGE + 1;
                else pagecount = MY_PAGE;
                break;
            }
        }
        
        // --- 兜底策略 ---
        if (pagecount < MY_PAGE) {
            pagecount = MY_PAGE;
        } else if (d.length === 0 && MY_PAGE > 1) {
            pagecount = MY_PAGE; 
        }
        
    } catch (e) {
        log(`_category 拉取失败（平台：${MY_CATE}）：${e.message}`);
        pagecount = MY_PAGE;
    }

    return {
        list: d,
        page: MY_PAGE,
        pagecount: pagecount,
        total: d.length > 0 && pagecount > MY_PAGE ? d.length * pagecount * 0.8 : d.length // 估算总数
    };
};

const _detail = async ({ id }) => {
    const VODS = [];

    for (const orId of id) {
        const parts = orId.split('@');
        const platform = parts[0];
        const detailId = parts.slice(1).join('@');
        const plat = aggConfig.platform[platform];
        let VOD = {};

        if (platform === '星芽') await initXingYaToken();

        try {
            switch (platform) {
                 case '百度': {
                    const res = JSON.parse(await request(`${plat.host}${plat.url2.replace('fyid', detailId)}`));
                    VOD = {
                      vod_id: orId, vod_name: res.title, vod_pic: res.data[0].cover,
                      vod_year: '更新至:' + res.total + '集',
                      vod_play_from: '百度短剧',
                      vod_play_url: res.data.map(item => `${item.title}$${item.video_id}`).join("#")
                    };
                    break;
                }
                case '甜圈': {
                    const res = JSON.parse(await request(`${plat.host}${plat.url2}=${detailId}`));
                    VOD = {
                        vod_id: orId, vod_name: res.book_name, type_name: res.category,
                        vod_pic: res.book_pic, vod_content: res.desc, vod_remarks: res.duration,
                        vod_year: `更新时间:${res.time}`, vod_actor: res.author,
                        vod_play_from: '甜圈短剧',
                        vod_play_url: res.data.map(item => `${item.title}$${item.video_id}`).join('#')
                    };
                    break;
                }
                case '锦鲤': {
                    const res = JSON.parse(await request(`${plat.host}${plat.url2}/${detailId}`));
                    const list = res.data;
                    const playUrls = Object.keys(list.player).map(key => `${key}$${list.player[key]}`);
                    VOD = {
                        vod_id: orId, vod_name: list.vod_name || '暂无名称', type_name: list.vod_class || '暂无类型',
                        vod_pic: list.vod_pic || '暂无图片', vod_remarks: list.vod_remarks || '暂无备注',
                        vod_content: list.vod_blurb || '暂无剧情', vod_play_from: '锦鲤短剧',
                        vod_play_url: playUrls.join('#')
                    };
                    break;
                }
                case '番茄': {
                    const res = JSON.parse(await request(`${plat.url2}?book_id=${detailId}`));
                    const bookInfo = res.data.book_info;
                    const playList = res.data.item_data_list.map(item => `${item.title}$${item.item_id}`).join('#');
                    VOD = {
                        vod_id: orId, vod_name: bookInfo.book_name, vod_type: bookInfo.tags,
                        vod_pic: bookInfo.thumb_url || bookInfo.audio_thumb_uri, vod_content: bookInfo.abstract || bookInfo.book_abstract_v2,
                        vod_remarks: bookInfo.sub_info || `更新至${res.data.item_data_list.length}集`,
                        vod_play_from: '番茄短剧', vod_play_url: playList
                    };
                    break;
                }
                case '星芽': {
                    const res = JSON.parse(await request(detailId, { headers: xingya_headers }));
                    const data = res.data;
                    const playUrls = data.theaters.map(it => `${it.num}$${it.son_video_url}`);
                    VOD = {
                        vod_id: orId, vod_name: data.title, type_name: data.score,
                        vod_pic: data.cover_url, vod_content: data.introduction,
                        vod_remarks: data.desc_tags + '', vod_play_from: '星芽短剧',
                        vod_play_url: playUrls.join('#')
                    };
                    break;
                }
                case '西饭': {
                    const [duanjuId, source] = detailId.split('#');
                    const url = `${plat.host}${plat.url2}?duanjuId=${duanjuId}&source=${source}&openFrom=homescreen&type=&pageID=page_inner_flow&density=1.5&version=2001001&androidVersionCode=28&requestId=1740658944980aa498144140ef297&appId=drama&teenMode=false&userBaseMode=false&session=eyJpbmZvIjp7InVpZCI6IiIsInJ0IjoiMTc0MDY1ODI5NCIsInVuIjoiT1BHXzFlZGQ5OTZhNjQ3ZTQ1MjU4Nzc1MTE2YzFkNzViN2QwIiwiZnQiOiIxNzQwNjU4Mjk0In19&feedssession=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dHlwIjowLCJidWlkIjoxNjMzOTY4MTI2MTQ4NjQxNTM2LCJhdWQiOiJkcmFtYSIsInZlciI6MiwicmF0IjoxNzQwNjU4Mjk0LCJ1bm0iOiJPUEdfMWVkZDk5NmE2NDdlNDUyNTg3NzUxMTY2YzFkNzViN2QwIiwiZXhwIjoxNzQxMjYzMDk0LCJkYyI6Imd6cXkifQ.JS3QY6ER0P2cQSxAE_OGKSMIWNAMsYUZ3mJTnEpf-Rc`;
                    
                    const res = JSON.parse(await request(url, { headers: aggConfig.headers.default }));
                    const data = res.result;
                    const playUrls = data.episodeList.map(ep => `${ep.index}$${ep.playUrl}`);
                    VOD = {
                      vod_id: orId,
                      vod_name: data.title,
                      vod_pic: data.coverImageUrl,
                      vod_content: data.desc || '未知',
                      vod_remarks: data.updateStatus === 'over' ? `${data.total}集 已完结` : `更新${data.total}集`,
                      vod_play_from: '西饭短剧',
                      vod_play_url: playUrls.join('#')
                    };
                    break;
                }
                case '软鸭': {
                    const did = decodeURIComponent(detailId);
                    const [title, img, author, type, desc, book_id] = did.split('@');
                    const detailUrl = `${plat.host}${plat.url1}/?book_id=${book_id}`;
                    const res = JSON.parse(await request(detailUrl, { headers: aggConfig.headers.default }));
                    const playUrls = (res.data?.video_list || []).map(ep => `${ep.title}$${ep.video_id}`).join('#');
                    VOD = {
                        vod_id: orId, vod_name: title, vod_pic: img, vod_actor: author,
                        vod_remarks: type, vod_content: desc, vod_play_from: '软鸭短剧',
                        vod_play_url: playUrls
                    };
                    break;
                }
                case '七猫': {
                    const did = decodeURIComponent(detailId);
                    const sign = await md5(`playlet_id=${did}${aggConfig.keys}`);
                    const url = `${plat.url2}?playlet_id=${did}&sign=${sign}`;
                    const headers = { ...await getHeaderX(), ...aggConfig.headers.default };
                    
                    const res = JSON.parse(await request(url, { method: 'GET', headers }));
                    const data = res.data;
                    VOD = {
                        vod_id: orId, vod_name: data.title || '未知标题',
                        vod_pic: data.image_link || '未知图片',
                        vod_remarks: `${data.tags} ${data.total_episode_num}集`,
                        vod_content: data.intro || '未知剧情',
                        vod_play_from: '七猫短剧',
                        vod_play_url: data.play_list.map(it => `${it.sort}$${it.video_url}`).join('#')
                    };
                    break;
                }
                case '牛牛': {
                    const body = JSON.stringify({ id: detailId, source: 0, typeId: 'S1', userId: '223664' });
                    const res = JSON.parse(await request(plat.host + plat.url2, { method: 'POST', headers: aggConfig.headers.niuniu, body }));
                    const data = res.data || {};
                    const playUrls = (data.episodeList || []).map(ep => `${ep.episode}$${detailId}@${ep.id}`);
                    
                    VOD = {
                        vod_id: orId, vod_name: data.name || '未知名称', vod_pic: data.cover || '',
                        vod_content: data.introduce || '暂无剧情', vod_play_from: '牛牛短剧',
                        vod_play_url: playUrls.join('#') || '暂无播放地址$0'
                    };
                    break;
                }
                case '围观': {
                    const res = JSON.parse(await request(
                        `${plat.host}${plat.url2}?oneId=${detailId}&page=1&pageSize=1000`,
                        { headers: rule.headers }
                    ));
                    const data = res.data;
                    const firstEpisode = data[0];
                    VOD = {
                        vod_id: orId, vod_name: firstEpisode.title,
                        vod_pic: firstEpisode.vertPoster,
                        vod_remarks: `共${data.length}集`,
                        vod_content: `播放量:${firstEpisode.collectionCount} 评论:${firstEpisode.commentCount}`,
                        vod_play_from: '围观短剧',
                        vod_play_url: data.map(episode => {
                            return `${episode.title}第${episode.playOrder}集$${episode.playSetting}`;
                        }).join('#')
                    };
                    break;
                }
                case '碎片': {
                    const token = await getSuipianToken();
                    const headers = { ...rule.headers, 'Authorization': token };
                    const [itemId, videoCode] = detailId.split('@');
                    const url = `${plat.host}${plat.url2}?videoCode=${videoCode}&itemId=${itemId}`;
                    const res = JSON.parse(await request(url, { headers }));
                    const data = res.data || res;
                    
                    const playUrls = (data.episodesList || []).map(episode => {
                        let episodeTitle = `第${episode.episodes}集`;
                        let playUrl = "";
                        if (episode.resolutionList && episode.resolutionList.length > 0) {
                            episode.resolutionList.sort((a, b) => b.resolution - a.resolution); // 选最高清晰度
                            let bestResolution = episode.resolutionList[0];
                            playUrl = `https://speed.hiknz.com/papaya/papaya-file/files/download/${bestResolution.fileKey}/${bestResolution.fileName}`;
                        }
                        return playUrl ? `${episodeTitle}$${playUrl}` : null;
                    }).filter(item => item !== null).join('#');

                    VOD = {
                        vod_id: orId, vod_name: data.title,
                        vod_pic: "https://speed.hiknz.com/papaya/papaya-file/files/download/" + data.imageKey + "/" + data.imageName,
                        vod_remarks: `共${data.episodesMax}集`,
                        vod_content: data.content || data.description || `播放量:${data.hitShowNum} 点赞:${data.likeNum}`,
                        vod_play_from: '碎片剧场',
                        vod_play_url: playUrls
                    };
                    break;
                }
            }
        } catch (e) {
            log(`_detail 拉取失败（平台：${platform}）：${e.message}`);
            VOD = { vod_id: orId, vod_name: `${platform}：详情加载失败`, vod_remarks: e.message, vod_play_from: '', vod_play_url: '失败$0' };
        }

        VODS.push(VOD);
    }

    return { list: VODS };
};

const _search = async ({ page, quick, wd }) => {
    const KEY = wd;
    const MY_PAGE = page;
    
    const cfg = aggConfig;
    const d = [];
    const searchLimit = cfg.search.limit || 30;
    const searchTimeout = cfg.search.timeout || 6000;

    if (MY_PAGE === 1) await initXingYaToken();

    const searchPromises = cfg.platformList.map(async (platform) => {
        try {
            const plat = cfg.platform[platform.id];
            let results = [];

            switch (platform.id) {
                case '百度': {
                    const url = `${plat.host}${plat.search.replace('**', encodeURIComponent(KEY)).replace('fypage', MY_PAGE)}`;
                    const res = JSON.parse(await request(url, { headers: rule.headers, timeout: searchTimeout }));
                    if (res && res.data) {
                        results = res.data.map(item => ({
                            vod_id: `百度@${item.id}`, vod_name: item.title, vod_pic: item.cover, vod_remarks: `百度短剧 | 更新至${item.totalChapterNum}集`,
                        }));
                    }
                    break;
                }
                case '甜圈': {
                    const url = `${plat.host}${plat.search}=${encodeURIComponent(KEY)}&offset=${MY_PAGE}`;
                    const res = JSON.parse(await request(url, { headers: rule.headers, timeout: searchTimeout }));
                    if (res && res.data) {
                        results = res.data.map(item => ({
                            vod_id: `甜圈@${item.book_id}`, vod_name: item.title, vod_pic: item.cover, vod_remarks: `甜圈短剧 | ${item.sub_title || '无简介'}`,
                        }));
                    }
                    break;
                }
                case '锦鲤': {
                    const body = JSON.stringify({ page: MY_PAGE, limit: searchLimit, type_id: '', year: '', keyword: KEY });
                    const res = JSON.parse(await request(plat.host + plat.search, { method: 'POST', body, headers: rule.headers, timeout: searchTimeout }));
                    if (res && res.data && res.data.list) {
                        results = res.data.list.map(item => ({
                            vod_id: `锦鲤@${item.vod_id}`, vod_name: item.vod_name || '未知短剧', vod_pic: item.vod_pic || '', vod_remarks: `锦鲤短剧 | ${item.vod_total || 0}集`,
                        }));
                    }
                    break;
                }
                case '番茄': {
                    const res = JSON.parse(await request(plat.search + '?keyword=' + encodeURIComponent(KEY) + '&page=' + MY_PAGE, { timeout: searchTimeout, headers: rule.headers }));
                    if (res && res.data && Array.isArray(res.data)) {
                        results = res.data.map(item => ({
                            vod_id: `番茄@${item.series_id || ''}`, vod_name: item.title || '未知标题', vod_pic: item.cover || '', vod_remarks: `番茄短剧 | ${item.sub_title || '无简介'}`,
                        }));
                    }
                    break;
                }
                case '星芽': {
                    const url = `${plat.host}${plat.search}`;
                    const body = JSON.stringify({ text: KEY });
                    const html = await request(url, { method: 'POST', headers: xingya_headers, body: body, timeout: searchTimeout });
                    
                    const res = JSON.parse(html);
                    if (res && res.data) {
                        results = res.data.theater.search_data.map(item => {
                            const id = `${plat.host}${plat.url2}?theater_parent_id=${item.id}`;
                            return {
                                vod_id: `星芽@${id}`, vod_name: item.title, vod_pic: item.cover_url || '', vod_remarks: `星芽短剧 | ${item.total || 0}集`,
                            };
                        });
                    }
                    break;
                }
                case '西饭': {
                    const ts = Math.floor(Date.now() / 1000);
                    const offset = (MY_PAGE - 1) * searchLimit;
                    const url = `${plat.host}${plat.search}?reqType=search&offset=${offset}&keyword=${encodeURIComponent(KEY)}&quickEngineVersion=-1&scene=&categoryVersion=1&density=1.5&pageID=page_theater&version=2001001&androidVersionCode=28&requestId=${ts}aa498144140ef297&appId=drama&teenMode=false&userBaseMode=false&session=eyJpbmZvIjp7InVpZCI6IiIsInJ0IjoiMTc0MDY1ODI5NCIsInVuIjoiT1BHXzFlZGQ5OTZhNjQ3ZTQ1MjU4Nzc1MTE2YzFkNzViN2QwIiwiZnQiOiIxNzQwNjU4Mjk0In19&feedssession=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dHlwIjowLCJidWlkIjoxNjMzOTY4MTI2MTQ4NjQxNTM2LCJhdWQiOiJkcmFtYSIsInZlciIowiwicmF0IjoxNzQwNjU4Mjk0LCJ1bm0iOiJPUEdfMWVkZDk5NmE2NDdlNDUyNTg3NzUxMTZjMWQ3NWI3ZDAiLCJpZCI6IjNiMzViZmYzYWE0OTgxNDQxNDBlZjI5N2JkMDY5NGNhIiwiZXhwIjoxNzQxMjYzMDk0LCJkYyI6Imd6cXkifQ.JS3QY6ER0P2cQSxAE_OGKSMIWNAMsYUZ3mJTnEpf-Rc`;
                    const res = JSON.parse(await request(url, { headers: cfg.headers.default, timeout: searchTimeout }));
                    if (res.result && res.result.elements) {
                         results = res.result.elements.map(vod => {
                             const dj = vod.duanjuVo;
                             if(dj) {
                                return {
                                    vod_id: `西饭@${dj.duanjuId}#${dj.source}`, vod_name: dj.title, vod_pic: dj.coverImageUrl, vod_remarks: `西饭短剧 | ${dj.total || 0}集`,
                                };
                             }
                             return null;
                         }).filter(Boolean);
                    }
                    break;
                }
                case '软鸭': {
                    const url = `${plat.host}${plat.search}/?keyword=${encodeURIComponent(KEY)}&page=${MY_PAGE}`;
                    const res = JSON.parse(await request(url, { headers: cfg.headers.default, timeout: searchTimeout }));
                    if (res && res.data) {
                        results = res.data.map(item => {
                            const purl = `${item.title}@${item.cover}@${item.author}@${item.type}@${item.desc}@${item.book_id}`;
                            return {
                                vod_id: `软鸭@${encodeURIComponent(purl)}`, vod_name: item.title, vod_pic: item.cover, vod_remarks: `软鸭短剧 | ${item.type || '无分类'}`,
                            };
                        });
                    }
                    break;
                }
                case '七猫': {
                    let signStr = `operation=2playlet_privacy=1search_word=${KEY}${cfg.keys}`;
                    const sign = await md5(signStr);
                    const url = `${plat.host}${plat.search}?search_word=${encodeURIComponent(KEY)}&playlet_privacy=1&operation=2&sign=${sign}`;
                    const headers = { ...await getHeaderX(), ...cfg.headers.default };
                    const res = JSON.parse(await request(url, { method: 'GET', headers, timeout: searchTimeout }));
                    if (res && res.data && res.data.list) {
                        results = res.data.list.map(item => ({
                            vod_id: `七猫@${encodeURIComponent(item.playlet_id)}`, vod_name: item.title || '未知标题', vod_pic: item.image_link || '', vod_remarks: `七猫短剧 | ${item.total_episode_num || 0}集`,
                        }));
                    }
                    break;
                }
                case '牛牛': {
                    const body = JSON.stringify({
                        condition: { name: KEY, typeId: 'S1' },
                        pageNum: MY_PAGE,
                        pageSize: searchLimit
                    });
                    const res = JSON.parse(await request(plat.host + plat.search, { method: 'POST', headers: cfg.headers.niuniu, body, timeout: searchTimeout }));
                    if (res && res.data && res.data.records) {
                        results = res.data.records.map(item => ({
                            vod_id: `牛牛@${item.id}`, vod_name: item.name, vod_pic: item.cover, vod_remarks: `牛牛短剧 | ${item.totalEpisode || 0}集`,
                        }));
                    }
                    break;
                }
                case '围观': {
                    const postData = JSON.stringify({
                        "audience": "", "page": MY_PAGE, "pageSize": searchLimit,
                        "searchWord": KEY, "subject": ""
                    });
                    const res = JSON.parse(await request(
                        `${plat.host}${plat.search}`,
                        { method: 'POST', body: postData, headers: rule.headers, timeout: searchTimeout }
                    ));
                    if (res && res.data && Array.isArray(res.data)) {
                        results = res.data.map(it => ({
                            vod_id: `围观@${it.oneId || ''}`, vod_name: it.title || '未知标题', vod_pic: it.vertPoster || '', vod_remarks: `围观短剧 | 集数:${it.episodeCount || 0} 播放:${it.viewCount || 0}`,
                        }));
                    }
                    break;
                }
                case '碎片': {
                    const token = await getSuipianToken();
                    const headers = { ...rule.headers, 'Authorization': token };
                    const url = `${plat.host}${plat.search}?type=5&tagId=&pageNum=${MY_PAGE}&pageSize=${searchLimit}&title=${encodeURIComponent(KEY)}`;
                    const res = JSON.parse(await request(url, { headers, timeout: searchTimeout }));
                    if(res && res.list){
                         results = res.list.map(it => ({
                            vod_id: `碎片@${it.itemId}@${it.videoCode}`, 
                            vod_name: it.title, 
                            vod_pic: "https://speed.hiknz.com/papaya/papaya-file/files/download/" + it.imageKey + "/" + it.imageName, 
                            vod_remarks: `碎片剧场 | 集数:${it.episodesMax}`,
                        }));
                    }
                    break;
                }
            }
            return { platform: platform.name, results: results || [] };
        } catch (error) {
            log(`搜索失败（平台：${platform.name}）：${error.message}`);
            return { platform: platform.name, results: [] };
        }
    });

    const searchResults = await Promise.allSettled(searchPromises);
    
    searchResults.forEach(result => {
        if (result.status === 'fulfilled' && result.value.results && result.value.results.length > 0) {
            d.push(...result.value.results);
        }
    });

    let finalResults = d;
    if (rule.search_match) {
        finalResults = d.filter(item => {
            const title = item.vod_name || '';
            return title.toLowerCase().includes(KEY.toLowerCase());
        });
    }
    
    // 聚合搜索的翻页逻辑 (客户端分页)
    const totalResults = finalResults.length;
    const offset = (MY_PAGE - 1) * searchLimit;
    const slicedResults = finalResults.slice(offset, offset + searchLimit);
    const totalPages = Math.ceil(totalResults / searchLimit);

    return {
        list: slicedResults, 
        page: MY_PAGE,
        pagecount: totalPages,
        total: totalResults,
    };
};

const _play = async ({ flag, flags, id }) => {
    const input = id;
    const cfg = aggConfig;

    console.log(`✅[_play] input: ${input}, flag: ${flag}`);
    
    switch (true) {
        case flag.includes('百度'): {
            const item = JSON.parse(await request(`https://api.jkyai.top/API/bddjss.php?video_id=${input}`));
            let qualities = item.data.qualities;
            let urls = [];
            const qualityOrder = ["1080p", "sc", "sd"];
            const qualityNames = { "1080p": "蓝光", "sc": "超清", "sd": "标清" };
            qualityOrder.forEach(qualityKey => {
                let quality = qualities.find(q => q.quality === qualityKey);
                if (quality) {
                  urls.push(qualityNames[qualityKey], quality.download_url);
                }
            });
            return { parse: 0, jx: 0, url: urls };
        }
        case flag.includes('甜圈短剧'): {
            return { parse: 0, jx: 0, url: `https://mov.cenguigui.cn/duanju/api.php?video_id=${input}&type=mp4` };
        }
        case flag.includes('锦鲤短剧'): {
            let playUrl = input;
            const html = await request(`${input}&auto=1`, { headers: { referer: 'https://www.jinlidj.com/' } });
            const match = html.match(/let data\s*=\s*({[^;]*});/);
            if (match?.[1]) {
                const data = JSON.parse(match[1]);
                playUrl = data.url || input;
            }
            return { parse: 0, jx: 0, url: playUrl };
        }
        case flag.includes('番茄短剧'): {
            const res = JSON.parse(await request(`https://fqgo.52dns.cc/video?item_ids=${input}`, { headers: cfg.headers.default }));
            const videoModel = res.data?.[input] ? JSON.parse(res.data[input].video_model) : null;
            const url = videoModel?.video_list?.video_1 ? atob(videoModel.video_list.video_1.main_url) : '';
            return { parse: 0, jx: 0, url};
        }
        case flag.includes('星芽短剧'): {
            return { parse: 0, jx: 0, url: input };
        }
        case flag.includes('西饭短剧'): {
            return { parse: 0, jx: 0, url: input };
        }
        case flag.includes('软鸭短剧'): {
            const res = JSON.parse(await request(`${cfg.platform.软鸭.host}/API/playlet/?video_id=${input}&quality=1080p`, { headers: cfg.headers.default }));
            return { parse: 0, jx: 0, url: res.data?.video?.url || '' };
        }
        case flag.includes('七猫短剧'): {
            return { parse: 0, jx: 0, url: input };
        }
        case flag.includes('牛牛短剧'): {
            const [videoId, episodeId] = input.split('@');
            const body = JSON.stringify({ episodeId, id: videoId, source: 0, typeId: 'S1', userId: '223664' });
            const res = JSON.parse(await request(`${cfg.platform.牛牛.host}/api/v1/app/play/movieDetails`, {
                method: 'POST',
                headers: cfg.headers.niuniu,
                body
            }));
            return {
                parse: 0, jx: 0, url: res.data?.url || '',
                header: { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36' }
            };
        }
        case flag.includes('围观短剧'): {
            let playSetting;
            try {
                playSetting = typeof input === 'string' ? JSON.parse(input) : input;
            } catch (e) {
                return { parse: 0, jx: 0, url: input };
            }
            let singleUrl = '';
            if (playSetting.super) {
                singleUrl = playSetting.super;
            } else if (playSetting.high) {
                singleUrl = playSetting.high;
            } else if (playSetting.normal) {
                singleUrl = playSetting.normal;
            }
            return { parse: 0, jx: 0, url: singleUrl };
        }
        case flag.includes('碎片剧场'): {
             return { parse: 0, jx: 0, url: input };
        }
        default:
            return { parse: 0, jx: 0, url: id, header: {} };
    }
};

const _proxy = async (req, reply) => {
    return Object.assign({}, req.query, req.params);
};

const meta = {
    key: "jhdj", 
    name: "短剧聚合",
    type: 4,
    api: "/video/jhdj",
    searchable: 1,
    quickSearch: 1,
    filterable: 1,
    changeable: 0,
};

module.exports = async (app, opt) => {
    await initXingYaToken();
    
    app.get(meta.api, async (req, reply) => {
        const { extend, filter, t, ac, pg, ext, ids, flag, play, wd, quick } =
            req.query;
        
        const page = parseInt(pg || "1");

        let filters = {};
        if (ext) {
            try {
                const decodedStr = CryptoJS.enc.Base64.parse(ext).toString(CryptoJS.enc.Utf8);
                filters = JSON.parse(decodedStr);
            } catch (e) {
                console.error("Filter decoding failed:", e);
            }
        }
        
        if (play) {
            return await _play({ flag: flag || "", flags: [], id: play });
        } 
        else if (wd) {
            return await _search({
                page: page,
                quick: quick || false,
                wd: wd,
            });
        } 
        else if (!ac) {
            return await _home({ filter: filter ?? false });
        } 
        else if (ac === "detail") {
            if (t) {
                const body = {
                    id: t, 
                    page: page,
                    filter: filter || false,
                    filters: filters, 
                };
                return await _category(body);
            } 
            else if (ids) {
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