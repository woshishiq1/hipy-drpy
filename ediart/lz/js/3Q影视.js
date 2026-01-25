let host = 'https://qqqys.com';
let headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36',
    'accept-language': 'zh-CN,zh;q=0.9',
    'cache-control': 'no-cache',
    'pragma': 'no-cache',
};

async function init(cfg) {}

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

async function home(filter) {
    let url = host + '/api.php/index/home';
    let resp = await req(url, { headers: headers });
    let json = JSON.parse(resp.content);
    let categories = json.data.categories;

    let classes = categories.map(i => ({
        'type_id': i.type_name,
        'type_name': i.type_name
    }));

    const filterConfig = {
        "电影": [
            { key: "class", name: "类型", value: [ {n:"全部",v:""}, {n:"动作",v:"动作"}, {n:"喜剧",v:"喜剧"}, {n:"爱情",v:"爱情"}, {n:"科幻",v:"科幻"}, {n:"恐怖",v:"恐怖"}, {n:"悬疑",v:"悬疑"}, {n:"犯罪",v:"犯罪"}, {n:"战争",v:"战争"}, {n:"动画",v:"动画"}, {n:"冒险",v:"冒险"}, {n:"历史",v:"历史"}, {n:"灾难",v:"灾难"}, {n:"纪录",v:"纪录"}, {n:"剧情",v:"剧情"} ] },
            { key: "area", name: "地区", value: [ {n:"全部",v:""}, {n:"大陆",v:"大陆"}, {n:"香港",v:"香港"}, {n:"台湾",v:"台湾"}, {n:"美国",v:"美国"}, {n:"日本",v:"日本"}, {n:"韩国",v:"韩国"}, {n:"泰国",v:"泰国"}, {n:"印度",v:"印度"}, {n:"英国",v:"英国"}, {n:"法国",v:"法国"}, {n:"德国",v:"德国"}, {n:"加拿大",v:"加拿大"}, {n:"西班牙",v:"西班牙"}, {n:"意大利",v:"意大利"}, {n:"澳大利亚",v:"澳大利亚"} ] },
            { key: "year", name: "年份", value: [ {n:"全部",v:""}, {n:"2026",v:"2026"}, {n:"2025",v:"2025"}, {n:"2024",v:"2024"}, {n:"2023",v:"2023"}, {n:"2022",v:"2022"}, {n:"2021",v:"2021"}, {n:"2020",v:"2020"}, {n:"2019",v:"2019"}, {n:"2018",v:"2018"}, {n:"2017",v:"2017"}, {n:"2016",v:"2016"}, {n:"2015-2011",v:"2015-2011"}, {n:"2010-2000",v:"2010-2000"}, {n:"90年代",v:"90年代"}, {n:"80年代",v:"80年代"}, {n:"更早",v:"更早"} ] },
            { key: "sort", name: "排序", value: [ {n:"人气",v:"hits"}, {n:"最新",v:"time"}, {n:"评分",v:"score"}, {n:"年份",v:"year"} ] }
        ],
        "剧集": [
            { key: "class", name: "类型", value: [ {n:"全部",v:""}, {n:"爱情",v:"爱情"}, {n:"古装",v:"古装"}, {n:"武侠",v:"武侠"}, {n:"历史",v:"历史"}, {n:"家庭",v:"家庭"}, {n:"喜剧",v:"喜剧"}, {n:"悬疑",v:"悬疑"}, {n:"犯罪",v:"犯罪"}, {n:"战争",v:"战争"}, {n:"奇幻",v:"奇幻"}, {n:"科幻",v:"科幻"}, {n:"恐怖",v:"恐怖"} ] },
            { key: "area", name: "地区", value: [ {n:"全部",v:""}, {n:"大陆",v:"大陆"}, {n:"香港",v:"香港"}, {n:"台湾",v:"台湾"}, {n:"美国",v:"美国"}, {n:"日本",v:"日本"}, {n:"韩国",v:"韩国"}, {n:"泰国",v:"泰国"}, {n:"英国",v:"英国"} ] },
            { key: "year", name: "年份", value: [ {n:"全部",v:""}, {n:"2026",v:"2026"}, {n:"2025",v:"2025"}, {n:"2024",v:"2024"}, {n:"2023",v:"2023"}, {n:"2022",v:"2022"}, {n:"2021",v:"2021"}, {n:"2020-2016",v:"2020-2016"}, {n:"2015-2011",v:"2015-2011"}, {n:"2010-2000",v:"2010-2000"}, {n:"更早",v:"更早"} ] },
            { key: "sort", name: "排序", value: [ {n:"人气",v:"hits"}, {n:"最新",v:"time"}, {n:"评分",v:"score"}, {n:"年份",v:"year"} ] }
        ],
        "动漫": [
            { key: "class", name: "类型", value: [ {n:"全部",v:""}, {n:"冒险",v:"冒险"}, {n:"奇幻",v:"奇幻"}, {n:"科幻",v:"科幻"}, {n:"武侠",v:"武侠"}, {n:"悬疑",v:"悬疑"} ] },
            { key: "area", name: "地区", value: [ {n:"全部",v:""}, {n:"大陆",v:"大陆"}, {n:"日本",v:"日本"}, {n:"欧美",v:"欧美"} ] },
            { key: "year", name: "年份", value: [ {n:"全部",v:""}, {n:"2026",v:"2026"}, {n:"2025",v:"2025"}, {n:"2024",v:"2024"}, {n:"2023",v:"2023"}, {n:"2022",v:"2022"}, {n:"2021",v:"2021"}, {n:"更早",v:"更早"} ] },
            { key: "sort", name: "排序", value: [ {n:"人气",v:"hits"}, {n:"最新",v:"time"}, {n:"评分",v:"score"}, {n:"年份",v:"year"} ] }
        ],
        "综艺": [
            { key: "class", name: "类型", value: [ {n:"全部",v:""}, {n:"真人秀",v:"真人秀"}, {n:"音乐",v:"音乐"}, {n:"脱口秀",v:"脱口秀"}, {n:"歌舞",v:"歌舞"}, {n:"爱情",v:"爱情"} ] },
            { key: "area", name: "地区", value: [ {n:"全部",v:""}, {n:"大陆",v:"大陆"}, {n:"香港",v:"香港"}, {n:"台湾",v:"台湾"}, {n:"美国",v:"美国"}, {n:"日本",v:"日本"}, {n:"韩国",v:"韩国"} ] },
            { key: "year", name: "年份", value: [ {n:"全部",v:""}, {n:"2026",v:"2026"}, {n:"2025",v:"2025"}, {n:"2024",v:"2024"}, {n:"2023",v:"2023"}, {n:"2022",v:"2022"}, {n:"2021",v:"2021"}, {n:"更早",v:"更早"} ] },
            { key: "sort", name: "排序", value: [ {n:"人气",v:"hits"}, {n:"最新",v:"time"}, {n:"评分",v:"score"}, {n:"年份",v:"year"} ] }
        ]
    };

    let videos = [];
    for (const i of categories) {
        videos.push(...json2vods(i.videos));
    }

    return JSON.stringify({
        class: classes,
        list: videos,
        filters: filterConfig
    });
}

async function category(tid, pg, filter, extend) {
    let sort = extend.sort || 'hits';
    let url = `${host}/api.php/filter/vod?type_name=${encodeURIComponent(tid)}&page=${pg}&sort=${sort}`;
    if (extend.class) url += `&class=${encodeURIComponent(extend.class)}`;
    if (extend.area) url += `&area=${encodeURIComponent(extend.area)}`;
    if (extend.year) url += `&year=${encodeURIComponent(extend.year)}`;

    let resp = await req(url, { headers: headers });
    let json = JSON.parse(resp.content);

    return JSON.stringify({
        list: json2vods(json.data),
        page: parseInt(pg),
        pagecount: json.pageCount
    });
}

async function detail(id) {
    let url = `${host}/api.php/vod/get_detail?vod_id=${id}`;
    let resp = await req(url, { headers: headers });
    let json = JSON.parse(resp.content);
    let data = json.data[0];
    let vodplayer = json.vodplayer;

    let aggregateUrl = `${host}/api.php/internal/search_aggregate?vod_id=${id}`;
    let aggResp = await req(aggregateUrl, { headers: headers });
    let aggJson = JSON.parse(aggResp.content);

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

    if (aggJson && aggJson.data) {
        aggJson.data.forEach(item => {
            if (!shows.includes(item.site_name) && item.vod_play_url) {
                let name = item.site_name;
                let urls_str = item.vod_play_url.replace(/\t+/g, '').trim();
                let urls = [];
                let items = urls_str.split('#');
                for (const item_url of items) {
                    if (item_url.includes('$')) {
                        let parts = item_url.split('$');
                        urls.push(`${parts[0]}$${name}@0@${parts[1]}`);
                    }
                }
                if (urls.length > 0) {
                    play_urls.push(urls.join('#'));
                    shows.push(name);
                }
            }
        });
    }

    let video = {
        'vod_id': data.vod_id.toString(),
        'vod_name': data.vod_name,
        'vod_pic': data.vod_pic,
        'vod_remarks': data.vod_remarks,
        'vod_year': data.vod_year,
        'vod_area': data.vod_area,
        'vod_actor': data.vod_actor,
        'vod_director': data.vod_director,
        'vod_content': data.vod_content.replace(/<[^>]+>/g, '').trim(),
        'vod_play_from': shows.join('$$$'),
        'vod_play_url': play_urls.join('$$$'),
        'type_name': data.vod_class
    };

    return JSON.stringify({ list: [video] });
}

async function search(wd, quick, pg) {
    let url = `${host}/api.php/search/index?wd=${encodeURIComponent(wd)}&page=${pg}&limit=15`;
    let resp = await req(url, { headers: headers });
    let json = JSON.parse(resp.content);

    return JSON.stringify({
        list: json2vods(json.data),
        page: parseInt(pg),
        pagecount: json.pageCount
    });
}

async function play(flag, id, flags) {
    let parts = id.split('@');
    let play_from = parts[0], need_parse = parts[1], raw_url = parts[2];
    let jx = 0, final_url = '';

    if (need_parse === '1') {
        let auth_token = '';
        for (let i = 0; i < 2; i++) {
            try {
                let apiUrl = `${host}/api.php/decode/url/?url=${encodeURIComponent(raw_url)}&vodFrom=${encodeURIComponent(play_from)}${auth_token}`;
                let resp = await req(apiUrl, { headers: headers, timeout: 15000 });
                let json = JSON.parse(resp.content);

                if (json.code === 2 && json.challenge) {
                    let token = eval(json.challenge);
                    auth_token = `&token=${token}`;
                    continue;
                }
                if (json.data && typeof json.data === 'string' && json.data.startsWith('http')) {
                    final_url = json.data;
                    break;
                }
            } catch (e) {
                console.error("[解析失败]", e);
            }
        }
    }

    if (!final_url) {
        final_url = raw_url;
        if (/(?:www\.iqiyi|v\.qq|v\.youku|www\.mgtv|www\.bilibili)\.com/.test(raw_url)) jx = 1;
    }

    return JSON.stringify({
        parse: jx,
        url: final_url,
        header: { 'User-Agent': headers['User-Agent'] }
    });
}

async function homeVod() {
    return JSON.stringify({ list: [] });
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
