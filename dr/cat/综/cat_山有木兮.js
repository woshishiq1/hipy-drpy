/*
title: '山有木兮', author: '小可乐/v6.1.1'
说明：可以不写ext，用默认值，也可以写ext，ext支持的参数和格式参数如下(所有参数可选填)
"ext": {
    "host": "xxxx", //站点网址
    "timeout": 6000,  //请求超时，单位毫秒
    "catesSet": "剧集&电影&综艺",  //指定分类和顺序
    "tabsSet": "线路2&线路1"  //指定线路和顺序
}
*/

const MOBILE_UA = 'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.91 Mobile Safari/537.36';
const DefHeader = {'User-Agent': MOBILE_UA};
let HOST;
let KParams = {
    headers: {'User-Agent': MOBILE_UA},
    timeout: 5000
};

async function init(cfg) {
    try {
        HOST = (cfg.ext?.host?.trim() || 'https://film.symx.club').replace(/\/$/, '');
        KParams.headers['Referer'] = HOST;
        let parseTimeout = parseInt(cfg.ext?.timeout?.trim(), 10);
        KParams.timeout = parseTimeout > 0 ? parseTimeout : 5000;
        KParams.catesSet = cfg.ext?.catesSet?.trim() || '';
        KParams.tabsSet = cfg.ext?.tabsSet?.trim() || '';
        KParams.resObj = safeParseJSON(await request(`${HOST}/api/film/category`));
    } catch (e) {
        console.error('初始化参数失败：', e.message);
    }
}

async function home(filter) {
    try {
        let resObj = KParams.resObj;
        if (!resObj) {throw new Error('源码对象为空');}
        let typeArr = Array.isArray(resObj.data) ? resObj.data : [];
        let classes = typeArr.map(item => { return {type_name: item.categoryName ?? '分类名', type_id: item.categoryId.toString() ?? '分类值'}; });       
        if (KParams.catesSet) { classes = ctSet(classes, KParams.catesSet); }
        KParams.tidToTname = {};
        classes.forEach(it => {KParams.tidToTname[it.type_id] = it.type_name;});
        let filters = {};
        try {
            const nameObj = { area: 'area,地区', language: 'lang,语言', year: 'year,年份', sort: 'by,排序' };
            const valueObj = {area: ['中国大陆','香港','台湾','韩国','日本','美国','英国','法国','德国','意大利','西班牙','印度','泰国','俄罗斯','加拿大','澳大利亚'], language: ['汉语','英语','粤语','闽南语','韩元','日语','泰语','法语','印地语','意大利语','西班牙语','俄语','德语'], year: ['2026','2025','2024','2023','2022','2021','2020','2019','2018','2017','2016','2015','2014','2013','2012','2011'], sort: ['更新时间,updateTime', '豆瓣评分,doubanScore', '点击量,hits']};
            for (let it of classes) {
                filters[it.type_id] = Object.entries(nameObj).map(([nObjk, nObjv]) => {
                    let [kkey, kname] = nObjv.split(',');
                    let kvalue = valueObj[nObjk].map(it => {
                        let [n, v] = [it, it];
                        if (nObjk === 'sort') {[n, v] = it.split(',');}
                        return {n: n, v: v}; 
                    });
                    if (nObjk !== 'sort') {kvalue.unshift({n: '全部', v: ''});}
                    return {key: kkey, name: kname, value: kvalue};
                });
            }
        } catch (e) {
            filters = {};
        }
        return JSON.stringify({class: classes, filters: filters});
    } catch (e) {
        console.error('获取分类失败：', e.message);
        return JSON.stringify({class: [], filters: {}});
    }
}

async function homeVod() {
    try {
        let resObj = KParams.resObj;
        if (!resObj) {throw new Error('源码对象为空');}
        let homeArr = (resObj.data ?? []).map(it => it.filmList ?? []).flat(1);
        let VODS = getVodList(homeArr);
        return JSON.stringify({list: VODS});
    } catch (e) {
        console.error('推荐页获取失败：', e.message);
        return JSON.stringify({list: []});
    }
}

async function category(tid, pg, filter, extend) {
    try {
        pg = parseInt(pg, 10);
        pg = pg > 0 ? pg : 1;      
        let cateUrl = `${HOST}/api/film/category/list?categoryId=${extend?.cateId || tid}&area=${extend?.area ?? ''}&language=${extend?.lang ?? ''}&year=${extend?.year ?? ''}&sort=${extend?.by ?? ''}&pageNum=${pg}&pageSize=30`;        
        let resObj = safeParseJSON(await request(cateUrl));
        if (!resObj) {throw new Error('源码对象为空');}
        let cateArr = resObj.data?.list ?? [];
        let VODS = getVodList(cateArr);
        let pageCount = 999;
        return JSON.stringify({list: VODS, page: pg, pagecount: pageCount, limit: 30, total: 30*pageCount});
    } catch (e) {
        console.error('类别页获取失败：', e.message);
        return JSON.stringify({list: [], page: 1, pagecount: 0, limit: 30, total: 0});
    }
}

async function search(wd, quick, pg) {
    try {
        pg = parseInt(pg, 10);
        pg = pg > 0 ? pg : 1;
        let searchUrl = `${HOST}/api/film/search?keyword=${wd}&pageNum=${pg}&pageSize=30`;
        let resObj = safeParseJSON(await request(searchUrl));
        if (!resObj) {throw new Error('源码对象为空');}
        let searchArr = resObj.data?.list ?? [];
        let VODS = getVodList(searchArr);
        return JSON.stringify({list: VODS, page: pg, pagecount: 10, limit: 30, total: 300});
    } catch (e) {
        console.error('搜索页获取失败：', e.message);
        return JSON.stringify({list: [], page: 1, pagecount: 0, limit: 30, total: 0});
    }
}

function getVodList(listArr) {
    try {
        if (!Array.isArray(listArr) || !listArr.length) {throw new Error('输入参数不符合非空数组要求');}
        let kvods = [];
        let idToName = KParams.tidToTname;
        for (let it of listArr) {
            let kname = it.name ?? '名称';
            let kpic = it.cover ?? '图片';
            let k = it.categoryId?.toString() || '类型';
            let kremarks = `${it.updateStatus || '状态'}|${it.doubanScore || '无评分'}|${idToName[k] || k}`;
            kvods.push({
                vod_name: kname,
                vod_pic: kpic,
                vod_remarks: kremarks,
                vod_id: `${it.id}@${kname}@${kpic}@${kremarks}`
            });
        }
        return kvods;
    } catch (e) {
        console.error(`生成视频列表失败：`, e.message);
        return [];
    }
}

async function detail(ids) {
    try {
        let [id, kname, kpic, remarks] = ids.split('@');
        let [kremarks, kscore, ktype] = remarks.split('|');
        let detailUrl = `${HOST}/api/film/detail?id=${id}`;
        let resObj = safeParseJSON(await request(detailUrl));
        let kdetail = resObj?.data ?? null;
        if (!kdetail) {throw new Error('详情对象kdetail解析失败');}
        let [ktabs, kurls] = [[], []];
        let [karea = '地区', klang = '语言'] = (kdetail.other || '地区/语言').split('/', 2);
        let kvod = kdetail?.playLineList ?? null;
        if (kvod) {
            for (let it of kvod) {
                let tab = it.playerName || 'noTab';
                ktabs.push(tab);
                let kurl = (it.lines ?? []).map(item => { return `${item.name ?? 'noEpi'}$${item.id ?? 'noUrl'}@${tab}`; }).join('#');
                kurls.push(kurl);
            }
        }
        if (KParams.tabsSet) {
            let ktus = ktabs.map((it, idx) => { return {type_name: it, type_value: kurls[idx]} });
            ktus = ctSet(ktus, KParams.tabsSet);
            ktabs = ktus.map(it => it.type_name);
            kurls = ktus.map(it => it.type_value);
        }
        let VOD = {
            vod_id: kdetail.id || id,
            vod_name: kdetail.name || kname,
            vod_pic: kdetail.cover || kpic,
            type_name: ktype,
            vod_remarks: remarks,
            vod_year: kdetail.year || '1000',
            vod_area: karea,
            vod_lang: klang,
            vod_director: kdetail.director || '导演',
            vod_actor: kdetail.actor || '主演',
            vod_content: kdetail.blurb || '简介',
            vod_play_from: ktabs.join('$$$'),
            vod_play_url: kurls.join('$$$')
        };
        return JSON.stringify({list: [VOD]});
    } catch (e) {
        console.error('详情页获取失败：', e.message);
        return JSON.stringify({list: []});
    }
}

async function play(flag, ids, flags) {
    try {
        let kurl = '', jx = 0, kp = 0;
        let [id, ktab] = ids.split('@');
        let playUrl = `${HOST}/api/line/play/parse?lineId=${id}`;
        let resObj = safeParseJSON(await request(playUrl));
        kurl = resObj?.data ?? '';
        if (!/^http/.test(kurl)) {
            jx = 1;
            kp = 1;
            kurl = playUrl;
        } else if (!/m3u8|mp4|mkv/.test(kurl)) {
            kp = 1;
        }
        return JSON.stringify({jx: jx, parse: kp, url: kurl, header: DefHeader});
    } catch (e) {
        console.error('播放失败：', e.message);
        return JSON.stringify({jx: 0, parse: 0, url: '', header: {}});
    }
}

function ctSet(kArr, setStr) {
    try {
        if (!Array.isArray(kArr) || kArr.length === 0 || typeof setStr !== 'string' || !setStr) { throw new Error('第一参数需为非空数组，第二参数需为非空字符串'); }
        const set_arr = [...kArr];
        const arrNames = setStr.split('&');
        const filtered_arr = arrNames.map(item => set_arr.find(it => it.type_name === item)).filter(Boolean);
        return filtered_arr.length? filtered_arr : [set_arr[0]];
    } catch (e) {
        console.error('ctSet 执行异常：', e.message);
        return kArr;
    }
}

function safeParseJSON(jStr) {
    try {
        return JSON.parse(jStr);
    } catch (e) {
        return null;
    }
}

async function request(reqUrl, options = {}) {
    try {
        if (typeof reqUrl !== 'string' || !reqUrl.trim()) { throw new Error('reqUrl需为字符串且非空'); }
        if (typeof options !== 'object' || Array.isArray(options) || !options) { throw new Error('options类型需为非null对象'); }
        options.method = options.method?.toLowerCase() || 'get';
        if (['get', 'head'].includes(options.method)) {
            delete options.data;
            delete options.postType;
        } else {
            options.data = options.data ?? '';
            options.postType = options.postType?.toLowerCase() || 'form';
        }        
        let {headers, timeout, charset, toBase64 = false, ...restOpts } = options;
        const optObj = {
            headers: (typeof headers === 'object' && !Array.isArray(headers) && headers) ? headers : KParams.headers,
            timeout: parseInt(timeout, 10) > 0 ? parseInt(timeout, 10) : KParams.timeout,
            charset: charset?.toLowerCase() || 'utf-8',
            buffer: toBase64 ? 2 : 0,
            ...restOpts
        };
        const res = await req(reqUrl, optObj);
        if (options.withHeaders) {
            const resHeaders = typeof res.headers === 'object' && !Array.isArray(res.headers) && res.headers ? res.headers : {};
            const resWithHeaders = { ...resHeaders, body: res?.content ?? '' };
            return JSON.stringify(resWithHeaders);
        }
        return res?.content ?? '';
    } catch (e) {
        console.error(`${reqUrl}→请求失败：`, e.message);
        return options?.withHeaders ? JSON.stringify({ body: '' }) : '';
    }
}

export function __jsEvalReturn() {
    return {
        init,
        home,
        homeVod,
        category,
        search,
        detail,
        play,
        proxy: null
    };
}