/*
 *  酷我听书（💎 VIP解析版） - TVBox T4 接口插件
 * 
 * 站点地址：http://tingshu.kuwo.cn
 * 功能特性：
 *   - 首页推荐：有声小说/音乐金曲/相声评书/影视原声
 *   - 听书详情：专辑信息、作者、播放量
 *   - 播放列表：章节列表、音频直链
 *   - 搜索功能：支持关键词搜索
 *   - 分类浏览：自动翻页，优化排序筛选
 *   - 付费解析：支持VIP内容解析
 * 
 * ⚠️ 内置公益解析接口，谨慎使用，勿广泛传播或商用。
 *  
 * 修改时间：2026-03-07
 * 
 */

const axios = require("axios");
const http = require("http");
const https = require("https");

let log = console;

/* ===============================
   源配置 - 酷我听书
=============================== */

const SOURCE_CONFIG = {
  name: "酷我听书",
  url: "http://tingshu.kuwo.cn",
  searchHost: "http://search.kuwo.cn",
  playHost: "http://mobi.kuwo.cn",
  parseApi: "https://music-api.gdstudio.xyz/api.php",
  ua: "MOBILE_UA",
  headers: {
    "User-Agent": "kwplayer_ar_9.1.8.1_tvivo.apk"
  },
  categories: {
    class_names: "有声小说&音乐金曲&相声评书&影视原声",
    class_ids: "2&37&5&62",
    forcePage: {
      enabled: true,
      maxPage: 10,
      pageSize: 21
    },
    filters: {
      "2": [
        {"key":"class","name":"类型","init":"42","value":[
          {"n":"都市传说","v":"42"},{"n":"玄幻奇幻","v":"44"},{"n":"武侠仙侠","v":"48"},{"n":"穿越架空","v":"52"},{"n":"科幻竞技","v":"57"},{"n":"幻想言情","v":"169"},{"n":"独家定制","v":"170"},{"n":"古代言情","v":"207"},{"n":"影视原著","v":"213"},{"n":"悬疑推理","v":"45"},{"n":"历史军事","v":"56"},{"n":"现代言情","v":"41"},{"n":"青春校园","v":"55"},{"n":"文学名著","v":"61"}
        ]}
      ],
      "5": [
        {"key":"class","name":"类型","init":"220","value":[
          {"n":"评书大全","v":"220"},{"n":"小品合辑","v":"221"},{"n":"单口相声","v":"219"},{"n":"热门相声","v":"218"},{"n":"相声名家","v":"290"},{"n":"粤语评书","v":"320"},{"n":"相声新人","v":"222"},{"n":"张少佐","v":"313"},{"n":"刘立福","v":"314"},{"n":"刘兰芳","v":"309"},{"n":"连丽如","v":"311"},{"n":"田占义","v":"317"},{"n":"袁阔成","v":"310"},{"n":"孙一","v":"315"},{"n":"王玥波","v":"316"},{"n":"单田芳","v":"217"},{"n":"关永超","v":"325"},{"n":"马长辉","v":"326"},{"n":"赵维莉","v":"327"},{"n":"潮剧","v":"1718"},{"n":"沪剧","v":"1719"},{"n":"晋剧","v":"1720"}
        ]}
      ],
      "37": [
        {"key":"class","name":"类型","init":"253","value":[
          {"n":"抖音神曲","v":"253"},{"n":"怀旧老歌","v":"252"},{"n":"创作翻唱","v":"248"},{"n":"催眠","v":"254"},{"n":"古风","v":"255"},{"n":"博客周刊","v":"1423"},{"n":"民谣","v":"1409"},{"n":"纯音乐","v":"1408"},{"n":"3D电音","v":"1407"},{"n":"音乐课程","v":"1380"},{"n":"音乐推荐","v":"250"},{"n":"音乐故事","v":"247"},{"n":"情感推荐","v":"246"},{"n":"儿童音乐","v":"249"}
        ]}
      ],
      "62": [
        {"key":"class","name":"类型","init":"1485","value":[
          {"n":"影视广播","v":"1485"},{"n":"影视解读","v":"1483"},{"n":"影视原著","v":"1486"},{"n":"陪你追剧","v":"1398"},{"n":"经典原声","v":"1482"}
        ]}
      ]
    },
    vipFilter: {
      "key": "vip",
      "name": "权限",
      "init": "",
      "value": [
        {"n": "全部权限", "v": ""},
        {"n": "免费权限", "v": "0"},
        {"n": "会员权限", "v": "1"}
      ]
    },
    sortFilter: {
      "key": "sort",
      "name": "排序",
      "init": "tsScore",
      "value": [
        {"n": "综合排序", "v": "tsScore"},
        {"n": "最新上架", "v": "pubDate"},
        {"n": "按总播放", "v": "playCnt"}
      ]
    }
  }
};

let API_HOST = "";
let SEARCH_HOST = "";
let PLAY_HOST = "";
let PARSE_API = "";
let USER_AGENT = "";
let IS_INITED = false;
let CATEGORY_CONFIG = {};

const _http = axios.create({
  timeout: 10000,
  httpsAgent: new https.Agent({ rejectUnauthorized: false }),
  httpAgent: new http.Agent({ keepAlive: true })
});

async function initSource() {
  if (IS_INITED) return;
  const cfg = SOURCE_CONFIG;
  API_HOST = cfg.url.trim();
  SEARCH_HOST = cfg.searchHost.trim();
  PLAY_HOST = cfg.playHost.trim();
  PARSE_API = cfg.parseApi.trim();
  USER_AGENT = cfg.ua || "MOBILE_UA";
  CATEGORY_CONFIG = {
    class_names: cfg.categories.class_names.split("&"),
    class_ids: cfg.categories.class_ids.split("&"),
    forcePage: cfg.categories.forcePage,
    filters: cfg.categories.filters,
    vipFilter: cfg.categories.vipFilter,
    sortFilter: cfg.categories.sortFilter
  };
  IS_INITED = true;
}

async function apiGet(url, host = null, customHeaders = {}) {
  try {
    const baseHost = host || API_HOST;
    const fullUrl = url.startsWith("http") ? url : `${baseHost}${url}`;
    const headers = { 
      "User-Agent": USER_AGENT,
      "Referer": baseHost,
      ...customHeaders
    };
    const res = await _http.get(fullUrl, {
      headers: headers,
      timeout: 10000,
      responseType: 'text'
    });

    let data = res.data;

    if (host === SEARCH_HOST && typeof data === 'string') {
      try {
        const fixedJson = data.replace(/'/g, '"');
        data = JSON.parse(fixedJson);
      } catch (e) {
        return null;
      }
    } else if (typeof data === 'string') {
      try {
        data = JSON.parse(data);
      } catch {}
    }

    return data;
  } catch (e) {
    return null;
  }
}

function formatPlayCnt(cnt) {
  if (!cnt) return "0";
  if (cnt >= 100000000) return (cnt / 100000000).toFixed(1) + "亿";
  if (cnt >= 10000) return (cnt / 10000).toFixed(1) + "万";
  return cnt.toString();
}

function mapItemToVod(item, categoryName) {
  const vipTag = item.vip === 1 || item.vip === "1" ? "会员" : "免费";
  const playCntStr = formatPlayCnt(item.playCnt);
  return {
    vod_id: item.albumId,
    vod_name: item.albumName,
    vod_pic: item.coverImg,
    vod_remarks: `${vipTag} | ${playCntStr}次播放 | ${categoryName || item.artist || ''}`.trim()
  };
}

function isPaidContent(track) {
  try {
    return track?.payInfo?.feeType?.bookvip === "1" || track?.payInfo?.feeType?.bookvip === 1;
  } catch (e) {
    return false;
  }
}

async function getHome(page = 1) {
  await initSource();
  const { class_ids, class_names, filters } = CATEGORY_CONFIG;
  const allItems = [];

  for (let i = 0; i < class_ids.length; i++) {
    try {
      const typeId = class_ids[i];
      const filterConfig = filters[typeId];
      const defaultClass = filterConfig && filterConfig[0] ? filterConfig[0].init : "44";
      const url = `/v2/api/search/filter/albums?classifyId=${defaultClass}&notrace=0&source=kwplayer_ar_9.1.8.1_tvivo.apk&platform=1&uid=2511482006&sortType=tsScore&loginUid=540339516&bksource=kwbook_ar_9.1.8.1_tvivo.apk&rn=12&categoryId=${typeId}&pn=${page}`;
      const data = await apiGet(url);
      if (data?.data?.data) {
        data.data.data.forEach(item => {
          item.category_name = class_names[i];
          allItems.push(item);
        });
      }
    } catch (e) {}
  }

  return allItems.map(item => mapItemToVod(item, item.category_name));
}

async function searchContent(keyword, page = 1) {
  await initSource();
  const pn = page - 1;
  const searchUrl = `${SEARCH_HOST}/r.s?client=kt&all=${encodeURIComponent(keyword)}&ft=album&newsearch=1&itemset=web_2013&cluster=0&pn=${pn}&rn=21&rformat=json&encoding=utf8&show_copyright_off=1&vipver=MUSIC_8.0.3.0_BCS75&show_series_listen=1&version=9.1.8.1`;

  try {
    const data = await apiGet(searchUrl, SEARCH_HOST);
    if (!data?.albumlist) {
      return { list: [], page, pagecount: 1, limit: 21, total: 0 };
    }

    const list = data.albumlist.map(item => {
      const vipTag = item.vip === 1 || item.vip === "1" ? "会员" : "免费";
      return {
        vod_id: item.DC_TARGETID,
        vod_name: item.name,
        vod_pic: item.img,
        vod_remarks: `${vipTag} | ${item.artist || ''}`.trim()
      };
    });

    const total = data.TOTAL || list.length;
    const pagecount = Math.ceil(total / 21);

    return {
      list,
      page,
      pagecount: pagecount > 100 ? 100 : pagecount,
      limit: 21,
      total: total
    };
  } catch (e) {
    return { list: [], page, pagecount: 1, limit: 21, total: 0 };
  }
}

async function getDetail(id) {
  await initSource();
  const detailUrl = `${SEARCH_HOST}/r.s?stype=albuminfo&user=8d378d72qw28f5f4&uid=2511552006&loginUid=540129516&loginSid=958467960&prod=kwplayer_ar_9.1.8.1&bkprod=kwbook_ar_9.1.8.1&source=kwplayer_ar_9.1.8.1_tvivo.apk&bksource=kwbook_ar_9.1.8.1_tvivo.apk&corp=kuwo&albumid=${id}&pn=0&rn=5000&show_copyright_off=1&vipver=MUSIC_8.2.0.0_BCS17&mobi=1&iskwbook=1`;
  
  try {
    const data = await apiGet(detailUrl, SEARCH_HOST);
    if (!data || !data.musiclist || data.musiclist.length === 0) {
      return null;
    }

    const musicList = data.musiclist;
    const playlists = [];

    for (let i = 0; i < musicList.length; i++) {
      const track = musicList[i];
      const isVip = isPaidContent(track);
      const trackName = track.name || `第${i + 1}集`;
      
      let playUrl;
      if (isVip) {
        playUrl = `${PARSE_API}?use_xbridge3=true&loader_name=forest&need_sec_link=1&sec_link_scene=im&theme=light&types=url&source=kuwo&id=${track.musicrid}&br=1`;
      } else {
        playUrl = `${PLAY_HOST}/mobi.s?f=web&source=kwplayerhd_ar_4.3.0.8_tianbao_T1A_qirui.apk&type=convert_url_with_sign&rid=${track.musicrid}&br=320kmp3`;
      }
      
      const displayName = isVip ? `💎${trackName}` : trackName;
      playlists.push(`${i + 1}.${displayName}$${playUrl}`);
    }

    // 根级别字段直接映射（根据抓包数据结构）
    const isVipAlbum = data.vip === "1" || data.vip === 1;
    const vipTag = isVipAlbum ? "会员" : "免费";
    const finishedTag = data.finished === "1" ? "已完结" : "连载中";
    
    // 构建图片URL（优先使用img字段，需要补全完整URL）
    let picUrl = data.img || "";
    if (picUrl && !picUrl.startsWith("http")) {
      picUrl = `http://img3.sycdn.kuwo.cn/star/albumcover/240/${picUrl}`;
    }
    
    // 计算总播放量（累加所有track的playcnt）
    let totalPlayCnt = 0;
    musicList.forEach(track => {
      totalPlayCnt += parseInt(track.playcnt || 0);
    });

    return {
      vod_id: id,
      vod_name: data.name || "未知专辑",
      vod_pic: picUrl,
      vod_remarks: `${vipTag} | ${finishedTag} | 共${data.songnum || musicList.length}集 | ${formatPlayCnt(totalPlayCnt)}播放`,
      
      // 详细内容 - 根级别info字段
      vod_content: data.info || data.title || "暂无简介",
      
      // 演员/播音 - 根级别artist
      vod_actor: data.artist || "未知",
      
      // 导演/制作方 - 根级别company
      vod_director: data.company || "未知制作方",
      
      // 年份 - 根级别pub
      vod_year: data.pub ? data.pub.split("-")[0] + "年" : "",
      
      // 地区/语言 - 根级别lang
      vod_area: data.lang || "国语",
      vod_lang: data.lang || "普通话",
      
      // 更新时间 - 根级别pub
      vod_time: data.pub || "",
      
      // 标签（完结状态）
      vod_tag: data.finished === "1" ? "完结" : "连载",
      
      // 播放信息
      vod_play_from: "kuwo",
      vod_play_url: playlists.join("#")
    };

  } catch (e) {
    return null;
  }
}

async function fetchWithForcePage(typeId, classifyId, sortType, vipFilterValue, targetPage) {
  const { forcePage, class_names } = CATEGORY_CONFIG;
  const categoryName = class_names[CATEGORY_CONFIG.class_ids.indexOf(typeId)] || "";

  let currentPage = targetPage;
  let attempts = 0;
  const maxAttempts = forcePage.maxPage;

  while (attempts < maxAttempts) {
    const url = `/v2/api/search/filter/albums?classifyId=${classifyId}&notrace=0&source=kwplayer_ar_9.1.8.1_tvivo.apk&platform=1&uid=2511482006&sortType=${sortType}&loginUid=540339516&bksource=kwbook_ar_9.1.8.1_tvivo.apk&rn=${forcePage.pageSize}&categoryId=${typeId}&pn=${currentPage}`;

    const data = await apiGet(url);

    if (!data?.data?.data || data.data.data.length === 0) {
      attempts++;
      currentPage++;
      continue;
    }

    let items = data.data.data;

    if (vipFilterValue !== undefined && vipFilterValue !== null && vipFilterValue !== "") {
      const vipValue = parseInt(vipFilterValue);
      items = items.filter(item => item.vip === vipValue);
    }

    if (items.length > 0 || vipFilterValue === "") {
      return {
        items: items.map(item => mapItemToVod(item, categoryName)),
        actualPage: currentPage,
        hasMore: data.data.data.length >= forcePage.pageSize
      };
    }

    attempts++;
    currentPage++;
  }

  return {
    items: [],
    actualPage: currentPage,
    hasMore: false
  };
}

async function getCategory(typeId, page = 1, filters = {}) {
  await initSource();

  const { class_ids, class_names, filters: filterConfig, vipFilter, sortFilter } = CATEGORY_CONFIG;
  const categoryIndex = class_ids.indexOf(typeId);

  if (categoryIndex === -1) {
    return { list: [], page, pagecount: 1, limit: 21, total: 0 };
  }

  const currentFilter = filterConfig[typeId];
  const defaultClass = currentFilter && currentFilter[0] ? currentFilter[0].init : "44";
  const defaultVip = vipFilter ? vipFilter.init : "";
  const defaultSort = sortFilter ? sortFilter.init : "tsScore";
  const classifyId = filters.class || defaultClass;
  const vipFilterValue = filters.vip !== undefined ? filters.vip : defaultVip;
  const sortType = filters.sort || defaultSort;
  const result = await fetchWithForcePage(typeId, classifyId, sortType, vipFilterValue, page);

  return {
    list: result.items,
    page: page,
    pagecount: result.hasMore ? 9999 : page,
    limit: 21,
    total: result.hasMore ? 999999 : result.items.length
  };
}

async function getPlay(playStr) {
  try {
    if (playStr.includes('music-api.gdstudio.xyz')) {
      const customHeaders = {
        'User-Agent': 'LX-Music-Mobile',
        'Accept': 'application/json',
        'Host': 'music-api.gdstudio.xyz'
      };
      
      const data = await apiGet(playStr, null, customHeaders);
      
      if (data?.url) {
        return {
          parse: 0,
          url: data.url,
          header: {
            'User-Agent': 'LX-Music-Mobile',
            'Referer': 'https://music-api.gdstudio.xyz'
          }
        };
      }
    } else {
      const data = await apiGet(playStr, PLAY_HOST);
      
      if (data?.data?.url) {
        return {
          parse: 0,
          url: data.data.url,
          header: {
            'User-Agent': USER_AGENT,
            'Referer': API_HOST
          }
        };
      }

      if (typeof data === 'string' && data.startsWith('http')) {
        return {
          parse: 0,
          url: data,
          header: {
            'User-Agent': USER_AGENT,
            'Referer': API_HOST
          }
        };
      }
    }

    return {
      parse: 0,
      url: playStr,
      header: {
        'User-Agent': USER_AGENT
      }
    };
    
  } catch (e) {
    return {
      parse: 0,
      url: playStr,
      header: {
        'User-Agent': USER_AGENT
      }
    };
  }
}

const META = {
  key: "KuWoTS",
  name: SOURCE_CONFIG.name,
  type: 4,
  api: "/video/KuWoTS",
  searchable: 2,
  quickSearch: 0,
  filterable: 1
};

module.exports = async (app, opt) => {
  log = app.log;

  app.get(META.api, async (req) => {
    try {
      await initSource();

      const { ids, play, wd, t, pg, ext } = req.query;
      const page = parseInt(pg) || 1;

      if (play) {
        return await getPlay(play);
      }

      if (ids) {
        const detail = await getDetail(ids);
        return { list: detail ? [detail] : [] };
      }

      if (wd) {
        return await searchContent(wd, page);
      }

      if (t) {
        let filters = {};
        if (ext) {
          try {
            filters = JSON.parse(Buffer.from(ext, 'base64').toString());
          } catch {}
        }
        return await getCategory(t, page, filters);
      }

      const { class_ids, class_names, filters, vipFilter, sortFilter } = CATEGORY_CONFIG;

      const classes = [];
      for (let i = 0; i < class_ids.length; i++) {
        classes.push({
          type_id: class_ids[i],
          type_name: class_names[i]
        });
      }

      const filterObj = {};
      class_ids.forEach(id => {
        filterObj[id] = [];
        if (filters[id]) {
          filterObj[id].push(...filters[id]);
        }
        if (vipFilter) {
          filterObj[id].push(vipFilter);
        }
        if (sortFilter) {
          filterObj[id].push(sortFilter);
        }
      });

      const homeList = await getHome(1);

      return {
        class: classes,
        filters: filterObj,
        list: homeList
      };

    } catch (e) {
      return { error: e.message };
    }
  });

  opt.sites.push(META);
};

module.exports.META = META;