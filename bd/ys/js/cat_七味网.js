let host = 'https://www.qnmp4.com';
let headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Referer": host
};
async function init(cfg) {}

function getList(html) {
    let videos = [];
    let items = pdfa(html, ".content-list&&li");
    items.forEach(it => {
        let idMatch = it.match(/href="([\s\S]*?)"/);
        let nameMatch = it.match(/title="([\s\S]*?)"/);
        let picMatch = it.match(/data-original="([\s\S]*?)"/) || it.match(/src="([\s\S]*?)"/);
        let remarksMatch = it.match(/<\/i>([\s\S]*?)<\/span>/);
        if (idMatch && nameMatch) {
            let pic = picMatch ? picMatch[1] : "";
            videos.push({
                vod_id: idMatch[1],
                vod_name: nameMatch[1],
                vod_pic: pic.startsWith('/') ? host + pic : pic,
                vod_remarks: (remarksMatch || ["", ""])[1].replace(/<.*?>/g, "")
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
            },
            {
                "type_id": "2",
                "type_name": "剧集"
            },
            {
                "type_id": "3",
                "type_name": "综艺"
            },
            {
                "type_id": "4",
                "type_name": "动漫"
            },
            {
                "type_id": "30",
                "type_name": "短剧"
            }
        ]
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
    let url = `${host}/ms/${tid}--time------${p}---.html`;
    let resp = await req(url, {
        headers
    });
    return JSON.stringify({
        list: getList(resp.content),
        page: parseInt(p)
    });
}
async function detail(id) {
    const url = host + id;
    const resp = await req(url, {
        headers
    });
    const html = resp.content;
    const tabs = pdfa(html, '.py-tabs&&li');
    const lists = pdfa(html, '.bd&&ul');
    const playPairs = tabs.map((tab, idx) => {
        const name = (tab.match(/>([\s\S]*?)</) || ['', '未知线路'])[1].trim();
        const urlArr = pdfa(lists[idx] || '', 'a').map(a => {
            const n = (a.match(/>([\s\S]*?)</) || ['', '未知播放'])[1];
            const v = a.match(/href="([\s\S]*?)"/);
            return n + '$' + (v ? v[1] : '');
        }).join('#');
        return {
            name,
            url: urlArr
        };
    });
    const Downtabs = pdfa(html, '.nav-tabs li');
    const Downlists = pdfa(html, '.down-list ul');
    const DownplayPairs = Downtabs.map((Downtab, idx) => {
        const name = (Downtab.match(/>([\s\S]*?)</) || ['', '未知线路'])[1].trim();
        const urlArr = pdfa(Downlists[idx] || '', 'p').map(a => {
            const n = (a.match(/title="([\s\S]*?)"/) || ['', '未知播放'])[1];
            const v = a.match(/href="([\s\S]*?)"/);
            return n + '$' + (v ? v[1] : '');
        }).join('#');
        return {
            name,
            url: urlArr
        };
    });
    const allPairs = [...playPairs, ...DownplayPairs];
    const playFrom = allPairs.map(p => p.name).join('$$$');
    const playUrl = allPairs.map(p => p.url).join('$$$');

    return JSON.stringify({
        list: [{
            vod_id: id,
            vod_name: (html.match(/<h1>([\s\S]*?)<span class="year"/) || ['', ''])[1],
            vod_pic: (html.match(/<div class="img">[\s\S]*?<img src="([\s\S]*?)"/) || ["", ""])[1],
            vod_year: (html.match(/上映：<\/span>([\s\S]*?)<\/div>/) || ['', ''])[1],
            vod_area: Array.from(
                html.match(/地区：<\/span>([\s\S]*?)<\/div>/)?.[1]?.replace(/<!--[\s\S]*?-->/g, '').matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []
            ).map(m => m[1]).join(' / ') || '',
            vod_remarks: (html.match(/<div class="otherbox">([\s\S]*?)<\/div>/) || ['', ''])[1].replace(/<.*?>/g, ''),
            type_name: Array.from(
                html.match(/类型：<\/span>([\s\S]*?)<\/div>/)?.[1]?.replace(/<!--[\s\S]*?-->/g, '').matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []
            ).map(m => m[1]).join(' / ') || '',
            vod_actor: Array.from(
                html.match(/主演：<\/span>([\s\S]*?)<\/div>/)?.[1]?.replace(/<!--[\s\S]*?-->/g, '').matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []
            ).map(m => m[1]).join(' / ') || '',
            vod_director: Array.from(
                html.match(/导演：<\/span>([\s\S]*?)<\/div>/)?.[1]?.replace(/<!--[\s\S]*?-->/g, '').matchAll(/<a [^>]*>([^<]+)<\/a>/g) || []
            ).map(m => m[1]).join(' / ') || '',
            vod_content: (html.match(/<p class="sqjj_a"[\s\S]*?>([\s\S]*?)</) || ['', ''])[1].replace(/<.*?>/g, ''),
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
        vod_id: '/mv/' + item.id + '.html',
        vod_name: item.name,
        vod_pic: item.pic
    }));
    return JSON.stringify({
        list: videos,
        page: json.page || 1,
        pagecount: json.pagecount || 1,
        total: json.total || 0
    });
}
async function play(flag, id, flags) {
    if (id.startsWith('/py/')) {
        try {
            const playUrl = `${host}${id}`;
            const resHtml = (await req(playUrl, {
                headers
            })).content;
            const kcode = safeParseJSON(
                resHtml.match(/var\s+player_\w+\s*=\s*(\{[^]*?\})\s*</)?.[1] ?? ''
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
    if (/^https?:\/\/.*\.(baidu|quark|xunlei|aliyun|189|115|123|uc)\./i.test(id)) {
        return JSON.stringify({
            parse: 1,
            url: `push://${id}`,
            header: headers
        });
    }
    return JSON.stringify({
        parse: 1,
        url: id,
        header: headers
    });
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