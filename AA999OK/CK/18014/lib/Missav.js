var rule = {
    title:'Missav',
    host:'https://missav.ai/',
	searchUrl:'/cn/search/**',
    url:'/cn/fyclass?page=fypage',
    headers:{
        'User-Agent':'MOBILE_UA'
    },
    timeout:5000,
    class_name:'最近更新&新作上市&中文字幕&无码流出&VR&麻豆传媒&今日热门&本周热门&本月热门&SIRO&LUXU&GANA&PRESTIGE PREMIUM&S-CUTE&ARA&FC2&HEYZO&东京热&一本道&カリビアンコム&Caribbeancompr&天然むすめ&パコパコママ&ガチん娘!&XXX-AV&人妻斩&エッチな 4610 &エッチな 0930&TWAV&Furuke&韩国直播&中国直播',//静态分类名称拼接
    class_url:'new&release&chinese-subtitle&uncensored-leak&genres/VR&madou&today-hot&weekly-hot&monthly-hot&siro&luxu&gana&maan&scute&ara&fc2&heyzo&tokyohot&1pondo&caribbeancom&caribbeancompr&10musume&pacopacomama&gachinco&xxxav&marriedslash&naughty4610&naughty0930&twav&furuke&klive&clive',//静态分类标识拼接
    limit:5,
    play_parse:true,
    lazy:'',
    一级:'.grid.grid-cols-2 div&&a;.lozad.w-full&&alt;.lozad.w-full&&data-src;.absolute.bottom-1&&Text;a&&href',
    二级:'*',
	搜索:'.grid.grid-cols-2 div&&a;.lozad.w-full&&alt;.lozad.w-full&&data-src;.absolute.bottom-1&&Text;a&&href',
	searchable:1,//是否启用全局搜索,
    quickSearch:1,//是否启用快速搜索,
    filterable:0,//是否启用分类筛选,
}
