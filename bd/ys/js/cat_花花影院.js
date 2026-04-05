let host = 'https://www.guangzhiqi.com';
let headers = {
    "User-Agent": "Mozilla/5.0 (Linux; Android 13; M2102J2SC Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/143.0.7499.3 Mobile Safari/537.36"
};
async function init(cfg) {}

function getList(html) {
    let videos = [];
    const list = pdfa(html, '.a-con-inner');
    list.forEach(it => {
        const id = pdfh(it, 'a&&href');
        const name = pdfh(it, 'a&&title');
        const pic = pdfh(it, 'img&&data-src');
        const remark = pdfh(it, '.s4.text-left&&Text');
        const year = pdfh(it, '.s3.text-left&&Text');
        videos.push({
            vod_id: id,
            vod_name: name,
            vod_pic: pic,
            vod_year: `评分:${year}`,
            vod_remarks: remark
        });
    });
    return videos;
}
async function home(filter) {
    return JSON.stringify({
        "class": [{
            "type_id": "1",
            "type_name": "电影"
        }, {
            "type_id": "2",
            "type_name": "剧集"
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
    let p = pg || 1;
    let url = `${host}/index.php/ajax/data?mid=1&tid=${tid}&page=${p}&limit=30`;
    let resp = await req(url, {
        headers
    });
    let json = JSON.parse(resp.content);
    let videos = json.list.map(item => ({
        vod_id: '/guadetail/' + item.vod_id + '.html',
        vod_name: item.vod_name,
        vod_pic: item.vod_pic,
        vod_year: "评分:"+item.vod_score,
        vod_remarks: item.vod_remarks
    }));
    return JSON.stringify({
        list: videos,
        page: parseInt(p)
    });
}
async function detail(id) {
    const dUrl = host + id;
    const dResp1 = await req(dUrl, {
        headers
    });
    const thtml = dResp1.content;
    const playPageUrl = pdfh(thtml, '.con&&.play a&&href');
    if (!playPageUrl) {
        return JSON.stringify({
            list: []
        });
    }
    const dResp2 = await req(host + playPageUrl, {
        headers
    });
    const phtml = dResp2.content;
    const lineBtnList = pdfa(phtml, '.mxianlu a');
    const lineInfo = lineBtnList.map(a => ({
        name: pdfh(a, 'a&&Text').replace(/\d+/g, '').trim(),
        href: pdfh(a, 'a&&href')
    }));
    const playUrlArr = [];
    for (const l of lineInfo) {
        let html;
        if (l.href.includes('javascript:')) {
            html = phtml;
        } else {
            const lineUrl = l.href.startsWith('http') ? l.href : host + l.href;
            const tmp = await req(lineUrl, {
                headers
            });
            html = tmp.content;
        }
        const jiStr = pdfa(html, '.jisu a')
            .map(it => {
                const title = pdfh(it, 'a&&Text');
                const href = pdfh(it, 'a&&href');
                return `${title}$${href}`;
            })
            .join('#');
        playUrlArr.push(jiStr);
    }
    const playFrom = lineInfo.map(l => l.name).join('$$$');
    const playUrl = playUrlArr.join('$$$');
    return JSON.stringify({
        list: [{
            vod_id: id,
            vod_name: (thtml.match(/<p class="tit">([\s\S]*?)<\/p>/) || ["", ""])[1],
            vod_pic: (thtml.match(/data-src="([\s\S]*?)"/) || ["", ""])[1],
            vod_year: (thtml.match(/<a href="\/guasw\/[\s\S]*?-----------[\s\S]*?.html">([\s\S]*?)<\/a>/) || ["", ""])[1],
            vod_area: (thtml.match(/<a href="\/guasw\/[\s\S]*?-[\s\S]*?----------.html">([\s\S]*?)<\/a>/) || ["", ""])[1],
            vod_remarks: (thtml.match(/状态：<\/span>([\s\S]*?)</) || ['', ''])[1] + "时间：" + (thtml.match(/时间：<\/span>([\s\S]*?)</) || ['', ''])[1],
            type_name: (thtml.match(/<a href="\/guasw\/[\s\S]*?---[\s\S]*?--------.html" title="[\s\S]*?">([\s\S]*?)<\/a>/) || ["", ""])[1],
            vod_actor: Array.from(
                thtml.match(/主演：<\/span>([\s\S]*?)<\/p>/)?.[1]?.matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []).map(m => m[1]).join(' / ') || '',
            vod_director: Array.from(
                thtml.match(/导演：<\/span>([\s\S]*?)<\/p>/)?.[1]?.matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []).map(m => m[1]).join(' / ') || '',
            vod_content: (thtml.match(/articleText">([\s\S]*?)<span/) || ["", ""])[1].replace(/<.*?>/g, ""),
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
        vod_id: '/guadetail/' + item.id + '.html',
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
        const playUrl = /^http/.test(id) ? id : `${host}${id}`;
        const resHtml = (await req(playUrl, {
            headers
        })).content;

        const kcode = safeParseJSON(
            resHtml.match(/var player_.*?=([^]*?)</)?.[1] ?? ''
        );
        let kurl = kcode?.url ?? '';

        const kp = /m3u8|mp4|mkv/i.test(kurl) ? 0 : 1;
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