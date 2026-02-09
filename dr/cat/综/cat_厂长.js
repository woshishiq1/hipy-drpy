/*
title: '厂长资源', author: '小可乐/v6.1.1'
说明：可以不写ext，也可以写ext，ext支持的参数和格式参数如下
"ext": {
    "host": "xxxx", //站点网址
    "timeout": 6000  //请求超时，单位毫秒
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
        HOST = (cfg.ext?.host?.trim() || 'https://www.cz01.org').replace(/\/$/, '');
        KParams.headers['Referer'] = HOST;
        let parseTimeout = parseInt(cfg.ext?.timeout?.trim(), 10);
        if (parseTimeout > 0) {KParams.timeout = parseTimeout;}
    } catch (e) {
        console.error('初始化参数失败：', e.message);
    }
}

async function home(filter) {
    try {
        let kclassName = '全部$movie_bt&电影$movie_bt_series/dyy&剧集$movie_bt_series/dianshiju&动画$movie_bt_series/dohua';
        let classes = kclassName.split('&').map(it => {
            let [cName, cId] = it.split('$');
            return {type_name: cName, type_id: cId};
        });
        let filters = {};
        try {
            const nameObj = { cateId: 'cateId,分类', area: 'area,地区', year: 'year,年份', class: 'class,影片类型', series: 'series,子类'};
            const flValues = {
                cateId: {'movie_bt_series/dyy': '全部$movie_bt_series/dyy&豆瓣电影Top250$dbtop250&最新电影$zuixindianying&高分影视$gaofenyingshi&热映中$reyingzhong&会员专区$movie_bt_series/huiyuanzhuanqu&站长推荐$movie_bt_series/zhanchangtuijian&华语电影$movie_bt_series/huayudianying&欧美电影$movie_bt_series/meiguodianying&韩国电影$movie_bt_series/hanguodianying&日本电影$movie_bt_series/ribendianying&印度电影$movie_bt_series/yindudianying&俄罗斯电影$movie_bt_series/eluosidianying&加拿大电影$movie_bt_series/jianadadianying', 'movie_bt_series/dianshiju': '全部$movie_bt_series/dianshiju&国产剧$gcj&美剧$meijutt&韩剧$hanjutv&日剧$movie_bt_series/rj&海外剧$movie_bt_series/hwj', 'movie_bt_series/dohua': '全部$movie_bt_series/dohua&剧场版$dongmanjuchangban&番剧$fanju'}, 
                area: {'movie_bt': '全部$&中国台湾$tw&中国大陆$zh&中国香港$hk&丹麦$dm&乌克兰$wukelan&以色列$ysl&伊朗$yilang&俄罗斯$els&保加利亚$baojialiya&其他$qt&冰岛$冰岛&利比里亚$libiliya&加拿大$jnd&匈牙利$xiongyali&南非$nanfei&卡塔尔$kataer&卢森堡$lusenbao&印度$yidu&印度尼西亚$yindunixiya&哈萨克斯坦$hasakesitan&哥伦比亚$gelunbiya&土耳其$tuerqi&埃及$aiji&塞尔维亚$塞尔维亚&塞浦路斯$saipulusi&墨西哥$mxg&奥地利$aodili&巴哈马$bahama&巴基斯坦$bajisitan&巴西$bx&希腊$xila&德国$dg&意大利$ydl&拉脱维亚$拉脱维亚&挪威$nuewei&捷克$jieke&摩洛哥$moluoge&摩纳哥$monage&新加坡$xinjiapo&新西兰$xinxilan&日本$riben&柬埔寨$jianpuzhai&比利时$bilishi&法国$fg&波兰$bolan&泰国$taiguo&澳大利亚$adly&爱尔兰$aierlan&瑞典$ruidian&瑞士$ruishi&白俄罗斯$baieluosi&立陶宛$立陶宛&罗马尼亚$luomaniya&美国$meiguo&芬兰$fenlan&英国$yinguo&荷兰$hnwe&蒙古$menggu&西德$xide&西班牙$xby&越南$yuenan&阿根廷$agenting&阿联酋$alianqiu&韩国$hggggg&马来西亚$malaixiya&马耳他$maerta&黎巴嫩$libanen'},
                year: {'movie_bt': '全部$&1900~2000年代$19002000nd&2001~2010年代$20012010nd&2011$2011nd&2012$2012&2013$2013&2014$2014&2015$2015&2016$2016&2017$2017&2018$2018&2019$2019&2020$2020&2021$2021&2022$2022&2023$2023&2024$2024&2025$2025&2026$2026'}, 
                class: {'movie_bt': '全部$&传记$chuanji&儿童$etet&冒险$maoxian&剧情$juqing&动作$dozuo&动漫$doman&动画$dhh&历史$lishi&古装$guzhuang&同性$tongxing&喜剧$xiju&奇幻$qihuan&家庭$jiating&恐怖$kubu&悬疑$xuanyi&情色$qingse&惊悚$kingsong&战争$zhanzheng&歌舞$gw&武侠$wuxia&灾难$zainan&爱情$aiqing&犯罪$fanzui&真人秀$zrx&短片$dp&科幻$kh&纪录片$jlpp&西部$xb&运动$yd&音乐$yy&鬼怪$鬼怪'}, 
                series: {'movie_bt': '全部$&会员专区$huiyuanzhuanqu&站长推荐$zhanchangtuijian&电影$dyy&华语电影$huayudianying&欧美电影$meiguodianying&韩国电影$hanguodianying&日本电影$ribendianying&印度电影$yindudianying&俄罗斯电影$eluosidianying&加拿大电影$jianadadianying&电视剧$dianshiju&国产剧$guochanju&美剧$mj&韩剧$hj&日剧$rj&海外剧（其他）$hwj&动画$dohua'}
            };
            for (let item of classes) {
                filters[item.type_id] = Object.entries(nameObj).map(([nObjk, nObjv]) => {
                    let [kkey, kname] = nObjv.split(',');
                    let fvalue = flValues[kkey]?.[item.type_id]?.split('&') || [];
                    let kvalue = fvalue.map(it => {
                        let [n, v] = it.split('$');
                        return {n: n, v: v}; 
                    });
                    return {key: kkey, name: kname, value: kvalue};
                }).filter(flt => flt.key && flt.value.length);
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
        let resHtml = await request(HOST);
        let VODS = getVodList(resHtml);
        return JSON.stringify({list: VODS});
    } catch (e) {
        console.error('推荐页获取失败：', e.message);
        return JSON.stringify({list: []});
    }
}

async function category(tid, pg, filter, extend) {
    try {
        pg = parseInt(pg, 10), pg = pg > 0 ? pg : 1;
        let fl = extend ? extend : {};
        let cateUrl = `${HOST}/${fl.cateId || tid}${fl.area ? `/movie_bt_cat/${fl.area}` : ''}${fl.year ? `/year/${fl.year}` : ''}${fl.class ? `/movie_bt_tags/${fl.class}` : ''}${fl.series ? `/movie_bt_series/${fl.series}` : ''}/page/${pg}`;
        let resHtml = await request(cateUrl);
        let VODS = getVodList(resHtml);
        let limit = VODS.length;
        let hasMore = cutStr(resHtml, 'pagenavi_txt">', '</div>').includes('&gt;');
        let pagecount = hasMore ? pg + 1 : pg;
        return JSON.stringify({list: VODS, page: pg, pagecount: pagecount, limit: limit, total: limit*pagecount});
    } catch (e) {
        console.error('类别页获取失败：', e.message);
        return JSON.stringify({list: [], page: 1, pagecount: 0, limit: 30, total: 0});
    }
}

async function search(wd, quick, pg) {
    try {
        pg = parseInt(pg, 10), pg = pg > 0 ? pg : 1; 
        let VODS = [];     
        let searchStop = false, cPage = 1, pgMax = 228;
        while (!searchStop && cPage < pgMax) {
            let batchEnd = Math.min(cPage + 10, pgMax);
            let batchUrlList = [];
            for (let page = cPage; page < batchEnd; page++) {
                batchUrlList.push(`${HOST}/movie_bt/page/${page}`);
            }            
            let resHtmlList = await Promise.all(
                batchUrlList.map(async (burl) => {
                    try {return await request(burl);} catch (sErr) {return '';}
                })
            );
            for (let resHtml of resHtmlList) {
                let svods = getVodList(resHtml).filter(it => it.vod_name.includes(wd));
                if (svods.length) {VODS.push(...svods)};
            }
            if (VODS.length) {searchStop = true;}
            cPage = batchEnd;
        }
        return JSON.stringify({list: VODS, page: pg, pagecount: 10, limit: 30, total: 300});
    } catch (e) {
        console.error('搜索页获取失败：', e.message);
        return JSON.stringify({list: [], page: 1, pagecount: 0, limit: 30, total: 0});
    }
}

function getVodList(khtml) {
    try {
        if (!khtml) {throw new Error('源码为空');}  
        let kvods = [];
        let listArr = cutStr(khtml, '<li>', '</li>', '', false, 0, true);
        for (let it of listArr) {
            let kname = cutStr(it, 'alt="', '"', '名称');
            let kpic = cutStr(it, 'data-original="', '"', '图片');
            let kremarks = cutStr(it, 'jidi">', '</') || cutStr(it, 'qb">', '</') || cutStr(it, 'furk">', '</', '状态');
            let kid = cutStr(it, 'href="', '"');
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
        let [id, kname, kpic, kremarks] = ids.split('@');
        let detailUrl = !/^http/.test(id) ? `${HOST}${id}` : id;
        let resHtml = await request(detailUrl);
        if (!resHtml) {throw new Error('源码为空');}  
        let intros = cutStr(resHtml, '"dytext', 'mi_paly_box">', '', false);
        let [ktabs, kurls] = [[], []];
        let zxArr = cutStr(resHtml, 'paly_list_btn', '</div>', '', false, 0, true);
        zxArr.forEach((item,idx) => {
            let siglUrl = cutStr(item, '<a', '/a>', '', false, 0, true).map(it => { return cutStr(it, '>', '<', 'noEpi')  + '$' + cutStr(it, 'href="', '"', 'noUrl'); }).join('#');
            ktabs.push(`厂长在线${idx+1}`);
            kurls.push(siglUrl);
        });
        let twoCut = cutStr(resHtml, 'dwonBT">', '</ul>', '', false);
        if (twoCut) {
            let xzArr = cutStr(twoCut, '<li>', '</li>', '', false, 0, true);
            xzArr.forEach((item,idx) => {
                let siglUrl = cutStr(item, '<a', '/a>', '', false, 0, true).map(it => {
                    let eUrl = cutStr(it, 'href="', '"', 'noUrl');
                    if (!/^magnet:/.test(eUrl)) { eUrl = eUrl.replace(/#/g, '@');}
                    return `${cutStr(it, 'title="', '"', 'noEpi')}$${eUrl}`;
                }).join('#');
                if (/magnet:/.test(siglUrl)) {
                    ktabs.push(`下载线${idx+1}磁力`);
                } else {
                    ktabs.push(`下载线${idx+1}网盘`);
                }
                kurls.push(siglUrl);
            });
        }
        let VOD = {
            vod_id: detailUrl,
            vod_name: kname,
            vod_pic: kpic,
            vod_remarks: kremarks,
            type_name: cutStr(intros, '类型：', '</li>', '类型'),
            vod_year: cutStr(intros, '年份：', '</li>', '1000'),
            vod_area: cutStr(intros, '地区：', '</li>', '地区'),
            vod_lang: cutStr(intros, '语言：', '</li>', '语言'),
            vod_director: cutStr(intros, '导演：', '</li>', '导演'),
            vod_actor: cutStr(intros, '主演：', '</li>', '主演'),
            vod_content: cutStr(intros, 'yp_context">', '</div>', kname),
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
        let playUrl = ids;
        let kp = 0, kurl = '';
        if (/磁力/.test(flag)) {
            kurl = playUrl;
        } else if (/网盘/.test(flag)) {
            kurl = playUrl.replace(/@/g, '#');
            kurl = `push://${kurl}`;
        } else {
            let resHtml = await request(playUrl);
            kurl = cutStr(resHtml, '<iframe£src="', '"', '', false).replace(/&amp;/g, '&');
            if (!kurl) {
                kp = 1;
                kurl = playUrl;
            } else {
                let ifrHtml = await request(kurl);
                kurl = cutStr(ifrHtml, "mysvg = '", "'");
                if (!kurl) {
                    kp = 1;
                    kurl = playUrl;
                }
            }
        }
        return JSON.stringify({jx: 0, parse: kp, url: kurl, header: DefHeader});
    } catch (e) {
        console.error('播放失败：', e.message);
        return JSON.stringify({jx: 0, parse: 0, url: '', header: {}});
    }
}

function cutStr(str, prefix = '', suffix = '', defVal = '', clean = true, i = 0, all = false) {
    try {
        if (typeof str !== 'string') {throw new Error('被截取对象必须为字符串');}
        const cleanStr = cs => String(cs).replace(/<[^>]*?>/g, ' ').replace(/(&nbsp;|[\u0020\u00A0\u3000\s])+/g, ' ').trim().replace(/\s+/g, ' ');
        const esc = s => String(s).replace(/[.*+?${}()|[\]\\/^]/g, '\\$&');
        let pre = esc(prefix).replace(/£/g, '[^]*?'), end = esc(suffix);
        const regex = new RegExp(`${pre || '^'}([^]*?)${end || '$'}`, 'g');
        const matchIter = str.matchAll(regex);
        if (all) {
            let matchArr = [...matchIter];
            if (!matchArr.length) {return [defVal];}
            return matchArr.map(ela => ela[1] !== undefined ? (clean ? cleanStr(ela[1]) : ela[1]) : defVal);
        }
        const idx = parseInt(i, 10);
        if (isNaN(idx)) {throw new Error('序号必须为整数');}
        let tgResult, matchIdx = 0;
        if (idx >= 0) {
            for (let elt of matchIter) {
                if (matchIdx++ === idx) {
                    tgResult = elt[1];
                    break;
                }
            }
        } else {
            let absI = Math.abs(idx), ringBuf = new Array(absI), ringPtr = 0, ringCnt = 0;
            for (let elt of matchIter) {
                ringBuf[ringPtr] = elt[1];
                ringPtr = (ringPtr + 1) % absI;
                ringCnt = Math.min(ringCnt + 1, absI);
                matchIdx++;
            }
            tgResult = (matchIdx >= absI && ringCnt > 0) ? ringBuf[ringPtr % ringCnt] : undefined;
        }
        return tgResult !== undefined ? (clean ? (cleanStr(tgResult) || defVal) : tgResult) : defVal;
    } catch (e) {
        console.error(`字符串截取错误：`, e.message);
        return all ? ['cutErr'] : 'cutErr';
    }
}

async function request(reqUrl, options = {}) {
    try {
        if (typeof reqUrl !== 'string' || !reqUrl.trim()) { throw new Error('reqUrl需为字符串且非空非全空白'); }
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