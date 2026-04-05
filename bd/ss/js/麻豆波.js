var rule = {
    title: '麻豆波', //规则标题,没有实际作用,但是可以作为cms类名称依据
    编码: 'utf8', //不填就默认utf-8
    搜索编码: '',
    host: 'https://www.madoubo.com/',
    url: '/vodtype/fyclass-fypage.html',
    searchUrl: '/vodsearch/**-fypage/',
    searchable: 0, //是否启用全局搜索,
    quickSearch: 0, //是否启用快速搜索,
    filterable: 0, //是否启用筛选,
    headers: {
        'User-Agent': 'MOBILE_UA',
    },
    timeout: 5000, //网站的全局请求超时,默认是3000毫秒
     class_name: '麻豆视频&91制片厂&天美传媒&蜜桃传媒&皇家华人&星空传媒&精东影业&乐播传媒&乌鸦传媒&兔子先生&杏吧原创&玩偶姐姐&mini传媒&大象传媒&开心鬼传媒&PsychoPorn&糖心Vlog&萝莉社&性视界&日本无码&囯产视频&欧美高清&成人动漫', //静态分类名称拼接
     class_url: '1&2&3&4&5&6&7&8&9&10&11&12&13&14&15&16&17&18&20&21&22&23&24', //静态分类标识拼接
    //class_parse: '.nav-item&&;a&&Text;a&&href',
    //动态分类获取 列表;标题;链接;正则提取 不需要正则的时候后面别加分号
    cate_exclude: '',
    lazy: '',
    // 首页推荐显示数量
    limit: 6,
    double: true, //是否双层列表定位,默认false
    // 图片来源: '@Referer=http://www.jianpianapp.com@User-Agent=jianpian-version350',

    // 类似海阔一级 列表;标题;图片;描述;链接;详情 其中最后一个参数选填
    // 如果是双层定位的话,推荐的第2段分号代码也是第2层定位列表代码
    //推荐: '.col-sm-6;h3&&Text;img&&data-src;.date&&Text;a&&href',
    // 类似海阔一级 列表;标题;图片;描述;链接;详情 其中最后一个参数选填
    一级: '.stui-vodlist&&.stui-vodlist__box;a&&title;a&&data-original;h4&&Text;a&&href',
    // 二级可以是*,表示规则无二级,直接拿一级的链接进行嗅探
    // 二级 title: 片名;类型
    // 二级 desc: 主要信息;年代;地区;演员;导演
    // {title:'',img:'',desc:'',content:'',tabs:'video.movie',lists:'',tab_text:'body&&Text',list_text:'body&&Text',list_url:'a&&href'} 同海阔dr二级
    二级: '*',
    // 搜索可以是*,集成一级，或者跟一级一样的写法 列表;标题;图片;描述;链接;详情
    搜索: '*',
}