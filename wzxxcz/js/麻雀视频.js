// 本资源来源于互联网公开渠道，仅可用于个人学习爬虫技术。
// 严禁将其用于任何商业用途，下载后请于 24 小时内删除，搜索结果均来自源站，本人不承担任何责任。

import { Crypto, _ } from 'assets://js/lib/cat.js';
let host = 'https://www.mqtv.cc';
const key = 'Mcxos@mucho!nmme';
const main_headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36',
    'accept-language': 'zh-CN,zh;q=0.9',
    'sec-ch-ua': '"Google Chrome";v="143", "Chromium";v="143", "Not A(Brand";v="24"',
    'cache-control': 'no-cache',
    'pragma': 'no-cache',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-site': 'same-origin'
};

async function init(cfg) {
    if (cfg.ext && cfg.ext.startsWith('http')) {
        host = cfg.ext.trim().replace(/\/$/, '');
    }
}

async function home(filter) {
    if (!host) return JSON.stringify({ class: [] });
    return JSON.stringify({
        class: [
            { 'type_id': '/type/movie', 'type_name': '电影' },
            { 'type_id': '/type/tv', 'type_name': '电视剧' },
            { 'type_id': '/type/va', 'type_name': '综艺' },
            { 'type_id': '/type/ct', 'type_name': '动漫' }
        ]
    });
}

async function homeVod() {
    const token = await getToken('/');
    const url = `${host}/libs/VodList.api.php?home=index&token=${token}`;
    const resp = await req(url, { headers: getHeaders2('/') });
    const json = JSON.parse(resp.content);
    let videos = [];
    if (json.data && json.data.movie) {
        for (const i of json.data.movie) {
            videos.push(...arr2vods(i.show));
        }
    }
    return JSON.stringify({ list: videos });
}

async function category(tid, pg, filter, extend) {
    const typeKey = tid.split('/')[2];
    const token = await getToken(tid, '/');
    const url = `${host}/libs/VodList.api.php?type=${typeKey}&rank=rankhot&cat=&year=&area=&page=${pg}&token=${token}`;
    const resp = await req(url, { headers: getHeaders2(tid) });
    const json = JSON.parse(resp.content);
    return JSON.stringify({
        list: arr2vods(json.data),
        page: parseInt(pg)
    });
}

async function search(wd, quick, pg=1) {
    const path = `/search/${encodeURIComponent(wd)}`;
    const token = await getToken(path, '/');
    const url = `${host}/libs/VodList.api.php?search=${encodeURIComponent(wd)}&token=${token}`;
    const resp = await req(url, { headers: getHeaders2(path) });
    const json = JSON.parse(resp.content);
    const data = decodeData(json.data);
    let videos = [];
    if (data.vod_all) {
        for (const i of data.vod_all) {
            if (_.isPlainObject(i)) {
                videos.push(...arr2vods(i.show));
            }
        }
    }
    return JSON.stringify({ list: videos, pagecount: 1, page: parseInt(pg) });
}

async function detail(id) {
    const idParts = id.split('/');
    const realId = idParts[idParts.length - 1];
    const token = await getToken(id, '/');
    const url = `${host}/libs/VodInfo.api.php?type=ct&id=${realId}&token=${token}`;
    const resp = await req(url, { headers: getHeaders2(id) });
    const json = JSON.parse(resp.content);
    const data = json.data;
    const parsesArr = [];
    const playApi = data.playapi || [];
    for (const i of playApi) {
        if (_.isPlainObject(i) && i.url && typeof i.url === 'string') {
            if (i.url.startsWith('//')) {
                parsesArr.push(`https:${i.url}`);
            } else {
                parsesArr.push(i.url);
            }
        }
    }
    const parses = parsesArr.join(',');
    const shows = [];
    const playUrls = [];
    if (data.playinfo) {
        for (const j of data.playinfo) {
            const urls = [];
            for (const k of j.player) {
                urls.push(`${k.no}$${k.url}@${parses}`);
            }
            if (urls.length > 0) {
                playUrls.push(urls.join('#'));
                shows.push(j.cnsite);
            }
        }
    }
    const video = {
        'vod_id': id,
        'vod_name': data.title,
        'vod_pic': data.img,
        'vod_remarks': data.remark,
        'vod_year': data.year,
        'vod_area': data.area,
        'vod_actor': data.actor,
        'vod_director': data.director,
        'vod_content': '',
        'vod_play_from': shows.join('$$$'),
        'vod_play_url': playUrls.join('$$$'),
        'type_name': ''
    };
    return JSON.stringify({ list: [video] });
}

async function play(flag, vid, flags) {
    const parts = vid.split('@');
    const rawUrl = parts[0];
    const parsesStr = parts[1] || '';
    const parses = parsesStr.split(',');
    let jx = 0;
    let sniff = 0;
    let url = '';
    for (const parseUrl of parses) {
        try {
            const apiUrl = `${parseUrl}${rawUrl}`;
            const resp = await req(apiUrl, { headers: main_headers, timeout: 10000 });
            const html = resp.content;
            const charsetMatch = html.match(/<(?:\s+)?meta(?:\s+)?charset="UTF-8"(?:\s+)?id(?:\s+)?=(?:\s+)?"now_(.*?)"(?:\s+)?>/i);
            const viewportMatch = html.match(/<(?:\s+)?meta(?:\s+)?name(?:\s+)?=(?:\s+)?"viewport".*?id(?:\s+)?=(?:\s+)?"now_(.*?)">/i);
            const urlMatch = html.match(/"url"(?:\s+)?:\s+?"(.*?)",/i);
            if (charsetMatch && viewportMatch && urlMatch) {
                const charsetMetaId = charsetMatch[1];
                const viewportMetaId = viewportMatch[1];
                const encryptedUrl = urlMatch[1];
                const playUrl = decryptUrl(encryptedUrl, viewportMetaId, charsetMetaId);
                if (playUrl.startsWith('http')) {
                    url = playUrl;
                    break;
                }
            }
        } catch (e) {
            console.warn(e)}
    }
    if (!url) {
        if (rawUrl.startsWith('http') && /(?:www\.iqiyi|v\.qq|v\.youku|www\.mgtv|www\.bilibili)\.com/.test(rawUrl)) {
            url = rawUrl;
            jx = 1;
        } else {
            for (const j of parses) {
                if (j.startsWith('http')) {
                    url = `${j}${rawUrl}`;
                    sniff = 1;
                    break;
                }
            }
        }
    }
    return JSON.stringify({jx: jx, parse: sniff, url: url, header: {'User-Agent': main_headers['User-Agent']}});
}

function decryptUrl(encryptedStr, viewportMetaId, charsetMetaId) {
    try {
        const idTextList = [];
        for (let i = 0; i < charsetMetaId.length; i++) {
            const idChar = charsetMetaId[i];
            const textChar = i < viewportMetaId.length ? viewportMetaId[i] : '';
            idTextList.push({ id: idChar, text: textChar });
        }
        idTextList.sort((a, b) => parseInt(a.id) - parseInt(b.id));
        const seed = idTextList.map(item => item.text).join('');
        const md5Result = md5X(`${seed}lemon`);
        const iv = md5Result.substring(0, 16);
        const keyStr = md5Result.substring(16);
        return aesX('AES/CBC/PKCS7', false, encryptedStr, true, keyStr, iv, false);
    } catch (e) {
        return '';
    }
}

async function getToken(path, refPath = '') {
    const headers = {
        ...main_headers,
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'priority': 'u=0, i',
        'sec-fetch-dest': 'document',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-user': '?1',
        'upgrade-insecure-requests': '1'
    };
    if (refPath) headers['referer'] = `${host}${refPath}`;
    const resp = await req(`${host}${path}`, { headers });
    const content = resp.content;
    const match = content.match(/window\.pageid\s?=\s?'(.*?)';/i);
    const pageId = match ? match[1] : '';
    return encodeData(pageId);
}

function encodeData(data) {
    const jsonStr = JSON.stringify(data);
    const b64_1 = strToBase64(jsonStr);
    let xor_result = '';
    const keyLen = key.length;
    for (let i = 0; i < b64_1.length; i++) {
        const charCode = b64_1.charCodeAt(i) ^ key.charCodeAt(i % keyLen);
        xor_result += String.fromCharCode(charCode);
    }
    const b64_2 = strToBase64(xor_result);
    return encodeURIComponent(b64_2);
}

function decodeData(encodedStr) {
    try {
        const decodedStep1Str = base64ToStr(encodedStr);
        let xorResult = '';
        const keyLen = key.length;
        for (let i = 0; i < decodedStep1Str.length; i++) {
            const charCode = decodedStep1Str.charCodeAt(i) ^ key.charCodeAt(i % keyLen);
            xorResult += String.fromCharCode(charCode);
        }
        const decodedStep2Str = base64ToStr(xorResult);
        return JSON.parse(decodedStep2Str);
    } catch (e) {
        console.error('Decode error:', e);
        return {};
    }
}

function getHeaders2(refPath = '') {
    const headers = {
        ...main_headers,
        'Accept': 'application/json, text/javascript, */*; q=0.01',
        'priority': 'u=1, i',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'x-requested-with': 'XMLHttpRequest'
    };
    if (refPath) headers['referer'] = `${host}${refPath}`;
    return headers;
}

function arr2vods(arr) {
    return (arr || []).map(i => ({
        'vod_id': i.url,
        'vod_name': i.title,
        'vod_pic': i.img,
        'vod_remarks': i.remark,
        'vod_year': null
    }));
}

function strToBase64(str) {
    return Crypto.enc.Base64.stringify(Crypto.enc.Utf8.parse(str));
}

function base64ToStr(b64) {
    return Crypto.enc.Utf8.stringify(Crypto.enc.Base64.parse(b64));
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