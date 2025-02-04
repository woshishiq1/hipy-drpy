var rule={
  title: "剧狗狗",
  host: "https://www.jugougou.me",
  url: "/vodtype/fyclass-fypage.html",
  searchUrl: "/vodsearch/**----------fypage---.html",
  searchable: 2,
  quickSearch: 0,
  filterable: 1,
  filter: "",
  filter_url: "",
  filter_def: "",
  headers: {
    "User-Agent": "MOBILE_UA"
  },
  timeout: 5000,
  class_parse: ".foornav li;a&&Text;a&&href;/(\\d+)\\.html",
  cate_exclude: "Netflix|今日更新|专题列表|排行榜",
  play_parse: true,
  lazy: $js.toString(() => {
		var html = JSON.parse(request(input).match(/r player_.*?=(.*?)</)[1]);
  var url = html.url;
  if (html.encrypt == '1') {
    url = unescape(url);
  } else if (html.encrypt == '2') {
    url = unescape(base64Decode(url));
  }
    if (/m3u8/.test(url)) {
         input = {
				jx: 0,
				url: url,
				parse: 0,
			}
    }else{
 /* eval(request(HOST + '/static/js/playerconfig.js'));
  var jx = MacPlayerConfig.player_list[html.from].parse;
  if (jx == '') {
    jx = MacPlayerConfig.parse;
  }*/
  
     let config = {};
   let code=request(HOST + '/static/js/playerconfig.js');
   
       eval(code + '\nconfig=MacPlayerConfig;');
        let jx = HOST+config.player_list[html.from].parse;
        if (jx == '') {
            jx = HOST+config.parse
        }
    var deString = (_0x1fa139) => {
      function _0x47b765(a, b, url) {
        var code = '',
          url = url.split(''),
          indexOfVal = (a, b) => {
            for (var i = 0; i < a.length; i++) {
              if (b === a[i]) {
                return true;
              }
            }
            return false;
          };
        for (var i = 0; i < url.length; i++) {
          var _0x3797f4 = /^[a-zA-Z]+$/.test(url[i]);
          if (_0x3797f4 && indexOfVal(b, url[i])) {
            code += b[a.indexOf(url[i])];
          } else {
            code += url[i];
          }
        }
        return code;
      }
      function _0x241571(_0x518f7a) {
        key = md5('test');
        _0x518f7a = atob(_0x518f7a);
        len = key.length;
        code = '';
        for (i = 0; i < _0x518f7a.length; i++) {
          k = i % len;
          code += String.fromCharCode(_0x518f7a.charCodeAt(i) ^ key.charCodeAt(k));
        }
        return atob(code);
      }
      var _0x1fa139 = _0x241571(_0x1fa139);
      var _0x17bd14 = _0x1fa139.split('/');
      var _0xaefa58 = '';
      for (var _0x2d9357 = 0; _0x2d9357 < _0x17bd14.length; _0x2d9357++) {
        var _0x501b5f = _0x2d9357 + 1 == _0x17bd14.length ? '' : '/';
        if (_0x2d9357 == 0 || _0x2d9357 == 1) {
        } else {
          _0xaefa58 += _0x17bd14[_0x2d9357] + _0x501b5f;
        }
      }
      var _0x28094f = atob(_0xaefa58);
      var _0x72d7e1 = _0x47b765(
        JSON.parse(atob(_0x17bd14[1])),
        JSON.parse(atob(_0x17bd14[0])),
        _0x28094f
      );
      return _0x72d7e1;
    };
    let vid='vid='+url

    let u=JSON.parse(request(jx.replace('index.php?vid=', 'api.php'), {
         body: vid,
         method: 'POST',
         headers: {
        'Referer': ''
    }
        })).data.url
       log(u)
       
       let play=deString(u)
        
        input = {
				jx: 0,
				url: play,
				parse: 0,
			}
		}
	}),
  
  double: false,
  推荐: "*",
  一级: ".ewave-vodlist__item;a&&title;a&&data-original;.pic-text&&Text;a&&href",
  二级: {
    title: ".ewave-content__detail&&.title&&Text;.data:eq(0)&&Text",
    img: ".pic&&img&&data-original",
    desc: ".data:eq(5)&&Text;.data:eq(3)&&Text;.data:eq(2)&&Text;;",
    content: ".art-content&&Text",
    tabs: ".ewave-pannel:has(.ewave-content__playlist)",
    lists: ".ewave-content__playlist:eq(#id)&&li",
    tab_text: "h3&&Text",
    list_text: "body&&Text",
    list_url: "a&&href"
  },
  detailUrl: "",
  搜索: "*"
}