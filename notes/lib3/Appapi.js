import { Crypto,_} from 'assets://js/lib/cat.js';
let siteUrl = '';
let key = '';
let iv = '';
let siteKey = '';
let siteType = 0;
let headers = {
     'User-Agent': 'okhttp/3.14.9',
    'app-user-device-id': '',
    'app-version-code': '191',
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
};

let parseMap = {};
let homeVods = [];
async function request(reqUrl, data, header, method) {
    let res = await req(reqUrl, {
        method: method || 'get',
        data: data || '',
        headers: header || headers,
        postType: method === 'post' ? 'form' : '',
        timeout: 30000,
    });
    return res.content;
}

async function init(cfg) {
    siteKey = cfg.skey;
    siteType = cfg.stype;
    if (cfg.ext) {
        try {
            let words = Crypto.enc.Base64.parse(cfg.ext);
            let decodedExt = words.toString(Crypto.enc.Utf8);
            //console.log('解码后的数据:', decodedExt);
            siteUrl = decodedExt.split('|')[0];
            key = decodedExt.split('|')[1];
            iv = decodedExt.split('|')[2];
        } catch (e) {
            console.log('Base64解码失败:', e, '原始数据:', cfg.ext);
            // 如果解码失败，使用原始值
            siteUrl = cfg.ext.split('|')[0];
            key = cfg.ext.split('|')[1];
            iv = cfg.ext.split('|')[2];
        }
    }
} 
// ... existing code ...

async function home(filter) {
    let rets = JSON.parse(await request(siteUrl + '/getappapi.index/init')).data;
    //console.log(rets);
    let data = JSON.parse(aesDecode(rets, key, iv));
    //console.log(data);
    homeVods = homeVods.concat(data.banner_list);
    let filters = {};
    let classes = [];
    _.forEach(data.type_list, item => {
        if (item.type_id > 0) {
            homeVods = homeVods.concat(item.recommend_list);
        }
        classes.push({
            type_id: item.type_id,
            type_name: item.type_name,
        });
        filters[item.type_id] = item.type_name;
        let filterList = [];
        _.forEach(item.filter_type_list, f => {
            let filter = {};
            if (f.name === 'class') {
                filter['name'] = '分类';
                filter['key'] = f.name;
                filter['value'] = _.map(f.list, i => {
                    return {v:i,n:i};
                });  
            } 
            if (f.name === 'area') {
                filter['name'] = '区域';
                filter['key'] = f.name;
                filter['value'] = _.map(f.list, i => {
                    return {v:i,n:i};
                });
                
            } 
            if (f.name === 'lang') {
                filter['name'] = '语言';
                filter['key'] = f.name;
                filter['value'] = _.map(f.list, i => {
                    return {v:i,n:i};
                });
                
            } 
            if (f.name === 'year') {
                filter['name'] = '年份';
                filter['key'] = f.name;
                filter['value'] = _.map(f.list, i => {
                    return {v:i,n:i};
                });
                
            } 
            if (f.name === 'sort') {
                filter['name'] = '排序';
                filter['key'] = f.name;
                filter['value'] = _.map(f.list, i => {
                    return {v:i,n:i};
                });
            } 
            filterList.push(filter);
        });
        filters[item.type_id] = filterList;
    });
    return JSON.stringify({
        'class': classes,
        'filters': filters,
    });
}

async function homeVod() {
    return JSON.stringify({
        list: homeVods,
    });

}

async function category(tid, pg, filter, extend) {
	if(pg <= 0) pg = 1;
	let url = `${siteUrl}/getappapi.index/typeFilterVodList`;
    let params = {
        "area": extend['area'] || "全部",
        "sort": extend['sort'] || "最新",
        "class": extend['class'] || "全部",
        "type_id": tid,
        "year": extend['year'] || "全部",
        "lang": extend['lang'] || '全部',
        "page": pg,
    }
    let encData = JSON.parse(await request(url, params, '', 'post')).data;
    //console.log(encData);
    let videos = JSON.parse(aesDecode(encData,key, iv)).recommend_list;

    return JSON.stringify({
        page: pg,
        pagecount: 9999,
        list: videos,
    });
}

async function detail(id) {
    let url = `${siteUrl}/getappapi.index/vodDetail`;
	let info = JSON.parse(aesDecode(JSON.parse(await request(url, {vod_id: id},'', 'post')).data, key, iv));
    //console.log(info);
    let videos = {
        vod_id: info.vod.vod_id,
        vod_name: info.vod.vod_name,
        vod_area: info.vod.vod_area,
        vod_director: info.vod.vod_director,
        vod_actor: info.vod.vod_actor,
        vod_pic: info.vod.vod_pic,
        vod_content: info.vod.vod_content,
        type_name: info.vod.vod_class,
        vod_year: info.vod.vod_year

    }
    let froms = [];
    let urls = [];
    _.forEach(info.vod_play_list, item => {
        froms.push(item['player_info']['show']);
        let parse = item['player_info']['parse'];
		let ua = item['player_info']['user_agent'];
        let nameUrls = [];
        _.forEach(item['urls'], item2 => {
            nameUrls.push(item2['name'] + '$' + item2['url']+ '@@' + parse +'@@'+ item2['token'] + '@@' + item2['parse_api_url'] + '@@' + ua );
        });
        urls.push(nameUrls.join('#'));
    });
    videos.vod_play_from = froms.join('$$$');
    videos.vod_play_url = urls.join('$$$');
    return JSON.stringify({
        list: [videos],
    });
}

async function play(flag, id, flags) {
    let playUrl = id.split('@@')[0];
    let parse = id.split('@@')[1];
    let token = id.split('@@')[2];
	let parse_api_url = id.split('@@')[3];
    headers['User-Agent'] = id.split('@@')[4];
    if (playUrl.indexOf('m3u8') > 0 || playUrl.indexOf('mp4') > 0) {
        return JSON.stringify({
            parse: 0,
            url: playUrl,
        });
    }

    if(parse.startsWith("http")) {
        let parseUrl = parse + playUrl;
	   // let parseUrl = parse_api_url;
        if (token) {
            parseUrl = parse + playUrl + '&token=' + token;
		 //   parseUrl = parse_api_url + '&token=' + token;
        }
        let rets = await request(parseUrl);
        if (rets.indexOf('DOCTYPE html') > -1) {
            return JSON.stringify({
                parse: 1,
                url: parseUrl,
            });
        }
        let parseJson = JSON.parse(rets);
        return JSON.stringify({
            parse: 0,
            url: parseJson['url'] || parseJson['data']['url'],
        });
    }
    let params = {
        'parse_api': parse,
        'url': aesEncode(playUrl, key, iv),
        'token': token,
    }
    //console.log(params);
    let rets = (await req(`${siteUrl}/getappapi.index/vodParse`, {data:params, method:'post',postType:'form'})).content;
    //console.log(rets);
    let url = aesDecode(JSON.parse(rets).data, key, iv);
    //console.log(url);
    return JSON.stringify({
        parse: 0,
        url: JSON.parse(JSON.parse(url).json).url,
    });
}

async function search(wd, quick, pg) {
    let params = {
        'page': '1',
        'type_id': '0',
        'keywords': wd,
    }
    let url = `${siteUrl}/getappapi.index/searchList`
    let encData = await request(url, params, '', 'post');
    let videos = JSON.parse(aesDecode(JSON.parse(encData).data, key, iv)).search_list;
    return JSON.stringify({
        list: videos,
    });
} 

//aes解密
function aesDecode(str, keyStr, ivStr, type) {
    const key = Crypto.enc.Utf8.parse(keyStr);
    if (type === 'hex') {
        str = Crypto.enc.Hex.parse(str);
        return Crypto.AES.decrypt({
            ciphertext: str
        }, key, {
            iv: Crypto.enc.Utf8.parse(ivStr),
            mode: Crypto.mode.CBC,
            padding: Crypto.pad.Pkcs7
        }).toString(Crypto.enc.Utf8);
    } else {
        return Crypto.AES.decrypt(str, key, {
            iv: Crypto.enc.Utf8.parse(ivStr),
            mode: Crypto.mode.CBC,
            padding: Crypto.pad.Pkcs7
        }).toString(Crypto.enc.Utf8);
    }
 }

  //aes加密
  function aesEncode(str, keyStr, ivStr, type) {
    const key = Crypto.enc.Utf8.parse(keyStr);
    let encData = Crypto.AES.encrypt(str, key, {
        iv: Crypto.enc.Utf8.parse(ivStr),
        mode: Crypto.mode.CBC,
        padding: Crypto.pad.Pkcs7
    });
    if (type === 'hex') return encData.ciphertext.toString(Crypto.enc.Hex);
    return encData.toString();
 }

 //console.log(aesEncode('https://v.qq.com/x/cover/mzc00200qon7vo3/k4100di9c9y.html', key, iv));

function md5(text) {
    return Crypto.MD5(text).toString();
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