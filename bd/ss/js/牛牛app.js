//全局函数，AES解密
globalThis.AESJieMi = function (data, url) {
    data = data.replace(/^\uFEFF/,'');
    let key = /main/.test(url)? '/main00000000000' : '/'+url.split('/')[3].slice(0,15);
    key = CryptoJS.enc.Utf8.parse(key);
    const decrypted = CryptoJS.AES.decrypt(data, key, {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.Pkcs7
    });
    return decrypted.toString(CryptoJS.enc.Utf8)
};
//drpy2主体rule对象
var rule = {
title: '牛牛app',
host: 'https://ccc.chaojichaojichanga.com:35620',
hostJs: '',
headers: {'User-Agent': MOBILE_UA},
编码: 'utf-8',
timeout: 5000,

homeUrl: '/main',
url: '/list?fyfilter',
filter_url: 'wd=&order={{fl.by}}&type_id=fyclass&class={{fl.class}}&area={{fl.area}}&year={{fl.year}}&state={{fl.state}}&page=fypage',
searchUrl: '/list?order=&wd=**&page=fypage',
detailUrl: '/detail?vod_id=fyid',

limit: 9,
double: false,
class_name: '短剧&电视剧&电影&动漫&综艺&福利&麻豆&吃瓜&午夜&热舞&直播',
class_url: '5&2&1&4&3&6&7&8&9&10&11',
filter_def: {},

推荐: $js.toString(() => {
let khtml = fetch(input);
let kjson = JSON.parse(AESJieMi(khtml, input));
VODS = [];
kjson.data.forEach((item) => { 
    if (Array.isArray(item.list) && item.list.length !== 0) { VODS = VODS.concat(item.list) }
})
}),
一级: $js.toString(() => {
let khtml = fetch(input);
let kjson = JSON.parse(AESJieMi(khtml, input));
VODS = kjson.data
}),
搜索: '*',
二级: $js.toString(() => {
let khtml = fetch(input);
let kjson = JSON.parse(AESJieMi(khtml, input));
let kvod = kjson.data;
let ktabs = kvod.sources.map((it) => { return '' + it.player_id });
let kurls = kvod.sources.map((item) => {
    let kurl = item.episodes.map((it) => { return `${it.name}$${it.url}@${item.player_id}` });
    return kurl.join('#')
});
VOD = {
    vod_id: kvod.vod_id,
    vod_name: kvod.vod_name,
    vod_pic: kvod.vod_pic,
    type_name: kvod.vod_class,
    vod_remarks: kvod.vod_remarks,
    vod_year: kvod.vod_year,
    vod_area: kvod.vod_area,
    vod_lang: kvod.vod_lang,
    vod_director: kvod.vod_director,
    vod_actor: kvod.vod_actor,
    vod_content: kvod.vod_content,
    vod_play_from: ktabs.join('$$$'),
    vod_play_url: kurls.join('$$$')
}
}),

tab_remove: ['xm3u8'],
play_parse: true,
lazy: $js.toString(() => {
let kurl = input.split('@')[0];
let ktab = input.split('@')[1];
if (/\.m3u8/.test(kurl)) {
    input = { jx: 0, parse: 0, url: kurl, header: rule.headers }
} else if (/hm3u8/.test(ktab)) {
        kurl = `http://82.156.24.206:12345/jx/jx.php?url=${kurl}`;
    kurl = JSON.parse(fetch(kurl)).url;
    input = { jx: 0, parse: 0, url: kurl }
} else if (/qyzy/.test(ktab)) {
    kurl = `http://ccs.js.hh.gzbaoxian.com/jx/qy.php?url=${kurl}`;
    kurl = JSON.parse(fetch(kurl)).url;
    input = { jx: 0, parse: 0, url: kurl }
} else if (/hmjc/.test(ktab)) {
    kurl = `http://101.42.92.211:5560/jx/dj.php?url=${kurl}`;
    kurl = JSON.parse(fetch(kurl)).url;
    input = { jx: 0, parse: 0, url: kurl, header: { 'User-Agent': MOBILE_UA, 'Referer': 'https://m3u8.com' } }
} else if (/djzy/.test(ktab)) {
    kurl = `http://ccs.js.hh.gzbaoxian.com/jx/dj.php?url=${kurl}`;
    kurl = JSON.parse(fetch(kurl)).url;
    input = { jx: 0, parse: 0, url: kurl, header: rule.headers }
} else if (/zbjx/.test(ktab)) {
    kurl = `http://27.25.159.14:6699/api/mgapp.php?url=${kurl}`;
    kurl = JSON.parse(fetch(kurl)).url;
    input = { jx: 0, parse: 0, url: kurl, header: { 'User-Agent': MOBILE_UA, 'Referer': 'https://m3u8.com'} }
} else {
    input = { jx: 0, parse: 1, url: kurl }
}
}),

filter: 'H4sIAAAAAAAAA+2ZW08aQRTH3/kUzT7zMIM39KsYH2jDU60PapsYQ7KKoiLlYivWSr2UKmi9gJqWS9Avw8zCt+jCzDlnSKshqamk2Td+/7Oze/57Of+MLvosbk28mPQtWq/DC9aE9Wo6NDdn+a2Z0Juwi2KjIKOrLr8LTb91hclFa6Yjrxbb0WJHdsGK+LWKBxNATV6cNO8OdU0D1tY/NWsbUFOA5zxeE9U6nFMB1Jz4ldM40zUNuC6dkHYB1inAWrzYbOSgpgBr2ZzbOdQU4PXWy+RPA9YKGepTA/pbPneyGfCnAGtLaWlnoabA6NP5WKc+O4DXq52JxrazsQaXRI5MRfz4OEOz4ZDxNHMlkaj1+zRjq+7xcHUFePW7pNhrwKUVQK19cEo1Deh251jmzsGtAqzdbNM6DVBrbZappoHWlcx1pZ5eTnZl5Qp6UYD+UiVZvQN/Cnru3UI4NGvcu+pts97o894FWGBEa92fhj5M+rCpD5E+ZOoB0gOmzknnps5IZ4bOx1F3fxp6kPSgqY+RPmbqo6SPmjr55aZfTn656ZeTX2765eSXm345+eWmX05+uemXkV9m+mXkl5l+Gfllpl9Gfpnpl5FfZvpl5JeZfhn5ZaZfRn6Z6ZeRX2b6ZeSXkV8+Pg5+uz8NPUh6sPf9frlAb7dMbola6re3W+ZsmYUZoAG/u5ztRC+o1gH8Xq9WxHoMvlcF7rV9U36fFfgneSNS31p5rCnAWjImUtdQU4ATI9oQlWWYGAr+p9wYpBz2MszLMC/DvAz7iwybmw/Nh+kFd+I/pL3U5wsu927dPGtWMMOQ8fP6eS0uE079A3xhyIMQpENPFqSPDGI4InfQrNWcgg1HIOMRexWRB4ca0MVKWaTytJqYBu5Ns5rGgdsFLwS8EPBCwAsBLwQeCYHhpwuB6EXrCOe7Auwuve+c405EAXZ3n3b3GNCdgufaMYnYVnv3FEd9F2jHtOmeCTwooD7L4n4H++wCrksWnTTcfQ1YOzwSe/jUFPS1Y/q+L+N4rxX0tbP7027Ki0kvJr2Y9GLS8mLywZgcebKYfPQPhKn3rQaMOw3YXTohLr9Adwpo3cN/rGzbsdZXcKyhnwht75yJ08+wTgGO8+SmOInCOFfQT6TJUsYYvQqwl868zEMvCmj/l5G3++BdAZ7TrrfyS3BOBQM/lgfgjea9/7d9ji58kV8V75tpPx4AAA=='
}