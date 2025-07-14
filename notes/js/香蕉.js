import {load, _} from 'assets://js/lib/cat.js';


async function init(cfg) {
cfg.skey = '香蕉';
cfg.stype = '3';
}
let url = 'https://cwt98ehs.cqict.cn';
const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.95 Safari/537.36';

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



async function home (filter) {
  let classes = [
    {
      type_id: '4',
      type_name: '偷拍',
    },
    {
      type_id: '5',
      type_name: '制服',
    },
    {
      type_id: '6',
      type_name: '青纯',
    },
    {
      type_id: '7',
      type_name: '巨乳',
    },
    {
      type_id: '8',
      type_name: '女同',
    },
    {
      type_id: '9',
      type_name: '素人',
    },
    {
      type_id: '10',
      type_name: '角色',
    },
    {
      type_id: '11',
      type_name: '动漫',
    },
    {
      type_id: '12',
      type_name: '人妻',
    },
    {
      type_id: '13',
      type_name: '另类',
    },
    {
      type_id: '14',
      type_name: '伦理',
    },
  ];
  let filterObj = {};
  return JSON.stringify({
    class: classes,
    filters: filterObj,
  });
}

async function homeVod() {
let html = await request(`${url}/vod/listing-0-0-0-0-0-0-0-0-0-1`);
let res = JSON.parse(html);
let videos = [];
if (res.data && res.data.vodrows) {
    videos = res.data.vodrows
        .filter(item => item.isvip !== "1")  // 新增过滤条件
        .map(item => ({
            vod_id: item.vodid,
            vod_name: item.title,
            vod_pic: item.coverpic,
            vod_remarks: item.duration,
            vod_content: item.intro,
            vod_year: item.yearname
        }));
}

return JSON.stringify({
    list: videos,
});
}

async function category (tid, pg, filter, extend) {
  let reqUrl = `${url}/vod/listing-${tid}-0-0-0-0-0-0-0-0-${pg}`;
  let html = await request (reqUrl);
let res = JSON.parse(html);
let videos = [];
if (res.data && res.data.vodrows) {
    videos = res.data.vodrows
        .filter(item => item.isvip !== "1")  // 新增过滤条件
        .map(item => ({
            vod_id: item.vodid,
            vod_name: item.title,
            vod_pic: item.coverpic,
            vod_remarks: item.duration,
            vod_content: item.intro,
            vod_year: item.yearname
        }));
}


  return JSON.stringify ({
    page: 1,
    pagecount: 999,
    limit: 24,
    total: 999,
    list: videos,
  });
}

async function detail (id) {
  const detailUrl = `${url}/vod/reqplay/${id}`;
  let detail = await request (detailUrl, 'get');
  let res = JSON.parse(detail);
  var vod = {
    vod_id: id,
    vod_play_from: res.errmsg,
    vod_play_url: res.data.httpurl !== undefined ? res.data.httpurl : res.data.httpurl_preview,
  };

  return JSON.stringify ({
    list: [vod],
  });
}

async function play (flag, id, flags) {

  const playUrl = id;
  return JSON.stringify ({
    parse: 0,
    url: playUrl,
  });
}

async function search (wd, quick) {
  const html = await request (`${url}/search?page=1&wd=${wd}`);
  let res = JSON.parse(html);
  let videos = [];
if (res.data && res.data.vodrows) {
    videos = res.data.vodrows
        .filter(item => item.isvip !== "1")  // 新增过滤条件
        .map(item => ({
            vod_id: item.vodid,
            vod_name: item.title,
            vod_pic: item.coverpic,
            vod_remarks: item.duration,
            vod_content: item.intro,
            vod_year: item.yearname
        }));
}

  const limit = 24;
  return JSON.stringify ({
    limit: limit,
    list: videos,
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
      search: search,
  };
}