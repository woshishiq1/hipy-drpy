var rule={
  title: "",
  host: "https://www.bbbu.top/",
  url: "/fyclass/fypage/",
  searchUrl: "/search/**/fypage/",
  searchable: 2,
  quickSearch: 0,
  headers: {
    "User-Agent": "MOBILE_UA"
  },
  timeout: 5000,
  class_parse: ".row&&a;a&&Text;a&&href;.*/(.*)/",
  cate_exclude: "",
  hikerListCol:"movie_2",
  hikerClassListCol:"movie_2",
  play_parse: true,
  lazy: $js.toString(() => {
        let html = request(input);
        let _url = pdfh(html, '.bofang_box&&iframe&&src').replace('https://www.bbbu.top/usr/themes/Yeti/ext/danmu/player/?url=','');
        input = {parse: 0, url: _url, js: ''};
    }),
  double: false,
  推荐: "*",
  一级: "body&&.video-img-box:has(h6);h6&&Text;img&&data-src;;a&&href",
  二级: '*',
  搜索: "*"
}