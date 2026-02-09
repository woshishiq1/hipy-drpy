var rule = {
    title: '种子音乐[听]',
    host: 'https://www.zz123.com',
    homeUrl: '/list/mszm.htm?page=1',
    url: '/fyclass.htm?page=fypage',
    searchable: 2,
    quickSearch: 0,
    headers: {
        'User-Agent': 'MOBILE_UA',
        'referer': 'https://www.zz123.com/',
    },
    class_parse: '.aside-menu-list.channel&&[href*=list];a&&Text;a&&href;.(list.*).htm',
    play_parse: true,
    
    // --- 重构的核心部分 ---
    lazy: $js.toString(() => {
        // 1. 将详情页 URL 替换为 API 接口 URL
        input = input.replace(/play\/(\w+)\.htm/, 'ajax/?act=songinfo&id=$1&lang=');
        
        // 2. 发起请求并解析 JSON
        let html = request(input);
        let json = JSON.parse(html);
        let data = json.data;
        
        // 3. 构造播放对象，包含歌词和元数据
        input = {
            parse: 0,
            url: data.mp3,          // 播放链接
            header: rule.headers,   // 请求头
            lrc: data.lrc,          // 歌词内容
            img: data.pic,          // 封面图片
            title: data.mname,      // 歌名
            singer: data.sname      // 歌手
        };
    }),
    // ---------------------
    
    limit: 6,
    推荐: "*",
    一级: '.mobile-list&&.mobile-list-item;.songname&&Text;.lazyload&&data-src;.authorname&&Text;a&&href',
    二级: '*',
    searchUrl: '/ajax/?act=search&key=**&lang=',
    detailUrl: '/play/fyid.html', // 修正：原来是 play/fyid.html，这里保持一致，lazy中正则会匹配
    搜索: 'json:data;mname;pic;sname;id',
}