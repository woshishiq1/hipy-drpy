const axios = require("axios");
const CryptoJS = require("crypto-js");

async function req(url, options = {}) {
    try {
        const response = await axios({
            url: url,
            method: options.method || 'GET',
            headers: options.headers || {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36'
            },
            data: options.body || null,
            timeout: options.timeout || 15000,
        });

        return {
            content: typeof response.data === 'object' ? JSON.stringify(response.data) : response.data
        };
    } catch (error) {
        console.error(`[请求失败] URL: ${url} | 错误: ${error.message}`);
        return { content: "{}" };
    }
}

let host = 'https://qqqys.com';

function json2vods(arr) {
    let videos = [];
    if (!arr) return videos;
    for (const i of arr) {
        let type_name = i.type_name || '';
        if (i.vod_class) type_name = type_name + ',' + i.vod_class;
        videos.push({
            'vod_id': i.vod_id.toString(),
            'vod_name': i.vod_name,
            'vod_pic': i.vod_pic,
            'vod_remarks': i.vod_remarks,
            'type_name': type_name,
            'vod_year': i.vod_year
        });
    }
    return videos;
}


const _home = async ({ filter }) => {
    let url = host + '/api.php/index/home';
    let resp = await req(url);
    let json = JSON.parse(resp.content);
    let categories = json.data.categories;

    let classes = categories.map(i => ({
        'type_id': i.type_name,
        'type_name': i.type_name
    }));

    let videos = [];
    for (const i of categories) {
        videos.push(...json2vods(i.videos));
    }

    return { class: classes, list: videos, filters: {} };
};

const _category = async ({ id, page, filter, filters }) => {
    let url = `${host}/api.php/filter/vod?type_name=${encodeURIComponent(id)}&page=${page}&sort=hits`;
    let resp = await req(url);
    let json = JSON.parse(resp.content);

    return {
        list: json2vods(json.data),
        page: parseInt(page),
        pagecount: json.pageCount
    };
};

const _search = async ({ page, wd }) => {
    let url = `${host}/api.php/search/index?wd=${encodeURIComponent(wd)}&page=${page}&limit=15`;
    let resp = await req(url);
    let json = JSON.parse(resp.content);

    return {
        list: json2vods(json.data),
        page: parseInt(page),
        pagecount: json.pageCount
    };
};

const _detail = async ({ id }) => {
    let vod_id = id[0]; // 从数组中取出 ID
    let url = `${host}/api.php/vod/get_detail?vod_id=${vod_id}`;
    let resp = await req(url);
    let json = JSON.parse(resp.content);
    let data = json.data[0];
    let vodplayer = json.vodplayer;

    let shows = [];
    let play_urls = [];
    let raw_shows = data.vod_play_from.split('$$$');
    let raw_urls_list = data.vod_play_url.split('$$$');

    for (let i = 0; i < raw_shows.length; i++) {
        let show_code = raw_shows[i];
        let urls_str = raw_urls_list[i];
        let need_parse = 0, is_show = 0, name = show_code;

        for (const player of vodplayer) {
            if (player.from === show_code) {
                is_show = 1;
                need_parse = player.decode_status;
                if (show_code.toLowerCase() !== player.show.toLowerCase()) {
                    name = `${player.show} (${show_code})`;
                }
                break;
            }
        }

        if (is_show === 1) {
            let urls = [];
            let items = urls_str.split('#');
            for (const item of items) {
                if (item.includes('$')) {
                    let parts = item.split('$');
                    urls.push(`${parts[0]}$${show_code}@${need_parse}@${parts[1]}`);
                }
            }
            if (urls.length > 0) {
                play_urls.push(urls.join('#'));
                shows.push(name);
            }
        }
    }

    return {
        list: [{
            'vod_id': data.vod_id.toString(),
            'vod_name': data.vod_name,
            'vod_pic': data.vod_pic,
            'vod_remarks': data.vod_remarks,
            'vod_year': data.vod_year,
            'vod_area': data.vod_area,
            'vod_actor': data.vod_actor,
            'vod_director': data.vod_director,
            'vod_content': data.vod_content,
            'vod_play_from': shows.join('$$$'),
            'vod_play_url': play_urls.join('$$$'),
            'type_name': data.vod_class
        }]
    };
};

const _play = async ({ id }) => {
    let parts = id.split('@');
    let play_from = parts[0], need_parse = parts[1], raw_url = parts[2];
    let jx = 0, final_url = '';

    if (need_parse === '1') {
        let auth_token = '';
        for (let i = 0; i < 2; i++) {
            try {
                let apiUrl = `${host}/api.php/decode/url/?url=${encodeURIComponent(raw_url)}&vodFrom=${play_from}${auth_token}`;
                let resp = await req(apiUrl);
                let json = JSON.parse(resp.content);
                if (json.code === 2 && json.challenge) {
                    let token = eval(json.challenge);
                    auth_token = `&token=${token}`;
                    continue;
                }
                if (json.data && json.data.startsWith('http')) {
                    final_url = json.data;
                    break;
                }
            } catch (e) {}
        }
    }

    if (!final_url) {
        final_url = raw_url;
        if (/(?:www\.iqiyi|v\.qq|v\.youku|www\.mgtv|www\.bilibili)\.com/.test(raw_url)) jx = 1;
    }

    return {
        parse: jx,
        url: final_url,
        header: { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36' }
    };
};


const meta = {
    key: "qqqys",
    name: "3Q影视",
    type: 4,
    api: "/video/qqqys",
    searchable: 1,
    quickSearch: 1,
    changeable: 1,
};

module.exports = async (app, opt) => {
    app.get(meta.api, async (req_fastify, reply) => {
        const { ac, t, pg, wd, play, ids } = req_fastify.query;

        if (play) {
            return await _play({ id: play });
        } else if (wd) {
            return await _search({ wd, page: pg || "1" });
        } else if (ac === "detail") {
            if (t) {
                return await _category({ id: t, page: pg || "1" });
            } else if (ids) {
                return await _detail({ id: ids.split(",").map(i => i.trim()).filter(Boolean) });
            }
        } else {
            return await _home({ filter: false });
        }
    });

    opt.sites.push(meta);
};