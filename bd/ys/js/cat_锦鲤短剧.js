let host = 'https://api.jinlidj.com';
let headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 13; M2102J2SC Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/144.0.7559.31 Mobile Safari/537.36'
};

async function init(cfg) {}

function getList(data) {
    let videos = [];
    let list = data.data?.list || [];
    list.forEach(it => {
        videos.push({
            vod_id: it.vod_id,
            vod_name: it.vod_name,
            vod_pic: it.vod_pic,
            vod_remarks: "共" + it.vod_total + "集"
        });
    });
    return videos;
}

async function home(filter) {
    return JSON.stringify({
        class: [{
                "type_id": "1",
                "type_name": "情感关系"
            },
            {
                "type_id": "2",
                "type_name": "成长逆袭"
            },
            {
                "type_id": "3",
                "type_name": "奇幻异能"
            },
            {
                "type_id": "4",
                "type_name": "战斗热血"
            },
            {
                "type_id": "5",
                "type_name": "现实"
            },
            {
                "type_id": "6",
                "type_name": "时空穿越"
            },
            {
                "type_id": "7",
                "type_name": "权谋身份"
            }
        ]
    });
}

async function homeVod() {
    let resp = await req(host + '/api/search', {
        method: 'POST',
        headers: headers,
        data: {
            "page": 1,
            "limit": 24,
            "type_id": 2,
            "year": "",
            "keyword": ""
        }
    });
    let data = JSON.parse(resp.content);
    return JSON.stringify({
        list: getList(data)
    });
}

async function category(tid, pg, filter, extend) {
    const p = pg || 1;
    const cateId = extend.cateId || tid;
    let resp = await req(host + '/api/search', {
        method: 'POST',
        headers: headers,
        data: {
            "page": p,
            "limit": 24,
            "type_id": tid,
            "year": "",
            "keyword": ""
        }
    });
    let data = JSON.parse(resp.content);
    return JSON.stringify({
        list: getList(data),
        page: parseInt(p)
    });
}

async function detail(id) {
    const url = host + '/api/detail/' + id;
    const resp = await req(url, { headers });
    const data = JSON.parse(resp.content).data;
    const playUrl = Object.values(data.player || {}).join('#');

    return JSON.stringify({
        list: [{
            vod_id: id,
            vod_name: data.vod_name || "",
            vod_pic: data.vod_pic || "",
            vod_year: data.vod_year || "",
            vod_area: data.vod_area || "",
            vod_remarks: "更新至" + (data.vod_total || 0) + "集",
            type_name: [data.vod_class, data.vod_tag].filter(Boolean).join(','),
            vod_actor: data.vod_actor || "",
            vod_director: data.vod_director || "",
            vod_content: data.vod_blurb || "",
            vod_play_from: '锦鲤速播',
            vod_play_url: playUrl
        }]
    });
}


async function search(wd, quick, pg) {
    let p = pg || 1;
    let resp = await req(host + '/api/search', {
        method: 'POST',
        headers: headers,
        data: {
            "page": p,
            "limit": 24,
            "type_id": "",
            "year": "",
            "keyword": wd
        }
    });
    let data = JSON.parse(resp.content);
    return JSON.stringify({
        list: getList(data)
    });
}

async function play(flag, id, flags) {
    const resp = await req(id + "&auto=1", {
        headers: headers
    });
    const html = resp.content;
    const m3u8Match = html.match(/let data =[\s\S]*?"url":"(.*?)"};/);
    if (m3u8Match) {
        return JSON.stringify({
            parse: 0,
            url: m3u8Match[1].replace(/\\/g, ""),
            header: headers
        });
    }
}

export default {
    init,
    home,
    homeVod,
    category,
    detail,
    search,
    play
};