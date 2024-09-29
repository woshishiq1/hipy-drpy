var rule={
    title:'韩剧网',
    host: 'https://www.hanju5.com',
    url: '/vodtype/fyclass-fypage/',
    searchUrl:'/vodsearch/**----------fypage---/',
    searchable:2,//是否启用全局搜索,
    quickSearch:0,//是否启用快速搜索,
    filterable:0,//是否启用分类筛选,
    headers:{//网站的请求头,完整支持所有的,常带ua和cookies
        'User-Agent':'MOBILE_UA',
        // "Cookie": "searchneed=ok"
    },
    class_parse:'.fed-pops-list&&li;a&&Text;a&&href;type/(.*?)/',
    cate_exclude:'原站',
    play_parse:true,
    limit:6,
    推荐:'body&&.fed-list-info:not(:matches(韩国新闻));ul&&li;*;*;*;*',
double:true, // 推荐内容是否双层定位
一级:'.fed-list-info&&li;.fed-list-title&&Text;a&&data-original;a&&Text;a&&href',
二级:{"title":".fed-part-layout&&li,1&&Text;.fed-part-layout&&li,3&&Text","img":".fed-part-layout&&a&&data-original","desc":".fed-part-layout&&li,4&&Text","content":".fed-conv-text&&Text","tabs":".fed-tabs-foot&&.fed-part-rows&&li","lists":".fed-tabs-btm:eq(#id)&&li"},
}
