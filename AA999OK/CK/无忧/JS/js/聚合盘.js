var rule = {
    title: '聚合盘[搜]',
    host: 'http://www.662688.xyz',
    searchUrl: '/api/get_zy?keyword=**',
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
    // 一级: '',
    二级: '*',
    搜索: 'json:data;title;;title;url;url',
}