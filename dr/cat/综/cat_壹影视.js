// 本资源来源于互联网公开渠道，仅可用于个人学习爬虫技术。
// 严禁将其用于任何商业用途，下载后请于 24 小时内删除，搜索结果均来自源站，本人不承担任何责任。

import { Crypto, _ } from 'assets://js/lib/cat.js';
let host = 'https://aleig4ah.yiys05.com', token = '', appId = '';
const publicKey = '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw4qpeOgv+MeXi57MVPqZF7SRmHR3FUelCTfrvI6vZ8kgTPpe1gMyP/8ZTvedTYjTDMqZBmn8o8Ym98yTx3zHaskPpmDR80e+rcRciPoYZcWNpwpFkrHp1l6Pjs9xHLXzf3U+N3a8QneY+jSMvgMbr00DC4XfvamfrkPMXQ+x9t3gNcP5YtuRhGFREBKP2q20gP783MCOBFwyxhZTIAsFiXrLkgZ97uaUAtqW6wtKR4HWpeaN+RLLxhBdnVjuMc9jaBl6sHMdSvTJgAajBTAd6LLA9cDmbGTxH7RGp//iZU86kFhxGl5yssZvBcx/K95ADeTmLKCsabexZVZ0Fu3dDQIDAQAB\n-----END PUBLIC KEY-----';
const baseHeaders = {
    'User-Agent': 'Android/OkHttp',
    'Connection': 'Keep-Alive'
};

async function init(cfg) {
    if (cfg.ext && cfg.ext.startsWith('http')) {
        host = cfg.ext;
    }
    const androidIdKey = 'yiys_zNiOFyj0r4ux';
    appId = await local.get(androidIdKey, 'androidId');
    if (!appId) {
        appId = getAndroidId();
        await local.set(androidIdKey,'androidId', appId);
    }
    if (!token) {
        await refreshToken();
    }
}

async function home(filter) {
    if (!host) return JSON.stringify({ class: [] });
    const params = { 'timestamp': getTimestamp() };
    const url = `${host}/vod-app/type/list?${toQueryString(params)}`;
    const res = await request(url, { method: 'GET' }, params);
    const json = JSON.parse(res.content);
    const classes = [];
    const filters = {};
    if (json.data) {
        for (const i of json.data) {
            const typeId = i.typeId.toString();
            classes.push({type_id: typeId, type_name: i.typeName});
            if (i.type_extend_obj) {
                const ext = i.type_extend_obj;
                const typeFilters = [];
                const buildFilter = (key, name, valuesStr, isSort = false) => {
                    const valArr = [];
                    if (!isSort) {
                        valArr.push({ n: '全部', v: '' });
                    }
                    if (valuesStr) {
                        const splits = valuesStr.split(',');
                        for (const s of splits) {
                            if (s.trim()) {
                                valArr.push({ n: s.trim(), v: s.trim() });
                            }
                        }
                    } else if (isSort) {
                        valArr.push({ n: '新上线', v: 'time' });
                        valArr.push({ n: '热播榜', v: 'hits_day' });
                        valArr.push({ n: '好评榜', v: 'score' });
                    }
                    return {key: key, name: name, value: valArr, init: isSort ? 'time' : ''};
                };
                if (ext.class) typeFilters.push(buildFilter('class', '类型', ext.class));
                if (ext.area) typeFilters.push(buildFilter('area', '地区', ext.area));
                if (ext.lang) typeFilters.push(buildFilter('lang', '语言', ext.lang));
                if (ext.year) typeFilters.push(buildFilter('year', '年份', ext.year));
                typeFilters.push(buildFilter('sort', '排序', '', true));
                if (typeFilters.length > 0) {
                    filters[typeId] = typeFilters;
                }
            }
        }
    }
    return JSON.stringify({ class: classes, filters: filters });
}

async function homeVod() {
    const params = { 'timestamp': getTimestamp() };
    const url = `${host}/vod-app/rank/hotHits?${toQueryString(params)}`;
    const res = await request(url, { method: 'GET' }, params);
    const json = JSON.parse(res.content);
    let videos = [];
    if (json.data) {
        for (const i of json.data) {
            if (i.vodBeans) {
                videos = videos.concat(arr2vods(i.vodBeans));
            }
        }
    }
    return JSON.stringify({ list: videos });
}

async function category(tid, pg, filter, extend) {
    const rawPayload = {
        'tid': tid,
        'page': pg,
        'limit': '12',
        'timestamp': getTimestamp(),
        'classType': extend.class || '',
        'area': extend.area || '',
        'lang': extend.lang || '',
        'year': extend.year || '',
        'by': extend.sort || 'time'
    };
    const payload = _.pickBy(rawPayload, (value) => value !== '' && value !== null && value !== undefined);
    const res = await request(`${host}/vod-app/vod/list`, {
        method: 'POST',
        data: payload,
        postType: 'form'
    }, payload);
    const json = JSON.parse(res.content);
    const data = json.data;
    return JSON.stringify({
        list: arr2vods(data.data),
        page: parseInt(pg),
        pagecount: data.totalPageCount
    });
}

async function search(wd, quick, pg=1) {
    const timestamp = getTimestamp();
    const payload = {
        'key': wd,
        'limit': '20',
        'page': pg.toString(),
        'timestamp': timestamp
    };
    const res = await request(`${host}/vod-app/vod/segSearch`, {
        method: 'POST',
        data: payload,
        postType: 'form'
    }, payload);
    const json = JSON.parse(res.content);
    const data = json.data;
    return JSON.stringify({list: arr2vods(data.data), page: parseInt(pg)});
}

async function detail(id) {
    const timestamp = getTimestamp();
    const payload = {
        'tid': '',
        'timestamp': timestamp,
        'vodId': id.toString()
    };
    const res = await request(`${host}/vod-app/vod/info`, {
        method: 'POST',
        data: payload,
        postType: 'form'
    }, payload);
    const json = JSON.parse(res.content);
    const data = json.data;
    const show = [], play_urls = [];
    if (data.vodSources) {
        data.vodSources.sort((a, b) => {
            return (a.sort || 0) - (b.sort || 0);
        });
        for (const i of data.vodSources) {
            const urls = [];
            if (i.vodPlayList && i.vodPlayList.urls) {
                for (const j of i.vodPlayList.urls) {
                    urls.push(`${j.name}$${i.sourceCode}@${j.url}`);
                }
            }
            play_urls.push(urls.join('#'));
            show.push(i.sourceName);
        }
    }
    const video = {
        'vod_id': data.vodId,
        'vod_name': data.vodName,
        'vod_pic': data.vodPic,
        'vod_remarks': data.vodRemark,
        'vod_year': data.vodYear,
        'vod_area': data.vodArea,
        'vod_actor': data.vodActor,
        'vod_content': data.vodContent,
        'vod_play_from': show.join('$$$'),
        'vod_play_url': play_urls.join('$$$'),
        'type_name': data.vodClass
    };
    return JSON.stringify({ list: [video] });
}

async function play(flag, vid, flags) {
    let jx = 0, url = '';
    const parts = vid.split('@'), sourceCode = parts[0];
    let rawUrl = parts.slice(1).join('@');
    if (rawUrl.slice(0, 4) === 'http'){ rawUrl = encodeURIComponent(rawUrl); }
    const timestamp = getTimestamp();
    const payload = {
        'sourceCode': sourceCode,
        'timestamp': timestamp,
        'urlEncode': rawUrl
    };
    try {
        const res = await request(`${host}/vod-app/vod/playUrl`, {
            method: 'POST',
            data: payload,
            postType: 'form'
        }, payload);
        const json = JSON.parse(res.content);
        if (json.data && json.data.url) {
            const playUrl = json.data.url;
            if (playUrl.startsWith('http')) {
                url = playUrl;
            }
        }
    } catch (e) {}
    if (!url) {
        url = rawUrl;
        if (/(?:www\.iqiyi|v\.qq|v\.youku|www\.mgtv|www\.bilibili)\.com/.test(url)) {
            jx = 1;
        }
    }
    return JSON.stringify({jx: jx, parse: 0, url: url, header: {'User-Agent': baseHeaders['User-Agent']}});
}

async function refreshToken() {
    const payload = {'appID': appId, 'timestamp': getTimestamp()};
    try {
        const res = await req(`${host}/vod-app/index/getGenerateKey`, {
            method: 'POST',
            headers: {...baseHeaders, 'APP-ID': appId, 'X-Auth-Flow': '1'},
            data: payload,
            postType: 'form'
        });
        const json = JSON.parse(res.content);
        if (json.data) {
            token = rsaPublicDecrypt(json.data);
            return true;
        }
    } catch (e) {}
    return false;
}

async function request(url, opt, params) {
    let headers = getHeaders(params);
    let res = await req(url, { ...opt, headers: headers });
    if (res.code === 400 || (Object.keys(res.headers).length === 0 && res.content === '')) {
        await refreshToken();
        headers = getHeaders(params);
        res = await req(url, { ...opt, headers: headers });
    }
    return res;
}

function computeHash(params) {
    const sortedKeys = Object.keys(params).sort();
    const pairs = [];
    for (const key of sortedKeys) {
        pairs.push(`${key}=${params[key]}`);
    }
    const fullStr = `${pairs.join('&')}&token=${token}`;
    return Crypto.SHA256(fullStr).toString(Crypto.enc.Hex);
}

function getAndroidId() {
    const chars = '0123456789abcdef';
    let res = '';
    for (let i = 0; i < 16; i++) {
        res += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return res;
}

function rsaPublicDecrypt(content) {
    try {
        return rsaX('RSA/PKCS1', true, false, content, true, publicKey, false);
    } catch (e) {
        return '';
    }
}

function getHeaders(params) {
    const h = {...baseHeaders, 'APP-ID': appId, 'Authorization': ''};
    if (params) {
        h['X-HASH-Data'] = computeHash(params);
    }
    return h;
}

function toQueryString(obj) {
    return Object.keys(obj)
        .map(k => `${encodeURIComponent(k)}=${encodeURIComponent(obj[k])}`)
        .join('&');
}

const getTimestamp = () => Math.floor(Date.now() / 1000).toString();

function arr2vods(arr) {
    return _.map(arr, (j) => ({
        vod_id: j.id,
        vod_name: j.name,
        vod_pic: j.vodPic,
        vod_remarks: j.vodRemarks,
        vod_year: j.vodYear,
        vod_content: j.vodBlurb
    }));
}

export function __jsEvalReturn() {
    return {
        init: init,
        home: home,
        homeVod: homeVod,
        category: category,
        search: search,
        detail: detail,
        play: play
    };
}
