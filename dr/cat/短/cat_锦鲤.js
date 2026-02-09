//本资源来源于互联网公开渠道，仅可用于个人学习爬虫技术。
//严禁将其用于任何商业用途，下载后请于 24 小时内删除，搜索结果均来自源站，本人不承担任何责任。

const api_host = 'https://api.jinlidj.com';
const origin = 'https://www.jinlidj.com';
const api_path = '/api/search';
const headers = {
    'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36",
    'Content-Type': "application/json",
    'accept-language': "zh-CN,zh;q=0.9",
    'cache-control': "no-cache",
    'origin': origin,
    'pragma': "no-cache",
    'priority': "u=1, i",
    'referer': origin + '/',
    'sec-ch-ua': '"Not)A;Brand";v="8", "Chromium";v="138", "Google Chrome";v="138"',
    'sec-ch-ua-mobile': "?0",
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-dest': "empty",
    'sec-fetch-mode': "cors",
    'sec-fetch-site': "same-site"
};

async function init(cfg) {}

async function home(filter) {
    const classes = [
        { 'type_id': 1, 'type_name': '情感关系' },
        { 'type_id': 2, 'type_name': '成长逆袭' },
        { 'type_id': 3, 'type_name': '奇幻异能' },
        { 'type_id': 4, 'type_name': '战斗热血' },
        { 'type_id': 5, 'type_name': '伦理现实' },
        { 'type_id': 6, 'type_name': '时空穿越' },
        { 'type_id': 7, 'type_name': '权谋身份' }
    ];
    return JSON.stringify({ class: classes });
}

async function homeVod() {
    const payload = {
        "page": 1,
        "limit": 24,
        "type_id": "",
        "year": "",
        "keyword": ""
    };
    const json = await postJson(`${api_host}${api_path}`, payload);
    const list = json.data.list || [];
    const videos = list.map(formatVideo);
    return JSON.stringify({ list: videos });
}

async function category(tid, pg, filter, extend) {
    const payload = {
        "page": parseInt(pg),
        "limit": 24,
        "type_id": tid,
        "year": "",
        "keyword": ""
    };
    const json = await postJson(`${api_host}${api_path}`, payload);
    const list = json.data.list || [];
    const videos = list.map(formatVideo);
    return JSON.stringify({ list: videos, page: parseInt(pg) });
}

async function search(wd, quick, pg=1) {
    const payload = {
        "page": pg,
        "limit": 24,
        "type_id": "",
        "keyword": wd
    };
    const json = await postJson(`${api_host}${api_path}`, payload);
    const data = json.data;
    const list = data.list || [];
    const videos = list.map(formatVideo);
    return JSON.stringify({ list: videos, page: parseInt(pg) });
}

async function detail(id) {
    const payload = {};
    const json = await postJson(`${api_host}/api/detail/${id}`, payload);
    const data = json.data;
    let play_urls = [];
    if (data.player) {
        for (const [name, url] of Object.entries(data.player)) {
            play_urls.push(`${name}$${url}&auto=1`);
        }
    }
    const video = {
        'vod_id': data.vod_id,
        'vod_name': data.vod_name,
        'vod_pic': data.vod_pic,
        'vod_type': data.vod_class,
        'vod_year': data.vod_year,
        'vod_area': data.vod_area,
        'vod_remarks': '集数：' + data.vod_total,
        'vod_director': data.vod_director,
        'vod_actor': data.vod_actor,
        'vod_content': data.vod_blurb,
        'vod_play_from': '锦鲤短剧',
        'vod_play_url': play_urls.join('#')
    };
    return JSON.stringify({ list: [video] });
}

async function play(flag, id, flags) {
    let parse = 0;
    let url = id;
    const playHeader = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36'};
    try {
        const res = await req(id, { headers: headers });
        const content = res.content;
        const match = content.match(/let\s+data\s*=\s*(\{[^}]*http[^}]*\});/i);
        if (match && match[1]) {
            const jsonStr = match[1];
            const data = JSON.parse(jsonStr);
            if (data.url) {
                url = data.url;
            }
        } else {
            parse = 1;
        }
    } catch (e) {
        parse = 1;
    }
    return JSON.stringify({parse: parse, url: url, header: playHeader});
}

async function postJson(url, payload) {
    const res = await req(url, {
        method: 'POST',
        headers: headers,
        data: payload
    });
    return JSON.parse(res.content);
}

function formatVideo(i) {
    return {
        'vod_id': i.vod_id,
        'vod_name': i.vod_name,
        'vod_pic': i.vod_pic,
        'vod_remarks': (i.vod_total || '') + '集',
        'vod_year': i.vod_year,
        'vod_score': i.vod_score
    };
}

export function __jsEvalReturn() {
    return {
        init: init,
        home: home,
        homeVod: homeVod,
        category: category,
        detail: detail,
        play: play,
        search: search
    };
}
