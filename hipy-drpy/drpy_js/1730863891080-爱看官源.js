var rule = {
	模板: '短视2',
    title: "爱看官源",
    host: "https://www.ikanju.cc/",
    url: '/index.php/api/vod#type=fyclass&page=fypage',
    searchUrl: "/vodsearch/page/fypage/wd/**.html",
	detailUrl:'/ikjfyid.html',
    searchable: 2,
    quickSearch: 0,
    headers: {
        "User-Agent": "MOBILE_UA"
    },
    timeout: 5000,
    class_name:'电影&电视剧&综艺&动漫',
    class_url:'1&2&3&4',
    play_parse: true,
    lazy:$js.toString(() => {

               
                input = {
                    jx: 1,
                    url: input,
                    parse: 0
                }
}
    
    ),

    double: true,
            二级:{
                "title":".slide-info-title&&Text;.slide-info:eq(3)--strong&&Text",
                "img":".detail-pic&&img&&data-src",
                "desc":".fraction&&Text;.slide-info-remarks:eq(1)&&Text;.slide-info-remarks:eq(2)&&Text;.slide-info:eq(2)--strong&&Text;.slide-info:eq(1)--strong&&Text",
                "content":"#height_limit&&Text",
                "tabs":".anthology-tab&&.swiper-wrapper&&a",
                "tab_text":".resource-btn&&Text",
                "lists":".anthology-list-box:eq(#id) li"
            },
    搜索: '.row-right .public-list-box;.lazy&&alt;.lazy&&data-src;.public-list-prb&&Text;a&&href',
}