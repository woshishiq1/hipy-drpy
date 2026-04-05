let host = 'https://vip.wwgz.cn:5200';
let headers = {
    "User-Agent": "Mozilla/5.0 (Linux; Android 13; M2102J2SC Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.7 Mobile Safari/537.36"
};
async function init(cfg) {}

function getList(html) {
    let videos = [];
    let selector = '';
    if (html.includes('class="globalPicList"')) selector = '.globalPicList&&li';
    else if (html.includes('class="ulPicTxt')) selector = '.ulPicTxt&&li';
    if (!selector) return videos;
    let items = pdfa(html, selector);
    items.forEach(it => {
        let idMatch = it.match(/href="(.*?)"/);
        let nameMatch = it.match(/<span class="sTit">(.*?)<\/span>/);
        let picMatch = it.match(/data-src="(.*?)"/) || it.match(/src="(.*?)"/);
        let remarksMatch = it.match(/<span>([\s\S]*?)<em>/) || it.match(/<span class="sStyle">([\s\S]*?)<\/span>/);
        if (idMatch && nameMatch) {
            let pic = picMatch ? (picMatch[1] || picMatch[2]) : "";
            videos.push({
                vod_id: idMatch[1],
                vod_name: nameMatch?.[1]?.trim() || "未知片名",
                vod_pic: pic.startsWith('/') ? host + pic : pic,
                vod_remarks: remarksMatch?.[1]?.trim() || "未提供"
            });
        }
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
            "type_id": "26",
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
    let targetId = (extend && extend.class) ? extend.class : tid;
    let url = `${host}/vod-list-id-${tid}-pg-${p}-order--by-time-class-0-year-0-letter--area--lang-.html`;
    let resp = await req(url, {
        headers
    });
    return JSON.stringify({
        list: getList(resp.content),
        page: parseInt(p)
    });
}
async function detail(id) {
    const dUrl = host + id;
    const dResp = await req(dUrl, {
        headers
    });
    const dhtml = dResp.content;
    const playPageUrl = pdfh(dhtml, '.page-btn a.greenBtn&&href');
    if (!playPageUrl) {
        return JSON.stringify({
            list: []
        });
    }
    const pResp = await req(host + playPageUrl, {
        headers
    });
    const phtml = pResp.content;
    const playFrom = phtml.match(/mac_from='([\s\S]*?)'/)?.[1] ?? '';
    const playUrl = phtml.match(/mac_url='([\s\S]*?)'/)?.[1] ?? '';
    return JSON.stringify({
        list: [{
            vod_id: id,
            vod_name: (dhtml.match(/<h1 class="title">[\s\S]*?title="[\s\S]*?">([\s\S]*?)<\/a>/) || ['', ''])[1],
            vod_pic: (dhtml.match(/<img src="([\s\S]*?)"/) || ["", ""])[1],
            vod_year: (dhtml.match(/年代：[\s\S]*?<em>([\s\S]*?)<\/em>/) || ['', ''])[1],
            vod_remarks: (dhtml.match(/red">([\s\S]*?)<\/font>/) || ['', ''])[1],
            vod_actor: Array.from(
                dhtml.match(/主演:([\s\S]*?)<\/div>/)?.[1]?.matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []
            ).map(m => m[1]).join(' / ') || '',
            vod_director: Array.from(
                dhtml.match(/导演:([\s\S]*?)<\/div>/)?.[1]?.matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []
            ).map(m => m[1]).join(' / ') || '',
            vod_content: (dhtml.match(/<p>([\s\S]*?)<\/p>/) || ['', ''])[1].replace(/<.*?>/g, '').replace("简&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;介：", ""),
            vod_play_from: playFrom,
            vod_play_url: playUrl
        }]
    });
}
async function search(wd, quick, pg) {
    let url = `${host}/index.php?m=vod-search&wd=${wd}`;
    let resp = await req(url, {
        method: 'POST',
        headers: headers
    });
    return JSON.stringify({
        list: getList(resp.content)
    });
}
async function play(flag, id, flags) {
    return JSON.stringify({
        parse: 1,
        url: `https://api.nmvod.me:520/player/?url=${id}`,
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