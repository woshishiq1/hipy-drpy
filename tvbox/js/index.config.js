var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// src/index.config.js
var index_config_exports = {};
__export(index_config_exports, {
  default: () => index_config_default
});
module.exports = __toCommonJS(index_config_exports);
var index_config_default = {
  kunyu77: {
    testcfg: {
      bbbb: "aaaaa"
    }
  },
  commonConfig: {
    panOrder: 'uc|p123|quark|ali|ty|115',
  },
  ali: {
    thread: "4",
    chunkSize: "400",
    token: ""
  },
  quark: {
    thread: "6",
    chunkSize: "256",
    //实际为256KB
    cookie: ""
  },
  uc: {
    cookie: "",
    token: "",
    ut:""
  },
  y115: {
    cookie: ""
  },
  tyi: {
    username: "",
    password: ""
  },
  p123: {
    username: "",
    password: ""
  },
  xiaoya: {
    url: "https://tvbox.omii.top/vod1/DixHtoGB"
  },
  yiso: {
    url: "https://yiso.fun",
    cookie: ""
  },
  bili: {
    categories: "经典无损音乐合集#帕梅拉#太极拳#健身#舞蹈#音乐#歌曲#MV4K#演唱会4K#白噪音4K#知名UP主#说案#解说#演讲#时事#探索发现超清#纪录片超清#沙雕动画#沙雕穿越#沙雕#平面设计教学#软件教程#实用教程#旅游#风景4K#食谱#美食超清#搞笑#球星#动物世界超清#相声小品#戏曲#儿童#小姐姐4K#热门#旅行探险",
    cookie: ""
  },
  tgsou: {
    tgPic: false,
    //每个频道返回数量
    count: "4",
    url: 'https://tgsou.651156.xyz',
    channelUsername: "xx123pan,Q66Share,alyp_TV,ucpanpan,ucquark,tianyirigeng,shares_115,cloud189_group,tianyi_pd2,hao115,guaguale115,yunpanchat,ydypzyfx,tgsearchers,NewQuark,Mbox115,dianyingshare,XiangxiuNB,yunpanpan,kuakeyun,Quark_Movies,qixingzhenren,longzbija,alyp_4K_Movies,yunpanshare,shareAliyun,ikiviyyp,alyp_1",
  },
  wogg: {
    url: 'http://woggpan.xxooo.cf',
  },
  tudou: {
    url: "https://tudou.lvdoui.top"
  },
  wobg: {
    url: "https://wobge.run.goorm.io/"
  },
  czzy: {
    url: "https://cz01.vip"
  },
  hezi: {
    url: "https://www.fygame.top/"
  },
  ttkx: {
    url: "http://ttkx.live:7728/"
  },
  cm: {
    url: "https://tv.yydsys.top"
  },
  libvio: {
    url: "https://libvio.app/"
  },
  xxpan: {
    url: "https://xpanpan.site"
  },
  m3u8cj: {
    ykm3u8: [{
      name: "360源",
      url: "https://360zy.com/api.php/seaxml/vod/",
      categories: [],
      search: true
    }],
    doubanm3u8: [{
      name: "豆瓣采集",
      url: "https://caiji.dbzy.tv/api.php/provide/vod/from/dbm3u8/at/josn/",
      categories: [],
      search: true
    }],
    hmm3u8: [{
      name: "黑木耳",
      url: "https://json02.heimuer.xyz/api.php/provide/vod/",
      categories: [],
      search: true
    }],
    clm3u8: [{
      name: "暴风",
      url: "https://bfzyapi.com/api.php/provide/vod/",
      categories: [],
      search: true
    }],
    askm3u8: [{
      name: "魔都",
      url: "https://www.mdzyapi.com/api.php/provide/vod/?ac=list",
      search: true
    }],
    sngm3u8: [{
      name: "ikun",
      url: "https://ikunzyapi.com/api.php/provide/vod/",
      search: true
    }],
    ptm3u8: [{
      name: "非凡",
      url: "http://api.ffzyapi.com/api.php/provide/vod/",
      search: true
    }],
    swm3u8: [{
      name: "量子",
      url: "https://cj.lziapi.com/api.php/provide/vod/",
      categories: [],
      search: true
    }]
  },
  appys: {
    ttmja: [{
      name: "天天美剧",
      url: "https://www.ttmja.com/api.php/app/",
      // categories: ['国产剧', '香港剧', '韩国剧', '欧美剧', '台湾剧', '日本剧', '海外剧', '泰国剧', '短剧', '动作片', '喜剧片', '爱情片', '科幻片', '恐怖片', '剧情片', '战争片', '动漫片', '大陆综艺', '港台综艺', '日韩综艺', '欧美综艺', '国产动漫', '日韩动漫', '欧美动漫', '港台动漫', '海外动漫', '记录片'],                        
      search: true
      //搜索开关 true开 false关
    }],
    netfly: [{
      name: "奈飞",
      url: "http://www.netfly.tv/api.php/app/",
      // categories: ['国产剧', '香港剧', '韩国剧', '欧美剧', '台湾剧', '日本剧', '海外剧', '泰国剧', '短剧', '动作片', '喜剧片', '爱情片', '科幻片', '恐怖片', '剧情片', '战争片', '动漫片', '大陆综艺', '港台综艺', '日韩综艺', '欧美综艺', '国产动漫', '日韩动漫', '欧美动漫', '港台动漫', '海外动漫', '记录片'],                        
      search: true
      //搜索开关 true开 false关
    }]
  },
  alist: [
    {
      "name": "合集",
      "server": "http://www.jczyl.top:5244/"
    },
    {
      "name": "东哥",
      "server": "http://101.34.67.237:5244/"
    },
    {
      "name": "美云",
      "server": "https://h.dfjx.ltd/"
    },
    {
      "name": "小新",
      "server": "https://pan.cdnxin.top/"
    },
    {
      "name": "白云",
      "server": "http://breadmyth.asuscomm.com:22222/"
    },
    {
      "name": "小鸭",
      "server": "http://www.214728327.xyz:5201/"
    },
    {
      "name": "瑶瑶",
      "server": "https://lyly.run.goorm.io/"
    },
    {
      "name": "潇洒",
      "server": "https://alist.azad.asia/"
    },
    {
      "name": "鹏程",
      "server": "https://pan.pengcheng.team/"
    },
    {
      "name": "浅唱",
      "server": "http://vtok.pp.ua/"
    },
    {
      "name": "小丫",
      "server": "http://alist.xiaoya.pro/"
    },
    {
      "name": "触光",
      "server": "https://pan.ichuguang.com"
    },
    {
      "name": "弱水",
      "server": "http://shicheng.wang:555/"
    },
    {
      "name": "神器",
      "server": "https://alist.ygxz.xyz/"
    },
    {
      "name": "资源",
      "server": "https://pan.ecve.cn/"
    },
    {
      "name": "雨呢",
      "server": "https://pan.clun.top/"
    },
    {
      "name": "oeio",
      "server": "https://o.oeio.repl.co/"
    },
    {
      "name": "悦享",
      "server": "https://nics.eu.org/"
    },
    {
      "name": "分享",
      "server": "https://ofoo.ml/"
    },
    {
      "name": "PRO",
      "server": "https://alist.prpr.run/"
    },
    {
      "name": "多多",
      "server": "https://pan.xwbeta.com"
    },
    {
      "name": "小陈",
      "server": "https://ypan.cc/"
    },
    {
      "name": "只鱼",
      "server": "https://alist.youte.ml"
    },
    {
      "name": "七米",
      "server": "https://al.chirmyram.com"
    },
    {
      "name": "九帝",
      "server": "https://alist.shenzjd.com"
    },
    {
      "name": "白雪",
      "server": "https://pan.jlbx.xyz"
    },
    {
      "name": "星梦",
      "server": "https://pan.bashroot.top"
    },
    {
      "name": "repl",
      "server": "https://ali.liucn.repl.co"
    },
    {
      "name": "讯维",
      "server": "https://pan.xwbeta.com"
    }
  ],
  color: [
    {
      light: {
        bg: "https://img.omii.top/i/2024/03/28/mexspg.webp",
        bgMask: "0x50ffffff",
        primary: "0xff446732",
        onPrimary: "0xffffffff",
        primaryContainer: "0xffc5efab",
        onPrimaryContainer: "0xff072100",
        secondary: "0xff55624c",
        onSecondary: "0xffffffff",
        secondaryContainer: "0xffd9e7cb",
        onSecondaryContainer: "0xff131f0d",
        tertiary: "0xff386666",
        onTertiary: "0xffffffff",
        tertiaryContainer: "0xffbbebec",
        onTertiaryContainer: "0xff002020",
        error: "0xffba1a1a",
        onError: "0xffffffff",
        errorContainer: "0xffffdad6",
        onErrorContainer: "0xff410002",
        background: "0xfff8faf0",
        onBackground: "0xff191d16",
        surface: "0xfff8faf0",
        onSurface: "0xff191d16",
        surfaceVariant: "0xffe0e4d6",
        onSurfaceVariant: "0xff191d16",
        inverseSurface: "0xff2e312b",
        inverseOnSurface: "0xfff0f2e7",
        outline: "0xff74796d",
        outlineVariant: "0xffc3c8bb",
        shadow: "0xff000000",
        scrim: "0xff000000",
        inversePrimary: "0xffaad291",
        surfaceTint: "0xff446732"
      },
      dark: {
        bg: "https://img.omii.top/i/2024/03/28/mexyit.webp",
        bgMask: "0x50000000",
        primary: "0xffaad291",
        onPrimary: "0xff173807",
        primaryContainer: "0xff2d4f1c",
        onPrimaryContainer: "0xffc5efab",
        secondary: "0xffbdcbb0",
        onSecondary: "0xff283420",
        secondaryContainer: "0xff3e4a35",
        onSecondaryContainer: "0xffd9e7cb",
        tertiary: "0xffa0cfcf",
        onTertiary: "0xff003738",
        tertiaryContainer: "0xff1e4e4e",
        onTertiaryContainer: "0xffbbebec",
        error: "0xffffb4ab",
        onError: "0xff690005",
        errorContainer: "0xff93000a",
        onErrorContainer: "0xffffdad6",
        background: "0xff11140e",
        onBackground: "0xffe1e4d9",
        surface: "0xff11140e",
        onSurface: "0xffe1e4d9",
        surfaceVariant: "0xff43483e",
        onSurfaceVariant: "0xffe1e4d9",
        inverseSurface: "0xffe1e4d9",
        inverseOnSurface: "0xff2e312b",
        outline: "0xff8d9286",
        outlineVariant: "0xff43483e",
        shadow: "0xff000000",
        scrim: "0xff000000",
        inversePrimary: "0xff446732",
        surfaceTint: "0xffaad291"
      }
    },
    {
      light: {
        "bg": "https://img.omii.top/i/2024/03/27/oudroy-0.webp",
        "bgMask": "0x50ffffff",
        "primary": "0xFFA00B0B",
        "onPrimary": "0xFFFFFFFF",
        "primaryContainer": "0xFF333433",
        "onPrimaryContainer": "0xFFBDC0B0",
        "secondary": "0xFF55624C",
        "onSecondary": "0xFFFFFFFF",
        "secondaryContainer": "0xFFFFEBEE",
        "onSecondaryContainer": "0xFFeb4d4b",
        "tertiary": "0xFF663840",
        "onTertiary": "0xFFFFFFFF",
        "tertiaryContainer": "0xFFEBBBBE",
        "onTertiaryContainer": "0xFF200006",
        "error": "0xFFBA1A1A",
        "onError": "0xFFFFFFFF",
        "errorContainer": "0xFFFFDAD6",
        "onErrorContainer": "0xFF410002",
        "background": "0xFFFDFDF5",
        "onBackground": "0xFFB94242",
        "surface": "0xFFFDFDF5",
        "onSurface": "0xFFB94242",
        "surfaceVariant": "0xFFE4D6D8",
        "onSurfaceVariant": "0xFFB94242",
        "inverseSurface": "0xFF312C2C",
        "onInverseSurface": "0xFFF1F1EA",
        "outline": "0xFF74796D",
        "outlineVariant": "0xFFC3C8BB",
        "shadow": "0xFF000000",
        "scrim": "0xFF000000",
        "inversePrimary": "0xFFff7979",
        "surfaceTint": "0xFFA00B0B"
      },
      dark: {
        "bg": "https://img.omii.top/i/2024/01/25/xdiepq-0.webp",
        "bgMask": "0x50000000",
        "primary": "0xFFff7979",
        "onPrimary": "0xFFA00B0B",
        "primaryContainer": "0xFFeb4d4b",
        "onPrimaryContainer": "0xFFFFCDD2",
        "secondary": "0xFFBDCBAF",
        "onSecondary": "0xFF342023",
        "secondaryContainer": "0xFF4A3536",
        "onSecondaryContainer": "0xFFE7CACE",
        "tertiary": "0xFFA0CFCF",
        "onTertiary": "0xFF003737",
        "tertiaryContainer": "0xFF1E4E4E",
        "onTertiaryContainer": "0xFFBBEBEB",
        "error": "0xFFFFB4AB",
        "errorContainer": "0xFF93000A",
        "onError": "0xFF690005",
        "onErrorContainer": "0xFFFFDAD6",
        "background": "0xFF1C1818",
        "onBackground": "0xFFE3E3DC",
        "outline": "0xFF92868B",
        "onInverseSurface": "0xFF1C1818",
        "inverseSurface": "0xFFE3DCE1",
        "inversePrimary": "0xFFeb4d4b",
        "shadow": "0xFF000000",
        "surfaceTint": "0xFFDA607D",
        "outlineVariant": "0xFF483E41",
        "scrim": "0xFF000000",
        "surface": "0xFF1C1818",
        "onSurface": "0xFFC7C7C0",
        "surfaceVariant": "0xFF43483E",
        "onSurfaceVariant": "0xFFC7C7C0"
      }
    },
    {
      light: {
        bg: "",
        bgMask: "0x50ffffff",
        primary: "0xFF2B6C00",
        onPrimary: "0xFFFFFFFF",
        primaryContainer: "0xFFA6F779",
        onPrimaryContainer: "0xFF082100",
        secondary: "0xFF55624C",
        onSecondary: "0xFFFFFFFF",
        secondaryContainer: "0xFFD9E7CA",
        onSecondaryContainer: "0xFF131F0D",
        tertiary: "0xFF386666",
        onTertiary: "0xFFFFFFFF",
        tertiaryContainer: "0xFFBBEBEB",
        onTertiaryContainer: "0xFF002020",
        error: "0xFFBA1A1A",
        onError: "0xFFFFFFFF",
        errorContainer: "0xFFFFDAD6",
        onErrorContainer: "0xFF410002",
        background: "0xFFFDFDF5",
        onBackground: "0xFF1A1C18",
        surface: "0xFFFDFDF5",
        onSurface: "0xFF1A1C18",
        surfaceVariant: "0xFFE0E4D6",
        onSurfaceVariant: "0xFF1A1C18",
        inverseSurface: "0xFF2F312C",
        onInverseSurface: "0xFFF1F1EA",
        outline: "0xFF74796D",
        outlineVariant: "0xFFC3C8BB",
        shadow: "0xFF000000",
        scrim: "0xFF000000",
        inversePrimary: "0xFF8CDA60",
        surfaceTint: "0xFF2B6C00"
      },
      dark: {
        bg: "",
        bgMask: "0x50000000",
        primary: "0xFF8CDA60",
        onPrimary: "0xFF133800",
        primaryContainer: "0xFF1F5100",
        onPrimaryContainer: "0xFFA6F779",
        secondary: "0xFFBDCBAF",
        onSecondary: "0xFF283420",
        secondaryContainer: "0xFF3E4A35",
        onSecondaryContainer: "0xFFD9E7CA",
        tertiary: "0xFFA0CFCF",
        onTertiary: "0xFF003737",
        tertiaryContainer: "0xFF1E4E4E",
        onTertiaryContainer: "0xFFBBEBEB",
        error: "0xFFFFB4AB",
        errorContainer: "0xFF93000A",
        onError: "0xFF690005",
        onErrorContainer: "0xFFFFDAD6",
        background: "0xFF1A1C18",
        onBackground: "0xFFE3E3DC",
        outline: "0xFF8D9286",
        onInverseSurface: "0xFF1A1C18",
        inverseSurface: "0xFFE3E3DC",
        inversePrimary: "0xFF2B6C00",
        shadow: "0xFF000000",
        surfaceTint: "0xFF8CDA60",
        outlineVariant: "0xFF43483E",
        scrim: "0xFF000000",
        surface: "0xFF1A1C18",
        onSurface: "0xFFC7C7C0",
        surfaceVariant: "0xFF43483E",
        onSurfaceVariant: "0xFFC7C7C0"
      }
    }
  ]
};
