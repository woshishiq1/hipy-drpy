var rule = {
  title: "4kav",
  host: "https://4k-av.com",
  url: "/fyclass/page-fypage.html",
  searchUrl: "s?k=**",
  searchable: 2, //是否启用全局搜索,
  quickSearch: 0, //是否启用快速搜索,
  filterable: 0, //是否启用分类筛选,
  headers: { "User-Agent": "IOS_UA" },
  编码: "utf-8",
  timeout: 5000,
  class_name: "电影&电视剧",
  class_url: "movie&tv&",
  tab_exclude: "av",
  play_parse: true,
  lazy: `js:
if (/m3u8|mp4/.test(input)) {
input = { jx: 0, parse: 0, url: input }
} else {
let kurl = request(input).match(/<source src="(.*?)"/)[1];
input = { jx: 0, parse: 0, url: kurl }
}
`,
  limit: 6,
  double: true,
  推荐: "*",
  一级: ".NTMitem;a&&title;img&&src;.tags&&Text;a&&href",
  二级: {
    title: ".slide-info-title&&Text",
    img: "img&&src",
    desc: ".tags&&Text",
    content: ".cnline&&Text",
    tabs: 'js:TABS = ["钓鱼分享"]',
    lists: "ul#rtlist&&li",
    tab_text: "body&&Text",
    list_text: "span&&Text",
    list_url: "a&&href",
  },
  搜索: ".virow.search;.title&&Text;img&&src;.tags&&Text;a&&href",
};