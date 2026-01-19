var rule = {
  title: '555电影',
  host: 'https://www.555gy.cc',
  url: '/vod/type/id/fyclass/page/fypage.html',
  searchUrl: '/vod/search/page/fypage/wd/**.html',
  searchable: 2,
  quickSearch: 0,
  filterable: 0,
  headers: {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36',
    'Referer': 'https://www.555gy.cc/',
  },
  class_parse: '.navbar-items li:gt(0):lt(10);a&&Text;a&&href;/(\\d+)',
  play_parse: true,
  lazy: "js:\n  let html = request(input);\n  let hconf = html.match(/r player_.*?=(.*?)</)[1];\n  let json = JSON5.parse(hconf);\n  let url = json.url;\n  if (json.encrypt == '1') {\n    url = unescape(url);\n  } else if (json.encrypt == '2') {\n    url = unescape(base64Decode(url));\n  }\n  if (/\\.(m3u8|mp4|m4a|mp3)/.test(url)) {\n    input = {\n      parse: 0,\n      jx: 0,\n      url: url,\n    };\n  } else {\n    input;\n  }",
  limit: 6,
  double: true,
  预处理: $js.toString(() => {
    rule_fetch_params.headers.Cookie = 'cookie';
    let new_html = request(MY_URL);
    if (/滑动验证|人机身份验证/.test(new_html)) {
      let new_src = pd(new_html, "script&&src", HOST);
      let hhtml = request(new_src, { withHeaders: true });
      let json = JSON.parse(hhtml);
      let scriptHtml = json.body;
      let key = scriptHtml.split('key="')[1]?.split('"')[0] || '';
      let value = scriptHtml.split('value="')[1]?.split('"')[0] || '';
      let val = "";
      for (let i = 0; i < value.length; i++) { val += (value.charCodeAt(i) + 1).toString(); }
      let md5value = md5(val);
      let yz_url = rule.host + '/a20be899_96a6_40b2_88ba_32f1f75f1552_yanzheng_huadong.php?type=ad82060c2e67cc7e2cc47552a4fc1242&key=' + key + '&value=' + md5value;
      hhtml = request(yz_url, { withHeaders: true });
      json = JSON.parse(hhtml);
      let setCk = Object.keys(json).find(it => it.toLowerCase() === 'set-cookie');
      let cookie = setCk ? json[setCk].split(';')[0] : '';
      //log('cookie:' + cookie);
      rule_fetch_params.headers.Cookie = cookie;
      setItem(RULE_CK, cookie);
    }
  }),
  推荐: '.tab-list.active;a.module-poster-item.module-item;.module-poster-item-title&&Text;.lazyload&&data-original;.module-item-note&&Text;a&&href',
  一级: 'body a.module-poster-item.module-item;a&&title;.lazyload&&data-original;.module-item-note&&Text;a&&href',
  二级: {
    title: 'h1&&Text;.module-info-tag-link:eq(-1)&&Text',
    img: '.lazyload&&data-original||data-src||src',
    desc: '.module-info-item:eq(-2)&&Text;.module-info-tag-link&&Text;.module-info-tag-link:eq(1)&&Text;.module-info-item:eq(2)&&Text;.module-info-item:eq(1)&&Text',
    content: '.module-info-introduction&&Text',
    tabs: '.module-tab-item',
    lists: '.module-play-list:eq(#id) a',
    tab_text: 'div--small&&Text',
  },
  搜索: 'body .module-item;.module-card-item-title&&Text;.lazyload&&data-original;.module-item-note&&Text;a&&href;.module-info-item-content&&Text',
}