var rule = {
    title: '鸡盒盘[搜]',
    host: 'https://so.jihepan.top',
    url: '/category-fyclass_fypage.html',
    searchUrl: '/search.php?q=**&page=fypage',
    searchable: 2,
    quickSearch: 0,
    headers: {
        'User-Agent': 'PC_UA',
    },
    timeout: 5000,
    class_name:'短剧&影视&电影大全&华语电影&历届奥斯卡&系列电影&国产剧&欧美剧&日韩剧&港台剧&泰剧&动漫剧集&动漫影视&动漫&音乐&综艺&纪录片&教程&戏曲&小品相声合集&港剧&阿里影视&阿里剧集&阿里综艺&阿里动漫&阿里纪录&阿里音乐&阿里教程&阿里文档&阿里小说',
	class_url:'1&28&10&33&39&40&29&31&30&32&38&37&36&27&11&14&25&26&43&42&12&4&5&8&16&23&9&17&20&22',
    play_parse: true,
    //推送阿里播放  支持影视壳
  lazy: $js.toString(() => {
        let url = input.startsWith('push://') ? input : 'push://' + input;
        input = {parse: 0, url: url};
    }),
    一级: '.sou-con-list li;a:eq(1)&&title; ;a:eq(0)&&title;a:eq(1)&&href',
    二级: {
    "title": ".detail_title&&Text;.detail-icon&&Text",
    "img": "",
    "desc": "",
    "content": "",
    "tabs": "",
    "lists": ".sou-con&&p:eq(1) a"
            },
    搜索: '.sou-con-list li;a:eq(1)&&title; ;a:eq(0)&&title;a:eq(1)&&href',
}