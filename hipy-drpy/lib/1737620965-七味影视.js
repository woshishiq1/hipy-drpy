var rule = {
  类型: "影视",
  title: "七味影视",
  host: "https://www.qwnull.com",
  searchUrl: "/vs/**----------fypage---.html",
  url: "/vt/fyclass-fypage.html",
  headers: {
    "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
  },
  timeout: 5000,
  class_parse: ".nav&&ul&&li:gt(0):lt(6);a&&Text;a&&href;.*/(.*?).html",
  cate_exclude: "",
  limit: 40,
  play_parse: true,
  double: true,
  lazy: $js.toString(() => {
    input = { parse: 1, url: input, js: "" }
  }),
  推荐: "*",
  一级: ".content-list&&li;a&&title;img&&src;.tag&&Text;a&&href",
  二级: {
    title: "h1&&Text;.main-ui-meta&&div:eq(4)&&Text",
    img: ".img&&img&&src",
    desc: ".main-ui-meta&&div:eq(9)&&Text;.main-ui-meta&&div:eq(7)&&Text;.main-ui-meta&&div:eq(5)&&Text;.main-ui-meta&&div:eq(3)&&Text;.main-ui-meta&&div:eq(1)&&Text",
    content: ".zkjj_a&&Text",
    tabs: ".py-tabs&&li",
    lists: ".player:eq(#id)&&a",
    tab_text: "body&&Text",
    list_text: "body&&Text",
    list_url: "a&&href",
    list_url_prefix: "",
  },
  // 搜索有验证码, 需要ocr
  // 搜索: '.sr_lists&&dl;dd&&a&&Text;dd&&img&&src;dd&&p:eq(5)&&Text;a&&href',
  searchable: 2,
  quickSearch: 0,
  filterable: 0,
}