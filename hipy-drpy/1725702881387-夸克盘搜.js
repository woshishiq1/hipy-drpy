var rule = {
    类型: '盘搜',
    author: '嗷呜',
    title: '夸克搜[盘]',
    host: 'https://www.quark.so',
    url: '/res/new/fyclass/fypage',
    searchUrl: '/s?query=**&p=fypage',
    homeUrl: '/res/new/all',
    searchable: 1,
    quickSearch: 0,
    filterable: 0,
    headers: {
        'User-Agent': 'MOBILE_UA',
    },
    timeout: 5000,
    class_name: '短剧&电影&电视剧&动漫',
    class_url: 'duanju&movie&dsj&anime',
    play_parse: true,
    lazy: $js.toString(() => {
        input = "push://" + input;
    }),
    double: false,
    推荐: '*',
    一级: $js.toString(() => {
        var d = []
        function getImage() {
            const now = new Date();
            const startTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 7, 0, 0);
            const endTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 17, 0, 0);
            if (now >= startTime && now <= endTime) {
                return "https://gitee.com/xttv/tvjson/raw/master/img/kk.jpg";
            } else {
                return "https://gitee.com/xttv/tvjson/raw/master/img/kkyj.png";
            }
        }
        var html = jsp.pdfh((request(input)), 'script:eq(-2)&&Html')
        var jsonArray = JSON.parse(html)
        const timeRegex = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{6}\+\d{4}$/;
        for (let i = 0; i < jsonArray.length; i++) {
            if (typeof jsonArray[i] === 'string' && jsonArray[i].includes('pan.quark.cn')) {
                let name = '';
                let count = 0;
                for (let j = i - 1; j >= 0; j--) {
                    if (typeof jsonArray[j] === 'string' && !Array.isArray(jsonArray[j]) && jsonArray[j] !== null) {
                        count++;
                        if (count === 2) {
                            name = jsonArray[j];
                            break;
                        }
                    }
                }
                let timeChar = '';
                for (let k = 1; k <= 5; k++) {
                    if (i + k < jsonArray.length && typeof jsonArray[i + k] === 'string') {
                        if (timeRegex.test(jsonArray[i + k])) {
                            timeChar = jsonArray[i + k];
                            break;
                        }
                    }
                }
                if (name && timeChar) {
                    d.push({
                        title: name,
                        img: getImage(),
                        url: name + "$" + jsonArray[i],
                        desc: timeChar
                    });
                }
            }
        }
        setResult(d)
    }),
    二级: $js.toString(() => {
        if (vod_id.includes('pan.quark.cn')) {
            VOD = {
                vod_play_from: '夸克网盘',
                vod_play_url: vod_id
            }
        } else {
            let html=fetch(input,{redirect:false})
            let nnm = jsp.pd(html, '.yp-detail-main-info-title&&Text')
            let uul = jsp.pdfh(html, 'script:eq(-2)&&Html').match(/https:\/\/pan\.quark\.cn\/[^"]+/g)[1]
            //console.log("dsaudyd==" + uul)
            VOD = {
                vod_play_from: '夸克网盘',
                vod_play_url: nnm + "$" + uul
            }
        }
    }),
    搜索: $js.toString(() => {
        var d = []
        function getImage() {
            const now = new Date();
            const startTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 7, 0, 0);
            const endTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 17, 0, 0);
            if (now >= startTime && now <= endTime) {
                return "https://gitee.com/xttv/tvjson/raw/master/img/kk.jpg";
            } else {
                return "https://gitee.com/xttv/tvjson/raw/master/img/kkyj.png";
            }
        }
        var html = jsp.pdfa(request(input), '.has-result&&a')
        html.forEach(it => {
            let uul = jsp.pd(it, 'a&&href')
            let uname = jsp.pd(it, '.item-title&&Text')
            let cont = jsp.pd(it, '.item-tag&&Text')
            d.push({
                url: uul,
                title: uname,
                img: getImage(),
                desc: cont,
            })
        })
        setResult(d)
    }),
    //   搜索: '.has-result a;.item-title&&Text;.resource-item&&img&&src;.item-tag&&Text;a&&href',
}