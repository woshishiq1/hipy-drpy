let host = 'https://a123tv.com';
let headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 13; M2102J2SC Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/144.0.7559.31 Mobile Safari/537.36',
    'Referer': host
};

function getList(html) {
    let videos = [];
    pdfa(html, '.w4-item-wrap').forEach(it => {
        const id = pdfh(it, 'a.w4-item&&href') || '',
              name = pdfh(it, 'img&&alt') || '',
              pic = pdfh(it, 'img&&data-src') || pdfh(it, 'img&&src') || '',
              remark = pdfh(it, '.w4-item-cover .s span&&Text') || '';
        if (id && name) {
            let vod_pic = pic.startsWith('//') ? `https:${pic}` : pic.startsWith('/') ? `${host}${pic}` : pic;
            vod_pic = vod_pic || 'data:image/gif;base64,R0lGODdhAQABAPAAAMPDwwAAACwAAAAAAQABAAACAkQBADs=';
            videos.push({
                vod_id: id.replace(host, '').replace(/^\//, ''),
                vod_name: name.trim(),
                vod_pic,
                vod_remarks: remark.trim()
            });
        }
    });
    return videos;
}

async function init(cfg) {}
async function home(filter) {
    return JSON.stringify({
        class: [{ "type_id": "10", "type_name": "电影" }, { "type_id": "11", "type_name": "连续剧" },
                { "type_id": "12", "type_name": "综艺" }, { "type_id": "13", "type_name": "动漫" },
                { "type_id": "15", "type_name": "福利" }],
        filters: {}
    });
}
async function homeVod() {
    let resp = await req(host, { headers });
    return JSON.stringify({ list: getList(resp.content) });
}
async function category(tid, pg, filter, extend) {
    let p = parseInt(pg) || 1;
    let resp = await req(`${host}/t/${tid}/p${p}.html`, { headers });
    return JSON.stringify({ list: getList(resp.content), page: p, pagecount: p + 5, limit: 20 });
}

async function detail(id) {
    const playFrom = [], playList = [];
    let detailUrl = id.startsWith('http') ? id : `${host}/${id.replace(/^\//, '')}`;
    let { content: html = '' } = await req(detailUrl, { headers });
    
    // 基础信息
    let vod_name = (pdfh(html, 'li.on h1&&Text') || pdfh(html, 'h1.title&&Text') || '未知片名').trim();
    let vod_pic = pdfh(html, '#awp1&&data-poster') || '';
    vod_pic = vod_pic.startsWith('//') ? `https:${vod_pic}` : vod_pic.startsWith('/') ? `${host}${vod_pic}` : vod_pic;
    let vod_remarks = pdfh(html, '.w4-line-cover .i&&Text')?.split(' / ')[1] || '720p';

    // 解析meta中的导演/演员/地区/年代/类型/简介
    let vod_area = '', vod_year = '', type_name = '', vod_actor = '', vod_director = '', vod_content = '';
    // 提取description
    const descMatch = html.match(/<meta name="description" content="([^"]+)"[^>]*>/i);
    const descText = descMatch ? descMatch[1] : '';
    // 从标题提取类型和年代
    const titleMatch = html.match(/《[^》]+》\s*-\s*([^-]+)\s*-\s*(\d+)年/i);
    if (titleMatch) {
        type_name = titleMatch[1].trim();
        vod_year = titleMatch[2].trim();
    }
    // 解析描述中的地区、导演、演员、剧情
    if (descText) {
        const areaMatch = descText.match(/地区：([^。]+)。/);
        const dirMatch = descText.match(/导演：([^。]+)。/);
        const actorMatch = descText.match(/演员：([^。]+)。/);
        const contentMatch = descText.match(/剧情：([\s\S]+)/);
        
        vod_area = areaMatch ? areaMatch[1].trim() : '';
        vod_director = dirMatch ? dirMatch[1].trim().replace(/、/g, '/') : '';
        vod_actor = actorMatch ? actorMatch[1].trim().replace(/、/g, '/') : '';
        vod_content = contentMatch ? contentMatch[1].trim() : descText;
    }

    const ppMatch = html.match(/var\s+pp\s*=\s*({[\s\S]*?});/);
    if (ppMatch) {
        const { la = [] } = JSON.parse(ppMatch[1]);
        const episodeNames = pdfa(html, '.w4-episode-list .w a').map((a, i) => 
            (pdfh(a, 'a&&Text') || pdfh(a, 'a&&title') || `第${i+1}集`).trim()
        );
        
        la.forEach((item, index) => {
            if (Array.isArray(item) && item.length >= 5) {
                const [, , episodeNum, , m3u8] = item;
                const realEpNum = parseInt(episodeNum) || episodeNames.length;
                const lineEpisodes = [];
                for (let i = 0; i < realEpNum; i++) {
                    let epName = episodeNames[i] || `第${i+1}集`;
                    let realM3u8 = m3u8.startsWith('//') ? `https:${m3u8}` : m3u8;
                    lineEpisodes.push(`${epName}$${realM3u8}`);
                }
                playFrom.push(`✨乐哥推荐✨${index + 1}`); 
                playList.push(lineEpisodes.join('#'));
            }
        });
    }

    return JSON.stringify({
        list: [{ 
            vod_id: id, vod_name, vod_pic, vod_remarks, vod_year, vod_area,
            type_name, vod_actor, vod_director, vod_content,
            vod_play_from: playFrom.join('$$$'), vod_play_url: playList.join('$$$') 
        }]
    });
}

async function search(wd, quick, pg) {
    let p = parseInt(pg) || 1;
    let resp = await req(`${host}/s/${encodeURIComponent(wd)}/p${p}.html`, { headers });
    return JSON.stringify({ list: getList(resp.content), page: p, pagecount: p + 5, limit: 20 });
}

async function play(flag, id, flags) {
    let url = id.startsWith('http') ? id : `${host}/${id.replace(/^\//, '')}`;
    let { content: html = '' } = await req(url, { headers });

    const playerVarMatch = html.match(/var\s+player_aaaa\s*=\s*({[^;]+});/);
    if (playerVarMatch) {
        let jsonStr = playerVarMatch[1].replace(/(\w+):/g, '"$1":').replace(/\\/g, '');
        let { url: playUrl } = JSON.parse(jsonStr);
        if (playUrl) return JSON.stringify({ parse: playUrl.includes('.m3u8') ? 0 : 1, url: playUrl, header: headers });
    }

    let m3u8Match = html.match(/"url":"([^"]+\.m3u8(\?[^"]*)?)"/) || html.match(/'url':'([^']+\.m3u8(\?[^']*)?)'/) ||
                    html.match(/"(https?:\/\/[^"]+\.m3u8[^"]*)"/) || html.match(/'(https?:\/\/[^']+\.m3u8[^']*)'/) ||
                    html.match(/https?:\/\/[^\s"]+\.m3u8[^\s"]*/);
    if (m3u8Match) {
        let playUrl = m3u8Match[1] || m3u8Match[0];
        return JSON.stringify({ parse: 0, url: playUrl.replace(/\\/g, ""), header: headers });
    }

    let iframeMatch = html.match(/<iframe[^>]*src="([^"]+)"[^>]*>/i) || html.match(/<video[^>]*src="([^"]+)"[^>]*>/i);
    if (iframeMatch) {
        let iframeUrl = iframeMatch[1];
        iframeUrl = iframeUrl.startsWith('//') ? `https:${iframeUrl}` : !iframeUrl.startsWith('http') ? `${host}${iframeUrl.startsWith('/') ? '' : '/'}${iframeUrl}` : iframeUrl;
        return JSON.stringify({ parse: 1, url: iframeUrl, header: headers });
    }

    return JSON.stringify({ parse: 1, url: url, header: headers });
}

export default { init, home, homeVod, category, detail, search, play };
