//由钓鱼分享自写
var rule = {
    title: '4k影院',
    author: '🍁凯少爷🍁',
    host: 'https://4k4k.live',
    url: '/vodshow/fyclass--------fypage---/',
    searchUrl: '/vodsearch/**----------fypage---.html',
    searchable: 2,//是否启用全局搜索,
    quickSearch: 0,//是否启用快速搜索,
    filterable: 0,//是否启用分类筛选,
    headers: {
                'User-Agent':'MOBILE_UA', // "Cookie":"searchneed=ok"
            },
    编码: 'utf-8',
    timeout: 5000,
    class_name:'🍁凯少爷🍁电影4K&🍁凯少爷🍁电视剧4K&🍁凯少爷🍁综艺4K&🍁凯少爷🍁动漫4K',
  class_url:'1&2&3&4',
  tab_exclude: '今日更新|特斯拉全屏|网站最新地址',
    play_parse: true,
     lazy: `js:
    let html = request(input);
    let hconf = html.match(/r player_.*?=(.*?)</)[1];
    let json = JSON5.parse(hconf);
    let url = json.url;
    if (json.encrypt == '1') {
      url = unescape(url);
    } else if (json.encrypt == '2') {
      url = unescape(base64Decode(url));
    }
    if (/\\.(m3u8|mp4|m4a|mp3)/.test(url)) {
      input = {
        parse: 0,
        jx: 0,
        url: url,
      };
    } else {
      input;
    }`,
    limit: 6,
    double: true,
    推荐: '*',
一级: '.module-poster-item.module-item;a&&title;img&&data-original;.module-item-note&&Text;a&&href',
    二级: $js.toString(() => {
        VOD = {};
        let html = request(input);
        VOD.vod_name = pdfh(html, "h1&&Text");
        VOD.vod_pic = pd(html, "img&&data-original");
        VOD.vod_year = pdfh(html, ".module-info-tag-link:eq(0)&&Text");
        VOD.vod_area = pdfh(html, ".module-info-tag-link:eq(1)&&Text");
        VOD.type_name = pdfh(html, ".module-info-tag-link:eq(2)&&Text");
        VOD.vod_actor = pdfh(html, ".module-info-item:eq(3)&&Text");
        VOD.vod_director = pdfh(html, ".module-info-item-content:eq(0)&&Text");
        VOD.vod_remarks = "钓鱼分享";
        VOD.vod_content = pdfh(html, ".module-info-introduction-content&&Text");
        let playFrom = [];
        let playUrl = [];
        let tabs = pdfa(html, ".module-tab-item.tab-item");
        tabs.forEach((it, index) => {
            playFrom.push(pdfh(it, 'span&&Text'));
            let playTag = ".module-play-list-content:eq(" + index + ") a";
            let tags = pdfa(html, playTag);
            let mapUrl = tags.map((tag) => {
                let title = pdfh(tag, "a&&Text").trim();
                let purl = pdfh(tag, "a&&href");
                return title + "$" + rule.host + urlencode(purl);
            });
            playUrl.push(mapUrl.join("#"))
        });
        VOD.vod_play_from = playFrom.join("$$$");
        VOD.vod_play_url = playUrl.join("$$$");
    }),
            搜索:'.module-card-item.module-item;.module-card-item-title&&Text;img&&data-original;.module-info-item-content&&Text;a&&href',
        }
        