// http://localhost:5757/api/金牌影院?ac=list&t=1&pg=1
// http://localhost:5757/api/金牌影院?ac=detail&ids=/detail/131374
// http://localhost:5757/api/金牌影院?wd=我的&pg=1
// http://localhost:5757/api/金牌影院?play=/vod/play/131374/sid/1125278&flag=金牌影院
var rule = {
    类型: '影视',
    title: '金牌影院',
    desc: '金牌影院纯js版本',
    host: 'https://www.cfkj86.com',
    homeUrl:'',
    url: 'https://m.cfkj86.com/api/mw-movie/anonymous/video/list?pageNum=fypage&pageSize=30&sort=1&sortBy=1&type1=fyclass',
    searchUrl: '/api/mw-movie/anonymous/video/searchByWordPageable?keyword=**&pageNum=fypage&pageSize=12&type=false',
    searchable: 2,
    quickSearch: 0,
    timeout: 5000,
    play_parse: true,
    headers: {
        'User-Agent': 'MOBILE_UA',
    },
    class_parse: async () => {
         let classes = [{
                type_id: '1',
                type_name: '电影',
            },{
                type_id: '2',
                type_name: '剧集',
            },{
                type_id: '3',
                type_name: '综艺',
            },{
                type_id: '4',
                type_name: '动漫',
            }];
        return {
            class: classes,
        }
    },
    预处理: async () => {
        return []
    },
    推荐: async () => {
        return []
    },
    一级: async function (tid, pg, filter, extend) {
        let {MY_CATE, input} = this;
        if (pg <= 0) pg = 1;
        const t = new Date().getTime()
        const signkey = `pageNum=${pg}&pageSize=30&sort=1&sortBy=1&type1=${tid}&key=cb808529bae6b6be45ecfab29a4889bc&t=`+t
        const key = CryptoJS.SHA1(CryptoJS.MD5(signkey).toString()).toString()
        const html = JSON.parse((await req(`https://m.cfkj86.com/api/mw-movie/anonymous/video/list?pageNum=${pg}&pageSize=30&sort=1&sortBy=1&type1=${tid}`,
            {
            headers:{
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36',
                'Accept': 'application/json, text/plain, */*',
                'deviceId': '58a80c52-138c-48fd-8edb-138fd74d12c8',
                'sign': key,
                't': t
            }
        })).content);
        let d = [];
        const list = html.data.list
        log(list)
        list.forEach((it)=>{
            d.push({
                title: it.vodName,
                url: '/detail/'+it.vodId,
                desc: it.vodRemarks || it.vodVersion,
                pic_url: it.vodPic,
            })
        })
        return setResult(d)
    },
    二级: async function (ids) {
        let {input} = this;
        const html = (await req(`${input}`)).content;
        const $ = pq(html)
        const vod = {
            vod_id: input,
            vod_name: $('h1').text().trim(),
        };
        let playFroms = [];
        let playUrls = [];
        const temp = [];
        let playlist=$('div.main-list-sections__BodyArea-sc-8bb7334b-2 .listitem')
        for (const it of playlist) {
            const a = $(it).find('a')[0]
            temp.push(a.children[0].data+'$'+a.attribs.href)
        }
        playFroms.push('不知道倾情打造');
        playUrls.push(temp.join('#'));
        vod.vod_play_from = playFroms.join('$$$');
        vod.vod_play_url = playUrls.join('$$$');

        return vod
    },
    搜索: async function (wd, quick, pg) {
        let {input} = this
        const t = new Date().getTime()
        //keyword=你&pageNum=1&pageSize=12&type=false&key=cb808529bae6b6be45ecfab29a4889bc&t=1722904806016
        const signkey = 'keyword='+wd+'&pageNum='+pg+'&pageSize=12&type=false&key=cb808529bae6b6be45ecfab29a4889bc&t='+t
        const key = CryptoJS.SHA1(CryptoJS.MD5(signkey).toString()).toString()
        let html = JSON.parse((await req(input,
            {
                headers:{
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36',
                    'Accept': 'application/json, text/plain, */*',
                    'deviceId': '58a80c52-138c-48fd-8edb-138fd74d12c8',
                    'sign': key,
                    't': t
                }
        })).content);
        let d = [];
        const list = html.data.list
        list.forEach((it)=>{
            d.push({
                title: it.vodName,
                url: '/detail/'+it.vodId,
                desc: it.vodRemarks || '暂无更新',
                pic_url: it.vodPic,
            })
        })
        return setResult(d)
    },
    lazy: async function (flag, id, flags) {
        let {input} = this;
        const pid = input.split('/')[3]
        const nid = input.split('/')[5]
        const t = new Date().getTime()
        const signkey = 'id='+pid+'&nid='+nid+'&key=cb808529bae6b6be45ecfab29a4889bc&t='+t
        const key = CryptoJS.SHA1(CryptoJS.MD5(signkey).toString()).toString()
        const relurl = rule.host+'/api/mw-movie/anonymous/v1/video/episode/url?id='+pid+'&nid='+nid
        const html = JSON.parse((await req(relurl,
            {
                headers:{
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
                    'Accept': 'application/json, text/plain, */*',
                    'Accept-Encoding': 'gzip, deflate, br, zstd',
                    'sec-ch-ua-platform': '"Windows"',
                    'deviceId': '58a80c52-138c-48fd-8edb-138fd74d12c8',
                    'sign': key,
                    't': t,
                    'referer': `${rule.host}${input}`,
                    'authorization': '',
                }
        })).content)
        return {parse: 0, url: getProxyUrl()+'&url='+encodeURIComponent(html.data.playUrl), js: ''}
    },
    proxy_rule: async function()  {
        let {input} = this
        if (input) {
            input = decodeURIComponent(input);
            log(`${rule.title}代理播放:${input}`);
            let m3u8 = (await req(input,{headers:rule.headers})).content;
            const lines = m3u8.split('\n');
            const tsUrls = [];
            let link_start = ''
            lines.forEach(line => {
                if (line.trim().startsWith('http') && line.endsWith('.ts')) {
                    tsUrls.push(/line/,link_start + line.trim())
                }
                if (line.indexOf('.ts') > 0) { // 确保只匹配 TS 片段的 URL
                    link_start = input.split('?')[0].replace(/([^/]+)(?=\.m3u8(?:$|[\?#]))/, '').replace('.m3u8', '')
                    tsUrls.push(link_start + line.trim())
                }else {
                    tsUrls.push(line)
                }
            })
            let m3u8_text = tsUrls.join('\n')
            return [200,'application/vnd.apple.mpegurl', m3u8_text];
        }
    },
};

