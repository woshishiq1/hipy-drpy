// 本资源来源于互联网公开渠道，仅可用于个人学习爬虫技术。
// 严禁将其用于任何商业用途，下载后请于 24 小时内删除，搜索结果均来自源站，本人不承担任何责任。

import {Crypto,_} from 'assets://js/lib/cat.js';
let host = 'http://su.haotv.site';
const headers = {
    'User-Agent': 'okhttp/3.12.11',
    'Connection': 'Keep-Alive'
};

async function init(cfg) {
    if (cfg.ext && cfg.ext.startsWith('http')) {
        host = cfg.ext.trim().replace(/\/$/, '');
    }
}

async function home(filter) {
    const resp = await req(`${host}/api.php/v2.vod/androidtypes`, { headers });
    const json = JSON.parse(resp.content);
    const filters = {};
    const class_list = [];
    for (const item of json.data) {
        const type_id = item.type_id || '';
        if (type_id !== '') {
            class_list.push({ 'type_id': type_id.toString(), 'type_name': item.type_name });
            const createFilter = (name, key, list) => {
                const values = [{ 'n': '全部', 'v': '' }];
                for (const v of (list || [])) if (v !== '') values.push({ 'n': v, 'v': v });
                return { 'key': key, 'name': name, 'init': '', 'value': values };
            };
            filters[type_id] = [
                createFilter('类型', 'class', item.classes),
                createFilter('地区', 'area', item.areas),
                createFilter('年份', 'year', item.years),
                {
                    'key': 'sortby',
                    'name': '排序',
                    'init': 'updatetime',
                    'value': [{ 'n': '时间', 'v': 'updatetime' }, { 'n': '人气', 'v': 'hits' }, { 'n': '评分', 'v': 'score' }]
                }
            ];
        }
    }
    return JSON.stringify({ class: class_list, filters: filters });
}

async function homeVod() {
    const resp = await req(`${host}/api.php/v2.main/androidhome`, { headers });
    const json = JSON.parse(resp.content);
    let videos = arr2vods(json.data.top || []);
    for (const i of (json.data.list || [])) {
        if (_.isPlainObject(i)) videos.push(...arr2vods(i.list));
    }
    return JSON.stringify({ list: videos });
}

async function category(tid, pg, filter, extend) {
    const query = {
        'page': pg,
        'type': tid,
        'area': extend.area || '',
        'year': extend.year || '',
        'sortby': extend.sortby || '',
        'class': extend.class || ''
    };
    const queryString = Object.keys(query)
        .map(k => `${k}=${encodeURIComponent(query[k])}`)
        .join('&');

    const url = `${host}/api.php/v2.vod/androidfilter10086?${queryString}`;
    const resp = await req(url, { headers });
    const json = JSON.parse(resp.content);
    return JSON.stringify({ list: arr2vods(json.data), page: pg });
}

async function search(wd, quick, pg=1) {
    const url = `${host}/api.php/v2.vod/androidsearch10086?page=1&wd=${encodeURIComponent(wd)}`;
    const resp = await req(url, { headers });
    return JSON.stringify({ list: arr2vods(JSON.parse(resp.content).data), page: pg });
}

async function detail(id) {
    const hd = await getXpgHeaders();
    const resp = await req(`${host}/api.php/v3.vod/androiddetail2?vod_id=${id}`, { headers: hd });
    const data = JSON.parse(resp.content).data;
    const play_urls = (data.urls || [])
        .filter(i => !['及时雨', '及時雨'].includes(i.key) && i.url !== 'dlNQWVppbnZXVVZsZnRhMnRpTkVNT2JaTnpyS010VEs=')
        .map(i => `${i.key}$${i.url}`);

    return JSON.stringify({
        list: [{
            'vod_id': data.id.toString(),
            'vod_name': data.name,
            'vod_pic': data.pic,
            'vod_year': data.year,
            'vod_area': data.area,
            'vod_actor': data.actor,
            'vod_director': data.director,
            'vod_content': data.content,
            'vod_play_from': 'LiteApple',
            'vod_play_url': play_urls.join('#'),
            'type_name': data.className,
        }]
    });
}

async function play(flag, vid, flags) {
    let parse = 0;
    let url = '';
    let playHeader = {};

    if (vid.startsWith('JBN_')) {
        url = 'https://www.yangshipin.cn/tv/home?pid=' + vid.substring(4);
        parse = 1;
        playHeader = { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' };
    } else if (vid.toUpperCase().includes('HTTP')) {
        url = vid;
    } else {
        url = 'http://s.xpgtv.net/m3u8/' + vid + '.m3u8';
        const hd = await getXpgHeaders();
        playHeader = { ...hd, 'User-Agent': 'com.stub.StubApp/1.6.0 (Linux;Android 12) ExoPlayerLib/2.14.2' };
    }

    return JSON.stringify({ jx: 0, parse: parse, url: url, header: playHeader });
}

function xpgCipher(dataStr) {
    const data = stringToUint8Array(dataStr);
    const key = stringToUint8Array('XPINGGUO');
    const box = new Uint8Array(333);
    for (let i = 0; i < 333; i++) box[i] = i % 256;
    let j = 0;
    for (let i = 0; i < 333; i++) {
        const k = key[i % key.length] & 0xFF;
        j = (k + (box[i] & 0xFF) + j) % 333;
        const tmp = box[i];
        box[i] = box[j];
        box[j] = tmp;
    }
    const res = new Uint8Array(data.length);
    let i6 = 0;
    let i7 = 0;
    for (let i = 0; i < data.length; i++) {
        i6 = (i6 + 1) % 333;
        const b2 = box[i6];
        i7 = (i7 + (b2 & 0xFF)) % 333;
        const tmp = box[i6];
        box[i6] = box[i7];
        box[i7] = tmp;
        const idx = ((box[i6] & 0xFF) + (box[i7] & 0xFF)) % 333;
        res[i] = box[idx] ^ data[i];
    }
    return res;
}

async function getXpgHeaders() {
    const tokenParamKey = 'com.phoenix.tv_token_param';
    const token2Key = 'com.phoenix.tv_token2';
    let tokenParam = await local.get('cache', tokenParamKey);
    if (!tokenParam) {
        const r32 = uint8ToBase64(stringToUint8Array(generateRand(32)));
        const r11 = generateRand(11, true);
        tokenParam = `${r32}||||${r11}||||unknown||xiaomi/b0q/b0q:12/V417IR/913:user/release-keys`;
        await local.set('cache', tokenParamKey, tokenParam);
    }
    let token2 = await local.get('cache', token2Key);
    if (!token2) {
        const r32 = uint8ToBase64(stringToUint8Array(generateRand(32)));
        token2 = xpgEncrypt(r32);
        await local.set('cache', token2Key, token2);
    }
    const timestamp = Math.floor(Date.now() / 1000).toString();
    const version = 'XPGBOX com.phoenix.tv1.6.0';
    return {
        ...headers,
        'token': xpgEncrypt(tokenParam),
        'token2': token2,
        'user_id': 'XPGBOX',
        'version': version,
        'timestamp': timestamp,
        'hash': md5Short(`${tokenParam}${version}${timestamp}`),
        'screenx': '1600',
        'screeny': '900'
    };
}

function arr2vods(arr) {
    const videos = [];
    if (Array.isArray(arr)) {
        for (const i of arr) {
            videos.push({
                'vod_id': i.id.toString(),
                'vod_name': i.name,
                'vod_pic': i.pic,
                'vod_remarks': i.updateInfo,
                'vod_year': i.year,
                'vod_content': i.content
            });
        }
    }
    return videos;
}

function stringToUint8Array(str) {
    const arr = [];
    for (let i = 0; i < str.length; i++) {
        const code = str.charCodeAt(i);
        if (code < 0x80) arr.push(code);
        else if (code < 0x800) {
            arr.push(0xc0 | (code >> 6));
            arr.push(0x80 | (code & 0x3f));
        } else {
            arr.push(0xe0 | (code >> 12));
            arr.push(0x80 | ((code >> 6) & 0x3f));
            arr.push(0x80 | (code & 0x3f));
        }
    }
    return new Uint8Array(arr);
}

function uint8ToBase64(uint8) {
    const wordArray = Crypto.lib.WordArray.create(uint8);
    return Crypto.enc.Base64.stringify(wordArray);
}

function generateRand(len, isHex = false) {
    const chars = isHex ? '0123456789ABCDEF' : 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let res = '';
    for (let i = 0; i < len; i++) res += chars[_.random(0, chars.length - 1)];
    return res;
}

function xpgEncrypt(s) {
    if (!s) return '';
    const encrypted = xpgCipher(s);
    return uint8ToBase64(encrypted);
}

function md5Short(s) {
    const full = md5X(s);
    return full.substring(8, 12);
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
