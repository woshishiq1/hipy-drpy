var rule = {
    title: 'omofunA',
    host: 'https://www.omofuna.com',
    url: '/type/fyclass-fypage.html',
    searchUrl: '/search/**----------fypage---.html',
    class_name: '日韩&国产&欧美&特摄&动态',
    class_url: '1&2&3&4&5',
    header: {
        'User-Agent': 'Mozilla/5.0 (Linux；； Android 13；； M2012K11AC Build/TKQ1.221114.001；； wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/120.0.6099.43 Mobile Safari/537.36',
        //   'Cookie': '_ga=GA1.1.838734081.1724616310；； PHPSESSID=str10nstdfshspfihg7puarmvb；； recente=%5B%7B%22vod_name%22%3A%22%E5%B0%8F%E5%B8%82%E6%B0%91%E7%B3%BB%E5%88%97%22%2C%22vod_url%22%3A%22https%3A%2F%2Fwww.omofuna.com%2Fanime%2F3cf84064894e1a9790f72177%2Fplay%2F5%2F1.html%22%2C%22vod_part%22%3A%22%E7%AC%AC01%E9%9B%86%22%7D%2C%7B%22vod_name%22%3A%22%E5%A4%9C%E6%A8%B1%E5%AE%B6%E7%9A%84%E5%A4%A7%E4%BD%9C%E6%88%98%22%2C%22vod_url%22%3A%22https%3A%2F%2Fwww.omofuna.com%2Fanime%2Faf27688518f65d57579883ef%2Fplay%2F1%2F1.html%22%2C%22vod_part%22%3A%221%E9%9B%86%22%7D%2C%7B%22vod_name%22%3A%22%E4%BA%A6%E5%8F%B6%E4%BA%A6%E8%8A%B1%22%2C%22vod_url%22%3A%22https%3A%2F%2Fwww.omofuna.com%2Fanime%2F5524cfc8f4dc67bd8168aa0a%2Fplay%2F1%2F1.html%23%25E7%25B2%25BE%25E5%2593%25816%22%2C%22vod_part%22%3A%221%E9%9B%86%22%7D%5D；； _ga_8JCZ6DPVZK=GS1.1.1724616309.1.1.1724620816.60.0.0&&Accept@text/html,application/xhtml+xml,application/xml；；q=0.9,image/avif,image/webp,image/apng,*/*；；q=0.8,application/signed-exchange；；v=b3；；q=0.7&&Accept-Language@zh-CN,zh；；q=0.9'
    },
    play_parse: true,
    lazy: $js.toString(() => {
        var htmll = request(input)
        var html = JSON.parse(htmll.match(/r player_.*?=(.*?)</)[1])
        let dmid=  htmll.match(/var d4ddy={[\s\S]*?}/)[0]
        log(dmid)

        var name = htmll.match(/var vod_name='(.*?)',/)[1]
        log(name)
        var from = html.from
        var url = html.url
        if (html.encrypt == '1') {
            url = unescape(url);
        } else if (html.encrypt == '2') {
            url = unescape(base64Decode(url));
        }


        var jx = request(HOST + '/static/player/' + html.from + '.js').match(/src="(.*?)'/)[1]


        let play = request(jx + url + "&dmid=" + dmid + "&next=" + html.link_next + "&name=" + name)
        log(play)
        if (/tudou/.test(html.from))

        {
            eval(getCryptoJS())

            function playData(Q, b) {
                const o = CryptoJS.enc.Utf8.parse("ABABEF777999CCCD"),
                    h = CryptoJS.AES.decrypt(Q, o, {
                        iv: CryptoJS.enc.Hex.parse(b)
                    });
                return h.toString(CryptoJS.enc.Utf8);
            }

           var playUrl =play.match(/url:(.*?)\),/)[1] + ')'
           
           
let videoUrl=eval(playUrl)
log(videoUrl)
            input = {

                jx: 0,
                url: videoUrl

            }
        } else {
            let video = play.match(/url: '(.*?)',/)[1]
            input = {
                jx: 0,
                url: video
            }

        }


    }),
    tab_order: ['土豆', '精品'],
    推荐: '*',
    一级: 'body&&.daFJ_dJJfFHa__gEI;a&&title;.lazyload&&data-original;span:eq(3)&&Text;a&&href',
    二级: {
        title: 'h1&&Text;.data:eq(7)&&Text',
        img: '.lazyload&&data-original',
        desc: '.data:eq(0)&&Text;.data:eq(1)&&Text;.data:eq(6)&&Text',
        content: '.detail-content&&Text',
        tabs: '.channel-tab--span&&a',
        lists: '.play-list-content:eq(#id) li',
    },
    searchUrl: '/rss.xml?wd=**&page=fypage',
    搜索: $js.toString(() => {
        let html = request(input);
        let items = pdfa(html, 'rss&&item');
        // log(items);
        let d = [];
        items.forEach(it => {
            it = it.replace(/title|link|author|pubdate|description/g, 'p');
            let url = pdfh(it, 'p:eq(1)&&Text');
            d.push({
                title: pdfh(it, 'p&&Text'),
                url: url,
                desc: pdfh(it, 'p:eq(3)&&Text'),
                content: pdfh(it, 'p:eq(2)&&Text'),
                pic_url: "",
            });
        });
        setResult(d);
    }),
}