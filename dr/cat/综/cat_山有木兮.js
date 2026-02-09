/*
title: '山有木兮', author: '小可乐/v6.1.2'
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
var HOST;
var KParams = {
    headers: {'User-Agent': MOBILE_UA},
    timeout: 5000
};

async function init(cfg) {
    try {
        HOST = (cfg.ext?.host?.trim() || 'https://film.symx.club').replace(/\/$/, '');
        KParams.headers['Referer'] = HOST;
        KParams.headers['X-Platform'] = 'web';
        let parseTimeout = parseInt(cfg.ext?.timeout?.trim(), 10);
        if (parseTimeout > 0) {KParams.timeout = parseTimeout;}
        KParams.catesSet = cfg.ext?.catesSet?.trim() || '';
        KParams.tabsSet = cfg.ext?.tabsSet?.trim() || '';
    } catch (e) {
        console.error('初始化参数失败：', e.message);
    }
}

async function home(filter) {
    try {
        let resObj = safeParseJSON(await request(`${HOST}/api/category/top`));
        if (!resObj) {throw new Error('源码对象为空');}
        let typeArr = Array.isArray(resObj.data) ? resObj.data : [];
        let classes = typeArr.map((item,idx) => { return {type_name: item.name ?? `分类${idx+1}`, type_id: item.id?.toString() ?? `值${idx+1}`}; });
        if (KParams.catesSet) { classes = ctSet(classes, KParams.catesSet); }
        KParams.tidToTname = classes.reduce((obj, item) => {
            obj[item.type_id] = item.type_name;
            return obj;
        }, {});        
        let filters = {};
        try {
            const nameObj = {categoryOptions: 'cateId,类型', areaOptions: 'area,地区', languageOptions: 'lang,语言', yearOptions: 'year,年份', sortOptions: 'by,排序' };
            let resObjList = await Promise.all(
                classes.map(async (it) => {
                    try {return safeParseJSON(await request(`${HOST}/api/film/category/filter?categoryId=${it.type_id}`));} catch (sErr) {return null;}
                })
            );
            classes.forEach((it, idx) => {
                let resObj = resObjList[idx];
                filters[it.type_id] = Object.entries(nameObj).map(([nObjk, nObjv]) => {
                    let [kkey, kname] = nObjv.split(',');
                    let kvalue = (resObj?.data?.[nObjk] ?? []).map(item => {
                        let [n, v] = [item, item];
                        if (nObjk === 'sortOptions') {
                            n = item.label ?? 'noN';
                            v = item.value ?? 'noV';
                        }
                        return {n: n, v: v}; 
                    });
                    if (nObjk !== 'sortOptions') {kvalue.unshift({n: '全部', v: ''});}
                    return {key: kkey, name: kname, value: kvalue};
                }).filter(fl => fl.key && fl.value.length > 1);
            });
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
        let homeUrl = `${HOST}/api/film/category`;
        let resObj = safeParseJSON(await request(homeUrl));
        let VODS = getVodList(resObj, true);
        return JSON.stringify({list: VODS});
    } catch (e) {
        console.error('推荐页获取失败：', e.message);
        return JSON.stringify({list: []});
    }
}

async function category(tid, pg, filter, extend) {
    try {
        pg = parseInt(pg, 10), pg = pg > 0 ? pg : 1;
        let fl = extend || {};
        let cateUrl = `${HOST}/api/film/category/list?categoryId=${fl.cateId || tid}&area=${fl.area ?? ''}&language=${fl.lang ?? ''}&year=${fl.year ?? ''}&sort=${fl.by ?? ''}&pageNum=${pg}&pageSize=30`;        
        let resObj = safeParseJSON(await request(cateUrl));
        let VODS = getVodList(resObj);
        let limit = VODS.length || 30
        let total = resObj?.data?.total || 30000;
        let pageCount = Math.ceil(total / limit);
        return JSON.stringify({list: VODS, page: pg, pagecount: pageCount, limit: limit, total: total});
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
        let VODS = getVodList(resObj);
        return JSON.stringify({list: VODS, page: pg, pagecount: 10, limit: 30, total: 300});
    } catch (e) {
        console.error('搜索页获取失败：', e.message);
        return JSON.stringify({list: [], page: 1, pagecount: 0, limit: 30, total: 0});
    }
}

function getVodList(resObj, rec=false) {
    try {
        if (!resObj) {throw new Error('源码对象为空');}
        let listArr = rec ? (resObj.data ?? []).map(it => it.filmList ?? []).flat(1) : resObj.data?.list ?? [];
        if (!Array.isArray(listArr) || !listArr.length) {throw new Error('listArr不符合非空数组要求');}
        let kvods = [];
        let idToName = KParams.tidToTname;
        for (let it of listArr) {
            let kname = it.name || '名称';
            let kpic = it.cover || '图片';
            let k = it.categoryId?.toString() || '类型';
            let kremarks = `${it.updateStatus || '状态'}|${it.doubanScore || '无评分'}|${idToName[k] || k}`;
            let kid = it.id ?? '';
            if (kid) {
                kvods.push({
                    vod_name: kname,
                    vod_pic: kpic,
                    vod_remarks: kremarks,
                    vod_id: `${kid}@${kname}@${kpic}@${kremarks}`
                });
            }
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
            kvod.forEach((it,idx) => {
                let tab = it.playerName || `线${idx+1}`;
                ktabs.push(tab);
                let kurl = (it.lines ?? []).map((item,j) => `${item.name ?? `noEpi${j+1}`}$${item.id ?? `noUrl${j+1}`}` ).join('#');
                kurls.push(kurl);
            });
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
            vod_year: kdetail.year.replace(/^0$/, '') || '1000',
            vod_area: karea,
            vod_lang: klang,
            vod_director: kdetail.director || '导演',
            vod_actor: kdetail.actor.replace(/\\u[0-9a-fA-F]{1,4}/g, ',') || '主演',
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
        let kurl = '', kp = 0;        
        let playUrl = `${HOST}/api/line/play/parse?lineId=${ids}`;
        let resObj = safeParseJSON(await request(playUrl));
        kurl = resObj?.data ?? '';
        if (!/^http/.test(kurl)) {
            kp = 1;
            kurl = playUrl;
        }
        return JSON.stringify({jx: 0, parse: kp, url: kurl, header: DefHeader});
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
    try {return JSON.parse(jStr);} catch (e) {return null;}
}

async function request(reqUrl, options = {}) {
    try {
        if (typeof reqUrl !== 'string' || !reqUrl.trim()) { throw new Error('reqUrl需为字符串且非空'); }
        if (typeof options !== 'object' || Array.isArray(options) || options === null) { throw new Error('options类型需为非null对象'); }
        options.method = options.method?.toUpperCase() || 'GET';
        if (['GET', 'HEAD'].includes(options.method)) {
            delete options.body;
            delete options.data;
            delete options.postType;
        }
        let {headers, timeout, ...restOpts} = options;
        const optObj = {
            headers: (typeof headers === 'object' && !Array.isArray(headers) && headers) ? headers : KParams.headers,
            timeout: parseInt(timeout, 10) > 0 ? parseInt(timeout, 10) : KParams.timeout,
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