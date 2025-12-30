import "assets://js/lib/cat.js";
import "assets://js/lib/crypto-js.js";

//https://link3.cc/yyvod

async function init(cfg) {
cfg.skey = '悠悠视频-动态分类';
cfg.stype = '3';
}
let url = 'http://156.225.30.65:8090';
const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.95 Safari/537.36';

//解密
function AES1(data) {
    const key = CryptoJS.enc.Utf8.parse('RuN9LRvwTRgpQnpK');
    const iv = CryptoJS.enc.Utf8.parse('RuN9LRvwTRgpQnpK');
    const decrypted = CryptoJS.AES.decrypt(data, key, {
        iv: iv,
        mode: CryptoJS.mode.CBC,
        padding: CryptoJS.pad.Pkcs7
    });
    return decrypted.toString(CryptoJS.enc.Utf8);
}

//加密
function AES2(data) {
    const key = CryptoJS.enc.Utf8.parse('RuN9LRvwTRgpQnpK');
    const iv = CryptoJS.enc.Utf8.parse('RuN9LRvwTRgpQnpK');
    const encrypted = CryptoJS.AES.encrypt(data, key, {
        iv: iv,
        mode: CryptoJS.mode.CBC,
        padding: CryptoJS.pad.Pkcs7
    });
    return encrypted.toString();
}


async function request (reqUrl, mth) {
  const res = await req (reqUrl, {
    method: mth || 'get',
    headers: {
      'User-Agent': UA,
      referer: url,
    },
    postType: mth === 'post' ? 'form' : '',
  });
  return res.content;
}

//动态分类
async function home (filter) {
let html = await request(`${url}/api.php/getappapi.index/initV119`);
let res = JSON.parse(AES1(JSON.parse(html).data));

//一级
let classes = res.type_list.map(tp => ({
  type_id: tp.type_id,
  type_name: tp.type_name
})).filter(item => item.type_name !== "全部");

//二级
let filterObj = res.type_list.reduce((acc, tp) => {
  if (tp.filter_type_list) {
    acc[tp.type_id] = tp.filter_type_list.map(filter => ({
      key: filter.name,
      name: filter.list[0],
      value: filter.list.map(item => ({
        n: item,
        v: item
      }))
    }));
  }
  return acc;
}, {});

let html2 = await request(`${url}/api.php/getappapi.index/rankListV134?type_id=0&page=1`);
let res2 = JSON.parse(AES1(JSON.parse(html2).data));
//推荐
let videos = res2.rank_list.map(item => ({
    vod_id: item.vod_id,
    vod_name: item.vod_name,
    vod_pic: item.vod_pic,
    vod_remarks: item.vod_remarks,
    vod_year: item.vod_year
}));

return JSON.stringify({
    class: classes,
    filters: filterObj,
    list: videos
});

}


//主页推荐
async function homeVod() {

}

//分类
async function category (tid, pg, filter, extend) {

let html = await request(`${url}/api.php/getappapi.index/typeFilterVodList?area=${extend.area ? extend.area : ''}&year=${extend.year ? extend.year : ''}&type_id=${tid}&page=${pg}&sort=${extend.sort ? extend.sort : ''}&lang=${extend.lang ? extend.lang : ''}&class=${extend.class ? extend.class : ''}`);

let res = JSON.parse(AES1(JSON.parse(html).data)).recommend_list;

let videos = res.map(item => ({
    vod_id: item.vod_id,
    vod_name: item.vod_name,
    vod_pic: item.vod_pic,
    vod_remarks: item.vod_remarks,
    vod_year: ""
}));


  return JSON.stringify ({
    page: pg,
    pagecount: 99999,
    limit: 30,
    total: 99999,
    list: videos
  });
}

//详情
async function detail (id) {
  let html = await request (`${url}/api.php/getappapi.index/vodDetail?vod_id=${id}`);
  let res = JSON.parse(AES1(JSON.parse(html).data));
  
  let play_from = res.vod_play_list.map(item => item.player_info.show).join('$$$');
  let play_url = res.vod_play_list.map(play => {
    let p = play.player_info.parse; // 获取 parse
    return play.urls.map(item => {
        let name = item.name;
        let url = item.url;
        let urls = p 
    ? (p.includes('?url=') || p.includes('?key='))  // 如果 p 包含 '?url=' 或 '?key='
        ? `${p}${url}`  // 直接拼接 p 和 url
        : `${p}|${url}`  // 否则使用 '|' 拼接 p 和 url
    : url;  // 如果 p 不存在，则 urls 为 url

        return `${name}$${urls}`; 
    }).join('#');
}).join('$$$');

var vod = [{
    "type_name": res.vod.vod_class,
    "vod_year": res.vod.vod_year,
    "vod_area": res.vod.vod_area,
    "vod_remarks": res.vod.vod_remarks,
    "vod_content": res.vod.vod_content,
    "vod_play_from": play_from, 
    "vod_play_url": play_url
    }];  

  return JSON.stringify ({
    list: vod
  });
}


//播放
async function play (flag, id, flags) {
//
if (id.indexOf("|") > -1){
  let html = await request (`${url}/api.php/getappapi.index/vodParse?parse_api=${id.split("|")[0]}&url=${encodeURIComponent(AES2(id.split("|")[1]))}`);
  let res = JSON.parse(AES1(JSON.parse(html).data)).json;
  let playUrl = JSON.parse(res).url;
  return JSON.stringify ({
    parse: 0,
    url: playUrl
  });
}
//
if (id.includes(".m3u8")){
let ids = id.includes('?url=') ? id.split("?url=")[1] : id;
return JSON.stringify ({
    parse: 0,
    url: ids
  });
}
//
if (id.includes('?url=') || id.includes('?key=')) {
let html = await request (`${id}`);
let url = JSON.parse(html).url;
return JSON.stringify ({
    parse: 0,
    url: url
  });
}
//
if (id.includes("nkvod.me")){
return JSON.stringify ({
    parse: 1,
    url: id
  });
}
//金牌
if (id.includes("/vod/play/")){
let ids = id.split("/");
let t = Date.now();
let sign = CryptoJS.SHA1(CryptoJS.MD5(`id=${ids[5]}&nid=${ids[7]}&key=cb808529bae6b6be45ecfab29a4889bc&t=${t}`).toString()).toString();
let html = await req(`https://www.cfkj86.com/api/mw-movie/anonymous/v1/video/episode/url?id=${ids[5]}&nid=${ids[7]}`, {
  method: 'GET',
  headers: { 
    'User-Agent': UA,
    'Referer': url,
    "t": t,
    "sign": sign
  },
  postType: '' // 非 POST 请求时设为空
});

  let res = JSON.parse(html.content).data.playUrl

  return JSON.stringify ({
    parse: 0,
    url: res
  });
}


}
//搜索
async function search (wd, quick) {
const html = await request (`${url}/api.php/getappapi.index/searchList?keywords=${wd}&type_id=0&page=1`);

let res = JSON.parse(AES1(JSON.parse(html).data)).search_list;

let videos = res.map(item => ({
    vod_id: item.vod_id,
    vod_name: item.vod_name,
    vod_pic: item.vod_pic,
    vod_remarks: item.vod_remarks,
    vod_year: item.vod_year
}));

  const limit = 20;
  return JSON.stringify ({
    limit: limit,
    list: videos
  });
}

export function __jsEvalReturn() {
  return {
      init: init,
      home: home,
      homeVod: homeVod,
      category: category,
      detail: detail,
      play: play,
      search: search
  };
}