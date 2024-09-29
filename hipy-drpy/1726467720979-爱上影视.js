
var rule = {
    title: '爱上',
    host: 'https://23dyw.cn',
    url: '/openapi/template/vod?limit=24&offset=fypage&categoryPid=fyclass',
    homeUrl: '/openapi/template/vod?limit=12',
    searchUrl: '/openapi/template/vod?limit=10&offset=0&keyword=**',
    headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'
    },
    searchable: 2,
    quickSearch: 1,
    filterable: 1,
    class_name: '电影&电视剧&综艺&动漫&短剧',
    class_url: '1&2&3&4&39',
    推荐: $js.toString(() => {
        let d = [];
        function mod(input) {
            if (!input.includes("https")) {
                return "https://23dyw.cn" + input;
            } else {
                return input;
            }
        }
        let data = JSON.parse(request(input)).list
        data.forEach(it => {
            let id = `https://23dyw.cn/openapi/template/vod/brief/${it.id}`
            d.push({
                url: id,
                title: it.name,
                img: mod(it.surfacePlot),
                desc: it.note,
            })
        });
        setResult(d)
    }),
    一级: $js.toString(() => {
        let d = [];

        function mod(input) {
            if (!input.includes("https")) {
                return "https://23dyw.cn" + input;
            } else {
                return input;
            }
        }

        let data = JSON.parse(request(`https://23dyw.cn/openapi/template/vod?limit=24&offset=${(MY_PAGE - 1) * 24}&categoryPid=${MY_CATE}`)).list
        data.forEach(it => {
            let id = `https://23dyw.cn/openapi/template/vod/brief/${it.id}`
            d.push({
                url: id,
                title: it.name,
                img: mod(it.surfacePlot),
                desc: it.note,
            })
        });
        setResult(d)
    }),
    二级: $js.toString(() => {
        let datas = JSON.parse(request(input)).info.playLines
        let result=[]
        datas.forEach(line => {
            result.push(line.name);
        });
        const result1 = datas.map(item =>
            item.addr.map(addr => `${addr.name}$${addr.url}`).join('#')
        ).join('$$$');
        VOD = {            
            vod_play_from: result.join('$$$'),
            vod_play_url: result1
        }
    }),
    搜索: $js.toString(() => {
        let d = [];

        function mod(input) {
            if (!input.includes("https")) {
                return "https://23dyw.cn" + input;
            } else {
                return input;
            }
        }

        let data = JSON.parse(request(input)).list
        data.forEach(it => {
            let id = `https://23dyw.cn/openapi/template/vod/brief/${it.id}`
            d.push({
                url: id,
                title: it.name,
                img: mod(it.surfacePlot),
                desc: it.note,
            })
        });
        setResult(d)
    }),
}