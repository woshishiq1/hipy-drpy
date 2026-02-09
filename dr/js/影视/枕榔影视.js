globalThis.slideBox = function (url) {
  globalThis._slideCookie = globalThis._slideCookie || '';
  
  let new_html = request(url, { 
    method: 'GET',
    headers: { 
      'User-Agent': MOBILE_UA, 
      'Referer': HOST,
      'Cookie': globalThis._slideCookie
    } 
  });
  
  if (!/滑动验证|人机身份验证/.test(new_html)) return new_html;
    
  let new_src = pd(new_html, 'script[src*="huadong"]&&src', HOST);
  if (!new_src) return '';
    
  let hhtml = request(new_src, {
    withHeaders: true,
    headers: { 
      'User-Agent': MOBILE_UA, 
      'Referer': url,
      'Cookie': globalThis._slideCookie
    } 
  });
  
  let json = typeof hhtml === 'string' ? JSON.parse(hhtml) : hhtml;
  let scriptHtml = json.body || json;
  
  let key = (scriptHtml.split('key="')[1] || '').split('"')[0];
  let value = (scriptHtml.split('value="')[1] || '').split('"')[0];
  
  if (!key || !value) return '';
  
  let val = Array.from(value).map(c => c.charCodeAt(0) + 1).join('');
  let md5value = md5(val);
  
  let yz_url = HOST + '/a20be899_96a6_40b2_88ba_32f1f75f1552_yanzheng_huadong.php?type=ad82060c2e67cc7e2cc47552a4fc1242&key=' + key + '&value=' + md5value;
    
  hhtml = request(yz_url, { 
    withHeaders: true,
    headers: { 
      'User-Agent': MOBILE_UA, 
      'Referer': new_src,
      'Cookie': globalThis._slideCookie
    } 
  });
  
  json = typeof hhtml === 'string' ? JSON.parse(hhtml) : hhtml;
  let setCk = Object.entries(json).find(([k]) => k.toLowerCase() === 'set-cookie')?.[1];
  let slidecookie = null;
  
  if (setCk) {
    const cookieStr = Array.isArray(setCk) ? setCk.find(c => c) : setCk;
    const match = cookieStr?.match(/([^=]+=[^;]+)/);
    slidecookie = match?.[1] || null;
  }
  
  if (!slidecookie) return '';
  
  globalThis._slideCookie = slidecookie;
  return request(url, { 
    method: 'GET',
    headers: { 
      'User-Agent': MOBILE_UA, 
      'Referer': HOST,
      'Cookie': globalThis._slideCookie
    } 
  });
};

var rule = {
  title: '枕榔影视',
  host: 'https://www.zhenlang.cc',
  url: '/vodshow/fyclass--------fypage---.html',
  searchUrl: '/vodsearch/**----------fypage---.html',
  class_parse: '.top_nav li;a&&Text;a&&href;.*/(.*?)\.html',
  cate_exclude: '自助解析|硬核指南|👄Ai女友',
  searchable: 2,
  quickSearch: 0,
  filterable: 0,
  headers: {
    'User-Agent': MOBILE_UA,
  },
  play_parse: true,
  lazy: `js:
    let html = request(input);
    let hconf = html.match(/r player_.*?=(.*?)</);
    if (hconf && hconf[1]) {
      let json = JSON5.parse(hconf[1]);
      let url = json.url;
      if (json.encrypt == '1') {
        url = unescape(url);
      } else if (json.encrypt == '2') {
        url = unescape(base64Decode(url));
      }
      if (/\\.(m3u8|mp4|m4a|mp3)/.test(url)) {
        input = {
          parse: 0,
          jx: 0,
          url: url,
        };
      } else {
        input;
      }
    } else {
      input;
    }
  `,
  limit: 6,
  double: true,
  推荐: '.cbox_list;ul.vodlist li;a&&title;a&&data-original;.pic_text&&Text;a&&href',
  一级二: 'ul.vodlist li;a&&title;a&&data-original;.pic_text&&Text;a&&href',
  一级: $js.toString(() => {
    let html = slideBox(MY_URL);
    if (!html || html.trim() === '') {
      html = request(MY_URL, { 
        method: 'GET',
        headers: { 
          'User-Agent': MOBILE_UA,
          'Cookie': globalThis._slideCookie || ''
        } 
      });
    }
    
    let d = [];
    let p = rule.一级二.split(';');
    let arr = pdfa(html, p[0]);
    if (arr && arr.length > 0) {
      arr.forEach(it => {
        d.push({
          title: pdfh(it, p[1]),
          pic_url: pdfh(it, p[2]),
          desc: pdfh(it, p[3]),
          url: pdfh(it, p[4]),
        });
      });
    }
    setResult(d);
  }),
  二级: {
    title: 'h2&&Text;.content_detail:eq(1)&&li&&a:eq(2)&&Text',
    img: '.vodlist_thumb&&data-original',
    desc: '.content_detail:eq(1)&&li:eq(1)&&Text;.content_detail:eq(1)&&li&&a&&Text;.content_detail:eq(1)&&li&&a:eq(1)&&Text;.content_detail:eq(1)&&li:eq(2)&&Text;.content_detail:eq(1)&&li:eq(3)&&Text',
    content: '.content_desc&&span&&Text',
    tabs: '.play_source_tab&&a',
    tab_text:'a&&alt',
    lists: '.content_playlist:eq(#id) li',
    lists_text:'body&&Text',
  },
  搜索: '*',
}