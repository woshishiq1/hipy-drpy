var rule = {
    title: '蜜桃',
    模板: '首图',
    host: 'https://www.xiangjiaoshipin3.com',
    url: '/type/fyclass/fypage.html',
    searchUrl: '/search?wd=**',
    searchable: 2,
    filterable: 0,
    class_parse: '.navbar-nav li;.nav-link-title&&Text;a&&href;/(\\d+).html',
    play_parse: true,
    headers: {
                'User-Agent': 'MOBILE_UA',
            },
            lazy: '',
            limit: 6,
            推荐: '.row-cards;.rows-md-8;a&&title;img&&data-src;.badge&&Text;a&&href',
            double: true, // 推荐内容是否双层定位
            一级: '.row-cards .rows-md-8;h3&&Text;img&&src;.badge&&Text;a&&href',
            二级: {
                "title": ".d-md-block&&Text;.badge&&Text",
                "img": ".myui-content__thumb .lazyload&&data-original",
                "desc": "",
                "content": "",
                "tabs": ".card-header",
                "lists": ".d-flex:eq(#id) a"
            },

            搜索: '.row-cards .rows-md-8;h3&&Text;img&&src;.badge&&Text;a&&href',
}