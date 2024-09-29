var rule={
            title: '阳光电影网',
            host: 'https://www.yespopo.com/',
            url: '/vodtype/fyclass-fypage.html',
  //https://www.haileizuche.com/vodshow/1--------2---.html
            searchUrl: 'https://www.yespopo.com/vodsearch/**----------fypage---.html',
 // https://www.haileizuche.com/vodsearch/%E6%96%97----------2---.html          
            searchable: 2,//是否启用全局搜索,
            quickSearch: 0,//是否启用快速搜索,
            filterable: 0,//是否启用分类筛选,
            headers: {
                'User-Agent': 'UC_UA', // "Cookie": ""
            },             class_parse: '.myui-header__menu li;a&&Text;a&&href;/(\\d+).html',
            play_parse: true,
            lazy: '',
            limit: 6,
            推荐: 'ul.myui-vodlist.clearfix;li;a&&title;a&&data-original;.pic-text&&Text;a&&href',
            double: true, // 推荐内容是否双层定位
            一级: '.myui-vodlist li;a&&title;a&&data-original;.pic-text&&Text;a&&href',
            二级: {
                "title": ".myui-content__detail .title&&Text;.myui-content__detail p:eq(-2)&&Text",
                "img": ".myui-content__thumb .lazyload&&data-original",
                "desc": ".myui-content__detail p:eq(0)&&Text;.myui-content__detail p:eq(1)&&Text;.myui-content__detail p:eq(2)&&Text",
                "content": ".content&&Text",
                "tabs": ".nav-tabs:eq(0) li",
                "lists": ".myui-content__list:eq(#id) li"
            },
            搜索: '#searchList li;a&&title;.lazyload&&data-original;.text-muted&&Text;a&&href;.text-muted:eq(-1)&&Text',
        }