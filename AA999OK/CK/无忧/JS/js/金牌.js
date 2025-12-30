var rule = {
    title: '金牌',
    host: 'https://www.cfkj86.com/',
    url: '/vod/show/id/fyclass/page/fypage',
    searchUrl: '/vod/search/**',
    searchable: 2,
    filterable: 0,
    class_name: '电影&电视剧&综艺&动漫',
    class_url: '1&2&3&4',
    play_parse: true,
    headers: {
                'User-Agent': 'PC_UA',
            },
            lazy: '',
            limit: 6,
            推荐: '',
            double: true, // 推荐内容是否双层定位
            一级: '.movie-ul a;.title&&Text;img&&src;.bottom&&Text;a&&href',
            二级: {
                "title": "h1&&Text;.tag&&Text",
                "img": "*",
                "desc": ";;;.director:eq(1)&&Text;.director:eq(0)&&a&&Text",
                "content": ".wrapper_more_text&&Text",
                "tabs": ".player_name",
                "lists": ".listitem a"
            },

            搜索: 'ul a;.title&&Text;img&&src;.bottom&&Text;a&&href',
}