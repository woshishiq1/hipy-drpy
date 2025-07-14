var rule = {
     title: 'clicli - LR',
     host: 'https://www.clicli.pro',
     searchUrl: '/search/page/fypage/wd/**.html',
     url:'/type/fyclass-fypage',
     searchable: 2,//是否启用全局搜索,
     quickSearch: 1,//是否启用快速搜索,
     filterable: 0,//是否启用分类筛选,
     headers: {
       'User-Agent': 'MOBILE_UA'
     },
     play_parse: false,
     lazy:`js:
        var html = JSON.parse(request(input).match(/r player_.*?=(.*?)</)[1]);
        var url = html.url;
        var from = html.from;
        var MacPlayerConfig={};
        if (html.encrypt == '1') {
            url = unescape(url)
        } else if (html.encrypt == '2') {
            url = unescape(base64Decode(url))
        }
        if (/.m3u8|.mp4/.test(url)) {
            input = url
        } else {
        eval(fetch(HOST + '/static/js/playerconfig.js').replace('var Mac','Mac'));
        var list = MacPlayerConfig.player_list[from].parse;
            input={
                jx:0,
                url:list+url,
                parse:1,
                header: JSON.stringify({
                    'referer': HOST
                })
            }
        }
     `,
     limit: 6,
     tab_rename:{'排序':'LR',},
     class_name:'番剧&剧场&特摄',
     class_url:'20&21&24',
     推荐: '*',
     double: false, // 推荐内容是否双层定位
     一级: '.hl-col-sm-3;a&&title;a&&data-original;.remarks&&Text;a&&href',
     二级: {
              'title': 'h1&&Text',
              'img': '.lazyload&&data-original',
              'desc': '.module-info-item-content:eq(8)&&Text;.module-info-tag-link:eq(0)&&Text;.module-info-tag-link:eq(1)&&Text;.module-info-tag-link:eq(3)&&Text;.module-info-tag-link:eq(4)&&Text',
              'content': '.hl-content-text&&Text',
              'tabs': '.hl-play-source a',
              'lists': '#hl-plays-list:eq(#id) a'
          },
     搜索: '.hl-item-wrap;a&&title;a&&data-original;.remarks&&Text;a&&href'
    }
