const host = 'https://app.whjzjx.cn';
const headers = {
    'User-Agent': 'okhttp/4.10.0',
    'user_agent': 'Mozilla/5.0 (Linux; Android 9; RMX1931 Build/PQ3A.190605.05081124; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/91.0.4472.114 Mobile Safari/537.36',
    'app_version': '3.0.0.1',
    'version_name': '3.0.0.1',
    'support_h265': '1',
    'platform': '1',
    'device_platform': 'android',
    'device_type': 'RMX1931',
    'device_brand': 'realme',
    'os_version': '9',
    'channel': 'default',
    'raw_channel': 'default',
    'oaid': '',
    'msa_oaid': '',
    'uuid': 'randomUUID_' + Math.random().toString(36).slice(2),
    'device_id': Math.random().toString(36).slice(2, 18),
    'ab_id': '',
    'manufacturer': 'realme',
    'personalized_recommend_status': '1',
    'Content-Type': 'application/json'
};

const CACHE_KEY = 'xyAuthorization';

function getCache() {
    try {
        return localStorage.getItem(CACHE_KEY) || '';
    } catch {
        return '';
    }
}

function setCache(val) {
    try {
        localStorage.setItem(CACHE_KEY, val);
    } catch {}
}

async function refreshToken() {
    const url = 'https://u.shytkjgs.com/user/v1/account/login';
    const payload = {
        device: headers.device_id,
        install_first_open: false,
        first_install_time: Date.now(),
        last_update_time: Date.now(),
        report_link_url: ''
    };
    const resp = await req(url, {
        method: 'POST',
        headers: headers,
        data: payload
    });
    const obj = JSON.parse(resp.content);
    const tk = obj?.data?.token || '';
    if (tk) setCache(tk);
    return tk;
}

async function assureAuth() {
    let tk = getCache();
    if (!tk) tk = await refreshToken();
    return tk;
}

async function init(cfg) {}

async function home(filter) {
    return JSON.stringify({
        class: [{
                type_id: '1',
                type_name: '剧场'
            },
            {
                type_id: '2',
                type_name: '热播剧'
            },
            {
                type_id: '7',
                type_name: '星选好剧'
            },
            {
                type_id: '3',
                type_name: '新剧'
            },
            {
                type_id: '5',
                type_name: '阳光剧场'
            },
            {
                type_id: '8',
                type_name: '会员'
            }
        ]
    });
}

async function homeVod() {
    const auth = await assureAuth();
    const url = `${host}/cloud/v2/theater/home_page?theater_class_id=2&type=2&class2_ids=0&page_num=1&page_size=24`;
    const resp = await req(url, {
        headers: {
            headers,
            authorization: auth
        }
    });
    const list = JSON.parse(resp.content).data?.list || [];
    const videos = list.map(it => ({
        vod_id: it.theater.id,
        vod_name: it.theater.title,
        vod_pic: it.theater.cover_url,
        vod_remarks: '共' + it.theater.total + '集'
    }));
    return JSON.stringify({
        list: videos
    });
}

async function category(tid, pg, filter, extend) {
    const auth = await assureAuth();
    const p = pg || 1;
    const url = `${host}/cloud/v2/theater/home_page?theater_class_id=${tid}&type=${tid}&class2_ids=0&page_num=${p}&page_size=24`;
    const resp = await req(url, {
        headers: {
            headers,
            authorization: auth
        }
    });
    const list = JSON.parse(resp.content).data?.list || [];
    const videos = list.map(it => ({
        vod_id: it.theater.id,
        vod_name: it.theater.title,
        vod_pic: it.theater.cover_url,
        vod_remarks: '共' + it.theater.total + '集'
    }));
    return JSON.stringify({
        list: videos,
        page: parseInt(p)
    });
}

async function detail(id) {
    const auth = await assureAuth();
    const url = `${host}/v2/theater_parent/detail?theater_parent_id=${id}`;
    const resp = await req(url, {
        headers: {
            headers,
            authorization: auth
        }
    });
    const data = JSON.parse(resp.content).data;

    const playUrl = (data.theaters || [])
        .map(item => item.son_video_url)
        .join('#');

    return JSON.stringify({
        list: [{
            vod_id: id,
            vod_name: data.title || '',
            vod_pic: data.cover_url || '',
            vod_remarks: '更新至' + data.total + '集',
            type_name: (data.desc_tags || []).join(','),
            vod_content: data.introduction || '',
            vod_play_from: '星芽速播',
            vod_play_url: playUrl
        }]
    });
}

async function search(wd, quick, pg) {
    const auth = await assureAuth();
    const p = pg || 1;
    const url = `${host}/v3/search`;
    const resp = await req(url, {
        method: 'POST',
        headers: {
            headers,
            authorization: auth
        },
        data: {
            text: wd
        }
    });
    const list = JSON.parse(resp.content).data?.theater?.search_data || [];
    const videos = list.map(it => ({
        vod_id: it.id,
        vod_name: it.title,
        vod_pic: it.cover_url,
        vod_remarks: '共' + it.total + '集'
    }));
    return JSON.stringify({
        list: videos
    });
}

async function play(flag, id, flags) {
    return JSON.stringify({
        parse: 0,
        url: id,
        header: headers
    });
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