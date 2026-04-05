let host = 'https://www.jdmv.net';
let headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 13; M2102J2SC Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/144.0.7559.31 Mobile Safari/537.36',
};

function getList(html) {
    let videos = [];
    const list = pdfa(html, '.public-list-box');
    list.forEach(it => {
        const id = pdfh(it, 'a&&href');
        const name = pdfh(it, 'a&&title');
        const pic = pdfh(it, 'img&&data-src');
        const remark = pdfh(it, '.ft2&&Text');
        videos.push({
            vod_id: id,
            vod_name: name,
            vod_pic: pic,
            vod_remarks: remark
        });
    });
    return videos;
}
async function init(cfg) {}
async function home(filter) {
    return JSON.stringify({
        class: [{
            "type_id": "1",
            "type_name": "电影"
        }, {
            "type_id": "2",
            "type_name": "电视剧"
        }, {
            "type_id": "3",
            "type_name": "综艺"
        }, {
            "type_id": "4",
            "type_name": "动漫"
        }, {
            "type_id": "5",
            "type_name": "短剧"
        }]
    });
}
async function homeVod() {
    let resp = await req(host, {
        headers
    });
    return JSON.stringify({
        list: getList(resp.content)
    });
}
async function category(tid, pg, filter, extend) {
    const p = pg || 1;
    const url = `${host}/vodtype/${tid}-${p}.html`;
    const resp = await req(url, {
        headers
    });
    return JSON.stringify({
        list: getList(resp.content),
        page: parseInt(p),
        pagecount: parseInt(p) + 1
    });
}
async function detail(id) {
    const url = host + id;
    const resp = await req(url, {
        headers
    });
    const html = resp.content;
    const blockList = [];
    const tabs = pdfa(html, 'a.swiper-slide');
    const lists = pdfa(html, '.anthology-list-box ul');
    const playPairs = tabs
        .map((tab, idx) => {
            const name = pdfh(tab, 'a&&Text').replace(/\s+/g, '').replace(/(\D+)(\d+)/, '$1|共$2集').replace(/腾讯/g, "线路一").replace(/优酷/g, "线路二").replace(/奇艺/g, "线路三").replace(/哔哩/g, "线路四").replace(/芒果/g, "线路五");
            const urlArr = pdfa(lists[idx] || '', 'a')
                .map(a => pdfh(a, 'a&&Text') + '$' + pdfh(a, 'a&&href'))
                .join('#');
            return {
                name,
                url: urlArr
            };
        })
        .filter(item => !blockList.includes(item.name));
    const playFrom = playPairs.map(p => p.name).join('$$$');
    const playUrl = playPairs.map(p => p.url).join('$$$');
    return JSON.stringify({
        list: [{
            vod_id: id,
            vod_name: pdfh(html, '.this-desc-title"&&Text'),
            vod_pic: pd(html, '.this-pic-bj&&style'),
            vod_year: pdfh(html, '.slide-desc-box&&span:eq(3)&&Text'),
            vod_area: pdfh(html, '.slide-desc-box&&span:eq(4)&&Text'),
            vod_remarks: pdfh(html, '.slide-desc-box&&span:eq(5)&&Text'),
            type_name: pdfa(html, '.this-desc-tags&&span').map((it) => pdfh(it, 'body&&Text')).join('/'),
            vod_actor: pdfa(html, '.this-info:contains(演员) a').map(it => pdfh(it, 'body&&Text')).join('/'),
            vod_director: pdfa(html, '.this-info:contains(导演) a').map(it => pdfh(it, 'body&&Text')).join('/'),
            vod_content: pdfh(html, '.text&&Text').replace(/\s+/g, '').replace("描述:", ""),
            vod_play_from: playFrom,
            vod_play_url: playUrl
        }]
    });
}
async function search(wd, quick, pg) {
    let p = pg || 1;
    let url = `${host}/index.php/ajax/suggest?mid=1&wd=${wd}&limit=500`;
    let resp = await req(url, {
        headers
    });
    let json = JSON.parse(resp.content);
    let videos = json.list.map(item => ({
        vod_id: '/voddetail/' + item.id + '.html',
        vod_name: item.name,
        vod_pic: item.pic,
        vod_remarks: item.en
    }));
    return JSON.stringify({
        list: videos,
        page: json.page || 1,
        pagecount: json.pagecount || 1,
        total: json.total || 0
    });
}
async function play(flag, id, flags) {
    try {
        let playUrl = !/^http/.test(id) ? `${host}${id}` : id;
        let resHtml = (await req(playUrl, {
            headers
        })).content;
        let kcode = safeParseJSON(
            resHtml.match(/var\s+player_\w+\s*=\s*(\{[^]*?\})\s*</)?.[1] ?? ''
        );
        let kurl = kcode?.url ?? '';
        let kp = /m3u8|mp4|mkv/i.test(kurl) ? 0 : 1;
        if (kp) kurl = playUrl;
        return JSON.stringify({
            jx: 0,
            parse: kp,
            url: kurl,
            header: headers
        });
    } catch (e) {
        return JSON.stringify({
            jx: 0,
            parse: 0,
            url: '',
            header: {}
        });
    }
}

function safeParseJSON(str) {
    try {
        return JSON.parse(str.trim().replace(/;+$/, ''));
    } catch {
        return null;
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