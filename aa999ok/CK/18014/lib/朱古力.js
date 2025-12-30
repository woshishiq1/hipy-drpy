
var rule = {
    title:'朱古力',
    host:'https://pigav.com',
    	searchUrl:'/?s=**',
    url:'/fyclass/page/fypage',
    headers:{
        'User-Agent':'MOBILE_UA'
    },
    timeout:5000,
    class_name:'最新&熱門&每日&精選',//静态分类名称拼接
    class_url:'最新av線上看&熱門av線上看&每日av線上看線上看&精選av線上看',//静态分类标识拼接
    limit:5,
    play_parse:true,
    lazy:'',
    一级:'.l-post div&&a;a&&title;span&&data-bgsrc;.absolute.bottom-1&&Text;a&&href',
    二级:'*',
    搜索:'.l-post div&&a;a&&title;span&&data-bgsrc;.absolute.bottom-1&&Text;a&&href',
    	searchable:1,//是否启用全局搜索,
    quickSearch:1,//是否启用快速搜索,
    filterable:0,//是否启用分类筛选,
}
