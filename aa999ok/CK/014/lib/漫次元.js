var rule = {
     title: '漫次元 - LR',
     host: 'https://www.mcydh.com',
     homeUrl: '/map.html',
     模板:'短视2',
     searchUrl: '/vodsearch/**----------fypage---.html',
     url:'/index.php/api/vod#type=fyclass&page=fypage',
     detailUrl:'/voddetail/fyid-1-1.html',
     searchable: 2,//是否启用全局搜索,
     quickSearch: 1,//是否启用快速搜索,
     filterable: 0,//是否启用分类筛选,
     headers: {
       'User-Agent': 'MOBILE_UA',
     },
     play_parse: true,
     lazy:`js:
        var html = JSON.parse(request(input).match(/r player_.*?=(.*?)</)[1]);
        var url = html.url;
        var from = html.from;
        if (html.encrypt == '1') {
            url = unescape(url)
        } else if (html.encrypt == '2') {
            url = unescape(base64Decode(url))
        }
        if (/m3u8|mp4/.test(url)) {
            input = url
        } else {
        }
     `,
     limit: 6,
     tab_rename:{'排序':'LR',},
     class_name:'番剧&剧场版',
     class_url:'20&22',
     double: false, // 推荐内容是否双层定位
     推荐: '.public-list-exp;a&&title;img&&data-src;.ft2&&Text;a&&href',
     一级:`js:
        let body = input.split("#")[1];
        let t = Math.round(new Date / 1e3).toString();
        let key = md5("DS" + t + "DCC147D11943AF75");
        let url = input.split("#")[0];
        body = body + "&time=" + t + "&key=" + key;
        print(body);
        fetch_params.body = body;
        let html = post(url, fetch_params);
        let data = JSON.parse(html);
        VODS = data.list.map(function(it) {
            it.vod_pic = it.vod_pic.replace(/mac/, "https");
            return it
        });
     `,
     二级:{
           "title":".slide-info-title&&Text;#qiAnDao_1&&Text",
           "img":".detail-pic&&data-original",
           "desc":".this-text&&Text;.deployment&&span:eq(0)&&Text;.deployment&&span:eq(2)&&Text",
           "content":"#height_limit&&Text",
           "tabs":"#zxdaoxu",
           "lists":".anthology-list-play:eq(#id) li"
          },
     搜索: '.public-list-box;.thumb-txt&&Text;.public-list-exp&&img&&data-src;.public-list-prb&&Text;a&&href'
    }
