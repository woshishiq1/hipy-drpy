var rule = {   
    title: 'pipi视频',
    "规则作者": "mike",
    host: 'https://wap.pipisp1.xyz',
    url: '/pipi/index.php/vod/type/id/fyclass/page/fypage.html',
    searchUrl: '/pipi/index.php/vod/search/page/fypage/wd/**.html',
    cate_exclude: '专题',
    class_name:'奥斯卡资源&黄瓜资源&森林资源&老鸭资源',
    class_url:'86&87&117&135',
   // 服务器解析播放
    play_parse:true,
    lazy:`js:
        var html = JSON.parse(request(input).match(/r player_.*?=(.*?)</)[1]);
        var url = html.url;
        if (html.encrypt == '1') {
            url = unescape(url)
        } else if (html.encrypt == '2') {
            url = unescape(base64Decode(url))
        }
        if (/\\.m3u8|\\.mp4/.test(url)) {
            input = {
                jx: 0,
                url: url,
                parse: 0
            }
        } else {
            input
        }
    `,
    一级: '.stui-vodlist&&li;a&&title;.lazyload&&data-original;.pic-text&&Text;a&&href',
    二级:"*",
    搜索: 'ul.stui-vodlist__media,ul.stui-vodlist,#searchList li;a&&title;.lazyload&&data-original;.pic-text&&Text;a&&href',
    }
