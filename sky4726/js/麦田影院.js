/*
@header({
  searchable: 2,
  filterable: 0,
  quickSearch: 0,
  title: '麦田影院',
  lang: 'ds'
})
*/

var rule = {
  类型: '影视',
  title: '麦田影院',
  desc: '源动力出品',
  host: 'https://www.mtyy1.com',
  url: '/vodtype/fyclass-fypage.html',
  searchUrl: '/vodsearch/**----------fypage---.html',
  searchable: 2,
  quickSearch: 0,
  timeout: 5000,
  play_parse: true,
  filterable: 0,
  class_name: '电视剧&电影&综艺&动漫&短剧&纪录片',
  class_url: '1&2&3&4&5&6',
  预处理: async () => {
    return []
  },
  推荐: async function (tid, pg, filter, extend) {
    const { input, pdfa, pdfh, pd } = this;
    const html = await request(input);
    const d = [];
    const data = pdfa(html, '.box-width .public-list-box');

    data.forEach((it) => {
      d.push({
        title: pdfh(it, '.public-list-div a&&title'),
        pic_url: pdfh(it, '.public-list-div img&&data-src'),
        desc: pdfh(it, '.public-list-div .public-list-prb&&Text'),
        url: pdfh(it, '.public-list-div a&&href'),
      })
    });
    return setResult(d);
  },
  一级: async function (tid, pg, filter, extend) {
    const { input, pdfa, pdfh, pd } = this;
    const html = await request(input);
    const d = [];
    const data = pdfa(html, '.flex.wrap.border-box.public-r .public-list-box');

    data.forEach((it) => {
      d.push({
        title: pdfh(it, '.public-list-button a.time-title&&Text'),
        pic_url: pdfh(it, '.public-list-bj img&&data-src'),
        desc: pdfh(it, '.public-list-bj .public-list-prb&&Text'),
        url: pdfh(it, '.public-list-button a.time-title&&href'),
      })
    });
    return setResult(d);
  },
  二级: async function (ids) {
    const { input, pdfa, pdfh, pd } = this;
    const html = await request(`${rule.host}${ids[0]}`);
    const vod = {
      vod_id: ids[0],
      vod_name: pdfh(html, '.slide-desc-box .this-desc-title&&Text'),
      vod_content: pdfh(html, '.slide-desc-box .this-desc .text&&Text'),
    };

    let playFroms = [];
    let playUrls = [];
  
    const playList = pdfa(html, '.vod-detail .anthology-tab .swiper-wrapper a');
    playList.forEach((it) => {
      playFroms.push(pdfh(it, 'a:not([strong])&&Text'));
    });
  
    const indexList = pdfa(html, '.vod-detail .anthology-list .anthology-list-box');
    indexList.forEach((lines) => {
      const tmpUrls = [];
      const line = pdfa(lines, 'ul li');
      line.forEach((play) => {
        const index = pdfh(play, 'a&&Text');
        const url = pdfh(play, 'a&&href');
        tmpUrls.push(`${index}$${url}`);
      });
      playUrls.push(tmpUrls.join('#'));
    });

    vod.vod_play_from = playFroms.join('$$$');
    vod.vod_play_url = playUrls.join('$$$');

    return vod;
  },
  搜索: async function (wd, quick, pg) {
    const { input, pdfa, pdfh, pd } = this;
    const html = await request(input);
    const d = [];
    const data = pdfa(html, '.flex.wrap.border-box.public-r .public-list-box');

    data.forEach((it) => {
      d.push({
        title: pdfh(it, '.public-list-button a.time-title&&Text'),
        pic_url: pdfh(it, '.public-list-bj img&&data-src'),
        desc: pdfh(it, '.public-list-bj .public-list-prb&&Text'),
        url: pdfh(it, '.public-list-button a.time-title&&href'),
      })
    });
    return setResult(d);
  },
  lazy: async function (flag, id, flags) {
    const { input, pdfa, pdfh, pd } = this;
    let url = `${rule.host}${id}`;
    const html = await request(url);
    const script = pdfa(html, '.player-top script');
    const scriptContent = script.filter((e) => e.includes("player_aaaa"))[0];

    const scriptRegex = /var player_aaaa=({[^;]+})/;
    const match = scriptContent.match(scriptRegex);
    console.warn(match)
    if (match && match[1]) {
      try {
        const matchStr = match[1];
        const matchJson = JSON.parse(matchStr);
        url = matchJson.url;
      } catch (err) { }
    };

    if (/m3u8|mp4|flv/.test(url)) {
      return { parse: 0, url }
    } else {
      return { parse: 1, url }
    }
  }
}