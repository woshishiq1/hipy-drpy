var rule = {
    title: '兔兔盘[搜]',
    host: 'https://xiaotusoso.com',
    searchUrl: '/search?page=fypage&size=20&q=**&type=ALL&share_time=ALL&format=video&mode=common&gateway=G1',
    searchable: 2,
    quickSearch: 0,
    headers: {
        'User-Agent': 'PC_UA',
    },
    timeout: 5000,
    play_parse: true,
    //推送阿里播放  支持影视壳
  lazy: $js.toString(() => {
        let url = input.startsWith('push://') ? input : 'push://' + input;
        input = {parse: 0, url: url};
    }),
    //一级: '*',
    二级: '*',
    搜索: '.p-2 .mx-auto;.text-lg&&Text;img&&src;.text-stone-600&&span&&Text;a&&href',
}