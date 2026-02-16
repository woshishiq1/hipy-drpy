const axios = require("axios");
const http = require("http");
const https = require("https");

const _http = axios.create({
    timeout: 15 * 1000,
    httpsAgent: new https.Agent({ keepAlive: true, rejectUnauthorized: false }),
    httpAgent: new http.Agent({ keepAlive: true }),
});

// 小苹果规则配置 [1]
const xiaopingguoConfig = {
    host: "http://su.haotv.site",
    headers: {
        "User-Agent": "okhttp/3.12.11"
    }
};

const PAGE_LIMIT = 20;

// 播放请求头 [1]
const playHeader = {
    'user_id': 'XPGBOX',
    'token2': 'X28tpHOOiCB6T2VddyLaFNV4JZT0+i9Ep88+rWLcRPJXUkVhsTx5q9Be2N8=',
    'version': 'XPGBOX com.phoenix.tv1.6.1',
    'hash': 'bd56',
    'screenx': '2268',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
    'token': 'Yz0QiCqorD4JdlVqQTe4JJB0JazI2RUjg/9smAGhdtRQM3IXmiRx2PEt4t9EUFS+BiIyBffFa4MPMJkOZQJqe/ApC3U9wm2iDW9jWrFCWwR9mDwuMQU33A+F/VyQOhI/jYxKZFsGOcmWilxqLylX8bLLNnAU5jaTrSPwRO+DfBnIdhckWld4V1k2ZfZ3QKbN',
    'timestamp': '1768109944',
    'screeny': '1116'
};

// 过滤包含"及时雨"的播放源 [1]
const filterPlayUrls = (urls) => {
    if (!urls || !Array.isArray(urls)) return [];
    return urls.filter(item => !item.key || !item.key.includes("及时雨"));
};

// 【新增】辅助函数：解码 ext 参数
const decodeExt = (ext) => {
    if (!ext) return {};
    try {
        const decoded = Buffer.from(ext, 'base64').toString('utf-8');
        return JSON.parse(decoded);
    } catch (e) {
        try {
            return JSON.parse(ext);
        } catch (e2) {
            return {};
        }
    }
};

// 【新增】辅助函数：解码 extend 参数
const decodeExtend = (extend) => {
    if (!extend) return {};
    try {
        const urlDecoded = decodeURIComponent(extend);
        const base64Decoded = Buffer.from(urlDecoded, 'base64').toString('utf-8');
        return JSON.parse(base64Decoded);
    } catch (e) {
        try {
            return JSON.parse(extend);
        } catch (e2) {
            return {};
        }
    }
};

// 【新增】固定分类数据配置
const FIXED_CLASSES = [
    {
        type_id: "1",
        type_name: "电影",
        classes: ["动作片","喜剧片","爱情片","科幻片","恐怖片","犯罪片","战争片","动漫片","剧情片","纪录片"],
        areas: ["大陆","港台","日韩","欧美","海外"],
        years: ["2026","2025","2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","更早"]
    },
    {
        type_id: "2",
        type_name: "连续剧",
        classes: ["古装","家庭","历史","情感","悬疑","网剧","偶像","经典","乡村","情景","商战","惊悚","言情","犯罪","奇幻","运动","冒险","音乐"],
        areas: ["大陆","港台","日韩","欧美","海外"],
        years: ["2026","2025","2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","更早"]
    },
    {
        type_id: "3",
        type_name: "综艺",
        classes: ["真人秀","脱口秀","选秀","晚会","音乐","情感","访谈","歌舞","竞技","搞笑"],
        areas: ["大陆","港台","日韩","欧美","海外"],
        years: ["2026","2025","2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","更早"]
    },
    {
        type_id: "4",
        type_name: "动漫",
        classes: ["热血","少女","魔幻","爆笑","冒险","恋爱","校园","治愈","灵异","机战","格斗","耽美","推理","穿越"],
        areas: ["大陆","港台","日韩","欧美","海外"],
        years: ["2026","2025","2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","更早"]
    }
];

// 【新增】生成分类筛选器
const generateFilters = () => {
    const filters = {};
    
    FIXED_CLASSES.forEach(item => {
        const filterList = [];
        
        // 1. 类型筛选
        filterList.push({
            key: 'class',
            name: '类型',
            value: [
                { n: '全部', v: '' },
                ...item.classes.map(cls => ({ n: cls, v: cls }))
            ]
        });
        
        // 2. 地区筛选
        filterList.push({
            key: 'area',
            name: '地区',
            value: [
                { n: '全部', v: '' },
                ...item.areas.map(area => ({ n: area, v: area }))
            ]
        });
        
        // 3. 年份筛选
        filterList.push({
            key: 'year',
            name: '年份',
            value: [
                { n: '全部', v: '' },
                ...item.years.map(year => ({ n: year, v: year }))
            ]
        });
        
        filters[item.type_id] = filterList;
    });
    
    return filters;
};

// 【优化】转换视频对象为统一格式
const formatVodItem = (vod) => {
    if (!vod) return null;
    const desc = vod.updateInfo ? "更新至" + vod.updateInfo : (vod.score && vod.score !== "0.0" ? vod.score.toString() : "");
    return {
        vod_id: vod.id?.toString() || '',
        vod_name: vod.name || '',
        vod_pic: vod.pic || '',
        vod_remarks: desc
    };
};

// 获取分类数据 [1] - 改为返回固定分类
const getClasses = async () => {
    return FIXED_CLASSES.map(c => ({
        type_id: c.type_id,
        type_name: c.type_name
    }));
};

// 获取首页推荐 [1] - 优化数据提取逻辑
const getHomeRecommend = async () => {
    try {
        const url = xiaopingguoConfig.host + "/api.php/v2.main/androidhome";
        const response = await _http.get(url, { headers: xiaopingguoConfig.headers });
        const data = response.data;
        const list = [];
        
        if (data && data.data) {
            // 1. 提取顶部推荐（如果有）
            if (data.data.top && typeof data.data.top === 'object') {
                const topItem = formatVodItem(data.data.top);
                if (topItem) {
                    topItem.vod_remarks = "推荐:" + (topItem.vod_remarks || "");
                    list.push(topItem);
                }
            }
            
            // 2. 提取分类列表中的视频（优先取"最新上映"）
            if (data.data.list && Array.isArray(data.data.list)) {
                // 找到"最新上映"分类
                const latestCategory = data.data.list.find(item => 
                    item.title && item.title.includes("最新")
                );
                
                // 如果没找到"最新上映"，取第一个有数据的分类
                const targetCategory = latestCategory || data.data.list.find(item => 
                    item.list && Array.isArray(item.list) && item.list.length > 0
                );
                
                if (targetCategory && targetCategory.list && Array.isArray(targetCategory.list)) {
                    targetCategory.list.forEach(vod => {
                        const formatted = formatVodItem(vod);
                        if (formatted) list.push(formatted);
                    });
                }
                
                // 3. 如果数据不够，再从其他分类补充
                if (list.length < 20) {
                    data.data.list.forEach(category => {
                        if (category.list && Array.isArray(category.list)) {
                            category.list.forEach(vod => {
                                // 避免重复
                                const vodId = vod.id?.toString();
                                if (vodId && !list.find(item => item.vod_id === vodId)) {
                                    const formatted = formatVodItem(vod);
                                    if (formatted) {
                                        list.push(formatted);
                                        if (list.length >= 30) return; // 最多30条
                                    }
                                }
                            });
                        }
                        if (list.length >= 30) return;
                    });
                }
            }
        }
        
        return list;
    } catch (error) {
        console.error('获取首页推荐失败:', error.message);
        return [];
    }
};

// 分类列表请求 [1] - 优化参数处理
const getCategoryList = async (type, page = 1, extend = {}) => {
    try {
        const typeId = type ? type.toString() : '';
        if (!typeId) {
            return { list: [], page: parseInt(page), pagecount: 1 };
        }

        const params = {
            "page": parseInt(page) || 1,
            "type": typeId,
            "area": extend.area || '',
            "year": extend.year || '',
            "sortby": extend.sortby || '',
            "class": extend.class || ''
        };
        
        const queryParts = [];
        Object.keys(params).forEach(k => {
            if (params[k] !== '' && params[k] !== undefined && params[k] !== null) {
                queryParts.push(k + '=' + encodeURIComponent(params[k]));
            }
        });
        
        const url = xiaopingguoConfig.host + '/api.php/v2.vod/androidfilter10086?' + queryParts.join('&');
        
        const response = await _http.get(url, { headers: xiaopingguoConfig.headers });
        const data = response.data;
        const list = [];
        
        if (data && data.data && Array.isArray(data.data)) {
            data.data.forEach(vod => {
                const formatted = formatVodItem(vod);
                if (formatted) list.push(formatted);
            });
        }
        
        return {
            list: list,
            page: parseInt(page),
            pagecount: list.length >= PAGE_LIMIT ? parseInt(page) + 1 : parseInt(page)
        };
    } catch (error) {
        console.error('获取分类列表失败:', error.message);
        return { list: [], page: parseInt(page), pagecount: 1 };
    }
};

// 搜索功能 [1][2] - 优化数据格式化
const searchVod = async (keyword, page = 1) => {
    try {
        const url = xiaopingguoConfig.host + '/api.php/v2.vod/androidsearch10086?page=' + page + '&wd=' + encodeURIComponent(keyword);
        const response = await _http.get(url, { headers: xiaopingguoConfig.headers });
        const data = response.data;
        const list = [];
        if (data && data.data && Array.isArray(data.data)) {
            data.data.forEach(vod => {
                const formatted = formatVodItem(vod);
                if (formatted) list.push(formatted);
            });
        }
        return {
            list: list,
            page: parseInt(page),
            pagecount: list.length >= PAGE_LIMIT ? parseInt(page) + 1 : parseInt(page),
            total: list.length
        };
    } catch (error) {
        console.error('搜索失败:', error.message);
        return { list: [], page: parseInt(page), pagecount: 1, total: 0 };
    }
};

// 详情获取 [1]
const getDetail = async (id) => {
    try {
        const url = xiaopingguoConfig.host + '/api.php/v3.vod/androiddetail2?vod_id=' + id;
        const response = await _http.get(url, { headers: xiaopingguoConfig.headers });
        const data = response.data;
        if (!data || !data.data) return null;
        const vodData = data.data;
        const filteredUrls = filterPlayUrls(vodData.urls || []);
        const playlist = filteredUrls.map(i => i.key + '$' + i.url).join('#');
        return {
            vod_id: vodData.id?.toString() || '',
            vod_name: vodData.name || '',
            vod_remarks: vodData.updateInfo ? "更新至" + vodData.updateInfo : '',
            vod_actor: vodData.actor || '',
            vod_director: vodData.director || '',
            vod_content: vodData.content || '',
            vod_play_from: '小苹果',
            vod_play_url: playlist || ''
        };
    } catch (error) {
        console.error('获取详情失败:', error.message);
        return null;
    }
};

// TVBox T4 接口请求处理 (核心修复部分) [1] - 集成筛选器逻辑
const handleT4Request = async (req) => {
    let { ac, t, pg, wd, ids, play, quick, ext, extend } = req.query;
    const page = parseInt(pg) || 1;
    
    let extParams = {};
    if (ext) {
        extParams = decodeExt(ext);
    }

    // 1. 优先处理搜索 (防止被首页逻辑拦截)
    if (wd) {
        const result = await searchVod(wd, page);
        if (quick === 'true') {
            result.list = result.list.slice(0, 10);
        }
        return {
            list: result.list,
            page: result.page,
            pagecount: result.pagecount,
            limit: PAGE_LIMIT,
            total: result.total
        };
    }

    // 2. 播放请求
    if (play) {
        let playUrl = play;
        if (!play.startsWith('http')) {
            playUrl = "http://s.haotv.store/m3u8/" + play + ".m3u8";
        }
        return {
            parse: 0,
            url: playUrl,
            header: playHeader
        };
    }

    // 3. 详情请求
    if (ids) {
        const detail = await getDetail(ids);
        return {
            list: detail ? [detail] : [],
            page: 1,
            pagecount: 1,
            total: detail ? 1 : 0
        };
    }

    // 4. 分类内容请求
    if (t) {
        let extendParams = { ...extParams };
        
        if (extend) {
            const decodedExtend = decodeExtend(extend);
            extendParams = { ...extendParams, ...decodedExtend };
        }
        
        const finalExtend = {
            area: extendParams.area || extendParams.areaes || '',
            year: extendParams.year || extendParams.yeares || '',
            class: extendParams.class || extendParams.classes || extendParams.type || '',
            sortby: extendParams.sortby || extendParams.sort || ''
        };
        
        const result = await getCategoryList(t, page, finalExtend);
        return {
            list: result.list,
            page: result.page,
            pagecount: result.pagecount,
            limit: PAGE_LIMIT
        };
    }

    // 5. 首页/分类请求
    if (!ac || ac === 'class' || ac === 'home') {
        const filters = generateFilters();
        const classList = FIXED_CLASSES.map(c => ({
            type_id: c.type_id,
            type_name: c.type_name
        }));
        
        if (ac === 'class') {
            return { 
                class: classList,
                filters: filters
            };
        }
        
        const homeList = await getHomeRecommend();
        return {
            class: classList,
            filters: filters,
            list: homeList.slice(0, 20),
            page: 1,
            pagecount: 1,
            total: homeList.length
        };
    }

    return { list: [], page: 1, pagecount: 1 };
};

const meta = {
    key: "xiaopingguo",
    name: "苹果",
    type: 4,
    api: "/video/xiaopingguo",
    searchable: 1,
    quickSearch: 1,
    filterable: 1
};

module.exports = async (app, opt) => {
    app.get(meta.api, async (req, reply) => {
        return await handleT4Request(req);
    });
    opt.sites.push(meta);
};