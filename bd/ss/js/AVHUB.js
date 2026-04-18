// ==============================
// 1. 统一配置 
// ==============================
import 'assets://js/lib/crypto-js.js';
const MOBILE_UA = 'Mozilla/5.0 (Linux; Android 15; RMX3770 Build/AP3A.240617.008) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/134.0.6998.135 Mobile Safari/537.36';

const CommonHeaders = {
  'User-Agent': MOBILE_UA,
  'Referer': '',
   'Content-Type': 'application/x-www-form-urlencoded',
  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Connection': 'keep-alive',

  // 🔥 【改这里】换成目标网站的 Cookie
  'Cookie': ''
};

const DefHeader = CommonHeaders;
var HOST;

var KParams = {
  headers: CommonHeaders,
  timeout: 8000
};

// ==============================
// 2. 工具函数 —— 【全程不动】
// ==============================

function dealSameEle(arr) {
    try {
        if (!Array.isArray(arr)) return [];
        const map = {};
        return arr.map(item => {
            let count = map[item] || 0;
            map[item] = count + 1;
            return count > 0 ? item + (count + 1) : item;
        });
    } catch (e) {
        return arr;
    }
}

function ctSet(kArr, setStr) {
    try {
        if (!Array.isArray(kArr) || kArr.length === 0 || typeof setStr !== 'string' || !setStr) return kArr;
        const arrNames = setStr.split('&');
        const filtered_arr = arrNames.map(item => kArr.find(it => it.type_name === item)).filter(Boolean);
        return filtered_arr.length ? filtered_arr : [kArr[0]];
    } catch (e) {
        return kArr;
    }
}

function cutStr(str, p, s, d = '', c = true, i = 0, a = false) {
    try {
        if (!str) return a ? [d] : d;
        let es = x => x.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        let reg = new RegExp(es(p).replace(/£/g, '[^]*?') + '([\\s\\S]*?)' + es(s), 'g');
        let m = [...str.matchAll(reg)].map(x => x[1].trim());
        if (a) return c ? m.map(x => x.replace(/<[^>]+>/g, '')) : m;
        let r = m[i >= 0 ? i : m.length + i] || d;
        return c ? r.replace(/<[^>]+>/g, '') : r;
    } catch (e) {
        return a ? [d] : d;
    }
}



function safeParseJSON(str) {
    try { return JSON.parse(str); } catch { return null; }
}

async function request(reqUrl, options = {}) {
    try {
        if (typeof reqUrl !== 'string' || !reqUrl.trim()) return '';
        if (typeof options !== 'object' || Array.isArray(options) || !options) options = {};
        options.method = options.method?.toUpperCase() || 'GET';
        if (['GET', 'HEAD'].includes(options.method)) {
            delete options.body; delete options.data; delete options.postType;
        }
        let {headers, timeout, ...restOpts} = options;
        const optObj = {
            headers: headers || KParams.headers,
            timeout: parseInt(timeout, 10) > 0 ? timeout : KParams.timeout,
            ...restOpts
        };
        const res = await req(reqUrl, optObj);
        return res?.content ?? '';
    } catch (e) {
        console.error(`${reqUrl} 请求失败`);
        return '';
    }
}

// ==============================
// 3. 初始化 —— 【必改域名】
// ==============================
async function init(cfg) {
    try {
        let customHost = cfg.ext?.host?.trim();
        if (customHost) {
            HOST = customHost.replace(/\/$/, '');
        } else {
            let pubHtml = await request('https://avhuba15.com', { timeout: 8000 });
            if (pubHtml) {
                let wordsMatch = pubHtml.match(/words\s*=\s*"([^"]+)"/);
                let words = wordsMatch ? wordsMatch[1].split(',') : [];
                let mainDomain = 'hmcckor.com';
                let backupDomain = 'sxpeoni.cc';
                
                let candidates = [];
                for (let i = 0; i < 5; i++) {
                    let w = words[Math.floor(Math.random() * words.length)];
                    if (w) candidates.push(`https://${w}.${mainDomain}`);
                }
                for (let i = 0; i < 3; i++) {
                    let w = words[Math.floor(Math.random() * words.length)];
                    if (w) candidates.push(`https://${w}.${backupDomain}`);
                }
                
                for (let url of candidates) {
                    try {
                        let testHtml = await request(url, { timeout: 5000 });
                        if (testHtml && testHtml.length > 100) {
                            HOST = url;
                            KParams.resHtml = testHtml;
                            break;
                        }
                    } catch(e) {}
                }
                if (!HOST) HOST = `https://${words[0] || 'avhub'}.${mainDomain}`;
            } else {
                HOST = 'https://avhub.hmcckor.com';
            }
        }
        
        if (!KParams.resHtml) KParams.resHtml = await request(HOST, KParams);
        
        KParams.headers['Referer'] = HOST;
        let t = parseInt(cfg.ext?.timeout, 10);
        if (t > 0) KParams.timeout = t;
        KParams.catesSet = cfg.ext?.catesSet?.trim() || '';
        KParams.tabsSet = cfg.ext?.tabsSet?.trim() || '';
    } catch (e) {
        HOST = 'https://avhub.hmcckor.com';
        KParams.headers['Referer'] = HOST;
        KParams.resHtml = await request(HOST, KParams);
    }
}


//4、首页和筛选

async function home(filter) {
    try {
        let html = KParams.resHtml;
        if (!html) return '{"class":[],"filters":{}}';

        // 提取顶部分类（跳过前两个）
        let typeArr = pdfa(html, 'a[href*="tags"]').slice();
        let classes = typeArr.map((it, i) => ({
            type_name: pdfh(it, 'Text') || `分类${i+1}`,
            type_id: cutStr(it, '/tags/', '"') || `ID${i+1}`
        }));

        // ID去重
        let seen = new Set();
        classes = classes.filter(item => !seen.has(item.type_id) && seen.add(item.type_id));

        // 屏蔽指定分类（填 blockedNames）
        const blockedNames = [];
        if (blockedNames.length) classes = classes.filter(item => !blockedNames.includes(item.type_name));

        // 分类顺序自定义（外部配置）
        KParams.catesSet = "";
        if (KParams.catesSet) classes = ctSet(classes, KParams.catesSet);

        // 无筛选，直接返回分类列表
        return JSON.stringify({ class: classes, filters: {} });
    } catch (e) {
        return '{"class":[],"filters":{}}';
    }
}

// 5. 视频列表解析 —— (三个函数)
// ==============================

// 首页视频列表
function getHomeVod(h) {
    try {
        let r = [];
        pdfa(h, '.video-img-box:has(a[href*="videos"])').forEach(it => {
            let n = pdfh(it, 'img&&alt') || '';
            let pic =  'https://ts2.tc.mm.bing.net/th/id/OIP-C.BQOVgw06UciBLhevmD3e4gHaLl?dpr=3&pid=ImgDetMain&o=7&rm=3'
            let id = pdfh(it, 'a&&href') || '';
            let rm = pdfh(it, '.label&&Text') || '请理性欣赏！';
            if (id && n) {
                r.push({
                    vod_name: n,
                    vod_pic: pic,
                    vod_remarks: rm,
                    vod_id: `${id}@${n}@${pic}@${rm}`
                });
            }
        });
        return r;
    } catch(e) {
        return [];
    }
}

// 分类页视频列表
function getCategoryVod(h) {
    try {
        let r = [];
        pdfa(h, '.video-img-box:has(a[href*="videos"])').forEach(it => {
            let n = pdfh(it, 'img&&alt') || '';
            let pic =  'https://ts2.tc.mm.bing.net/th/id/OIP-C.BQOVgw06UciBLhevmD3e4gHaLl?dpr=3&pid=ImgDetMain&o=7&rm=3'
            let id = pdfh(it, 'a&&href') || '';
            let rm = pdfh(it, '.label&&Text') || '请理性欣赏！';
            if (id && n) {
                r.push({
                    vod_name: n,
                    vod_pic: pic,
                    vod_remarks: rm,
                    vod_id: `${id}@${n}@${pic}@${rm}`
                });
            }
        });
        return r;
    } catch(e) {
        return [];
    }
}

// 搜索结果视频列表
function getSearchVod(h) {
    try {
        let r = [];
        pdfa(h, '.video-img-box:has(a[href*="videos"])').forEach(it => {
            let n = pdfh(it, 'img&&alt') || '';
            let pic =  'https://ts2.tc.mm.bing.net/th/id/OIP-C.BQOVgw06UciBLhevmD3e4gHaLl?dpr=3&pid=ImgDetMain&o=7&rm=3'
            let id = pdfh(it, 'a&&href') || '';
            let rm = pdfh(it, '.label&&Text') || '请理性欣赏！';
            if (id && n) {
                r.push({
                    vod_name: n,
                    vod_pic: pic,
                    vod_remarks: rm,
                    vod_id: `${id}@${n}@${pic}@${rm}`
                });
            }
        });
        return r;
    } catch(e) {
        return [];
    }
}

// ==============================
// 6. 首页视频 —— 不动
// ==============================
async function homeVod() {
    try {
        return JSON.stringify({list:getHomeVod(KParams.resHtml)});
    } catch(e) {
        return '{"list":[]}';
    }
}

//https://avhub.hmcckor.com/tags/143/latest/2
// 7. 分类页 —— 改URL规则即可
// ==============================
async function category(tid, pg, filter, extend) {
    try {
        pg = Math.max(parseInt(pg)||1, 1);
        let fl = extend||{}; tid = fl.tid||tid;
        // 🔥 【改这里】分类URL拼接规则
         let cateUrl = `${HOST}/tags/${tid}/latest/${pg}`;
        let list = getCategoryVod(await request(cateUrl, KParams));
        return JSON.stringify({list, page:pg, pagecount:list.length>=10?pg+2:1, limit:list.length, total:list.length*(list.length>=10?pg+2:1)});
    } catch(e) {
        return '{"list":[],"page":1,"pagecount":0,"limit":30,"total":0}';
    }
}



// ==============================
// 8. 搜索 —— 改URL规则即可
//==============================
  async function search(wd, quick, pg) {
    try {
        pg = Math.max(parseInt(pg)||1, 1);
        // 🔥 【改这里】搜索URL规则
        
        //https://avhub.hmcckor.com/search/ssis/2
        let url = `${HOST}/search/${wd}/${pg}`;
        let list = getSearchVod(await request(url, KParams));
        return JSON.stringify({list, page:pg, pagecount:list.length>=10?pg+2:1, limit:list.length, total:list.length*(list.length>=10?pg+2:1)});
    } catch(e) {
        return '{"list":[],"page":1,"pagecount":0,"limit":30,"total":0}';
    }
}



// ==============================
// 9. 详情页 —— 【全站最常改】
// ==============================
async function detail(ids) {
    try {
        let [id, n, pic, rm] = ids.split('@');
        let url = /^http/.test(id) ? id : HOST + id;
    /*    let h = await request(url, KParams);
        if (!h) return '{"list":[]}';
        url = HOST + pdfh(h,'a[href*="play"]&&href')*/

        let info = {
            vod_id: url,
            vod_name: n,
            vod_pic: pic,
            vod_remarks: rm,
        };

        return JSON.stringify({
            list: [{
                ...info,
                vod_play_from: 'AVHUB专线',
                vod_play_url: n + "$" + url,
            }]
        });
    } catch(e) {
        return '{"list":[]}';
    }
}

// ==============================
// 10. 播放解析 —— 【必改！每个站不一样】
// ==============================

async function play(flag, ids) {
    let html = await request(ids, KParams);
    let u = cutStr(html, 'var hlsUrl = "', '"');
    if (!u) return JSON.stringify({ jx: 0, parse: 1, url: `https://mo.765365.xyz/proxyjx/?url=${encodeURIComponent(ids)}`, header: DefHeader });
    u = u.replace(/&amp;/g, '&');
    return JSON.stringify({ jx: 0, parse: 0, url: u, header: { ...DefHeader, 'Referer': HOST } });
}
// ==============================
// 导出 —— 绝对不动
// ==============================
export function __jsEvalReturn() {
    return { init, home, homeVod, category, search, detail, play, proxy:null };
}