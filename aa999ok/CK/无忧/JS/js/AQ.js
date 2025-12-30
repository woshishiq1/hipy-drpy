var rule = {
    title: 'AQ影视[搜]',
    host: 'https://wpzy.me',
    url: '/fyclass?page=fypage',
    searchUrl: '/?q=**',
    searchable: 2,
    quickSearch: 0,
    headers: {
        'User-Agent': 'PC_UA',
    },
    timeout: 5000,
    class_name:'全部&夸克&迅雷&电影&电视剧&动漫&综艺&纪录片&精选合集',
	class_url:'all&t/kuake&t/xunlei&t/dianying&t/juji&t/dongman&t/zongyi&t/jilu&t/heji',
    play_parse: true,
    //推送阿里播放  支持影视壳
  lazy: $js.toString(() => {
        let url = input.startsWith('push://') ? input : 'push://' + input;
        input = {parse: 0, url: url};
    }),
    一级: '.container li;a&&Text; ; ;a&&href',
    二级: {
    "title": ".Post-body&&p:eq(1)&&Text",
    "img": ".Post-body&&img&&src",
    "desc": "",
    "content": ".Post-body&&p:eq(0)&&Text",
    "tabs": "",
    "lists": ".Post-body&&p:eq(1)&&a",
    "list_text": ""
            },
    搜索: '*',
}