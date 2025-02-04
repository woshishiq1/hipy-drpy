var rule = {
    title: '',
    host: 'http://d.fengche531.com',
    url: '/list/fyclass-fypage.html',
    class_name: '国产&日本&其他&电影',
    class_url: '137&138&157&158',
    searchUrl: '/search?hso=hso&keyww=**',
    推荐: '*',
    一级: '.list li;a:eq(1)&&Text;.imgblock&&style;.itemimgtext&&Text;a&&href',
    二级: {
        title: 'h1&&Text;p:matches(类型)&&Text',
        img: '.show&&img&&src',
        desc: 'p:matches(连载)&&Text',
        content: '.info&&Text',
        tabs: '.listtit&&span',
        lists: '#playlists:eq(#id)&&li',
    },
    搜索: '*',
    play_parse: true,
    lazy: $js.toString(() => {
    var url=request(input).match(/var paly_js = "(.*?)";/)[1].replaceAll('-', 'a').replaceAll('.','=')
    log(url)
    input={
     url:base64Decode(url),
     jx:0,
     parse:0
    }
   }),
}