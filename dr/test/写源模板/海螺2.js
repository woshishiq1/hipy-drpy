var rule = {
  title: '',
  host: '',
  searchUrl: '/index.php/vod/search/page/fypage/wd/**/',
  url: '/index.php/vod/show/id/fyclass/page/fypage/',
  headers: {
    'User-Agent': 'MOBILE_UA',
  },
  timeout: 5000,
  class_parse: '#nav-bar li;a&&Text;a&&href;id/(.*?)/',
  limit: 40,
  play_parse: true,
  lazy: "js:\n  let html = request(input);\n  let hconf = html.match(/r player_.*?=(.*?)</)[1];\n  let json = JSON5.parse(hconf);\n  let url = json.url;\n  if (json.encrypt == '1') {\n    url = unescape(url);\n  } else if (json.encrypt == '2') {\n    url = unescape(base64Decode(url));\n  }\n  if (/\\.(m3u8|mp4|m4a|mp3)/.test(url)) {\n    input = {\n      parse: 0,\n      jx: 0,\n      url: url,\n    };\n  } else {\n    input;\n  }",
  double: true,
  推荐: '.list-a.size;li;a&&title;.lazy&&data-original;.bt&&Text;a&&href',
  一级: '.list-a&&li;a&&title;.lazy&&data-original;.list-remarks&&Text;a&&href',
  二级: {
    title: 'h2&&Text;.deployment&&Text',
    img: '.lazy&&data-original',
    desc: '.deployment&&Text',
    content: '.ec-show&&Text',
    tabs: '#tag&&a',
    lists: '.play_list_box:eq(#id)&&li',
  },
  搜索: '.search-list;a&&title;.lazy&&data-original;.deployment&&Text;a&&href',
  searchable: 2,
  quickSearch: 0,
  filterable: 0,
}