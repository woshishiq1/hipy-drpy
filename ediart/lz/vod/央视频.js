/**
 * 央视频 720P
 * 作者：deepseek
 * 版本：1.0
 * 最后更新：2026-1-2 02:46:31
 * 发布页 https://m.yangshipin.cn/
 * @config
 * debug: true
 * blockList: *.[ico|png|jpeg|jpg|gif|webp]*|*.css
 */

const baseUrl = 'https://m.yangshipin.cn/';
const headers = {
	'user-agent': 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; ELS-AN10; HMSCore 6.11.0.302) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.88 HuaweiBrowser/13.0.3.320 Mobile Safari/537.36'
};

/**
 * 初始化配置
 */
async function init(cfg) {
    return {};
}

/**
 * 首页分类
 */
async function homeContent(filter) {
    return {
        class: [
            { type_id: "1", type_name: "央视" },
            { type_id: "2", type_name: "卫视" }
        ]
    };
}

/**
 * 首页推荐视频
 */
async function homeVideoContent() {
    return { list: [] };
}

/**
 * 分类内容
 */
async function categoryContent(tid, pg, filter, extend) {
    const res = await Java.req('https://h5access.yangshipin.cn/web/tv_web_share?raw=1&pid=600002485');
    const jsonData = JSON.parse(res.body);
    const pidInfo = jsonData?.data?.pidInfo || [];

    const isCentralTV = (name) => name.startsWith('CCTV') || name.startsWith('CGTN');

    const getChannelPic = (name, fallback) => {
        if (name == 'CCTV5+') return 'https://lp.live.cntv.cn/pic/cctv5plus_2.png';
        const match = name.match(/^CCTV(\d{1,2})$/i);
        if (match) return `https://lp.live.cntv.cn/pic/cctv${match[1]}_2.png`;
        return fallback || '';
    };
    
    const vods = pidInfo
        .filter(item => {
            if (item.vipInfo?.isVip !== false) return false;
            if (!item.pid || !item.channelName) return false;
            const isCentral = isCentralTV(item.channelName);
            return tid === '1' ? isCentral : !isCentral;
        })
        .map(item => {
            const isCentral = isCentralTV(item.channelName);
            const vodPic = getChannelPic(item.channelName, item.audioPosterUrl);
            return {
                vod_id: item.pid,
                vod_name: item.channelName,
                vod_pic: vodPic,
                style: { type: "rect", ratio: isCentral ? 1.66 : 1 }
            };
        })
        .filter(item => item.vod_pic);
    
    return {
        code: 1,
        msg: "数据列表",
        list: vods,
        page: 1,
        pagecount: 1,
        limit: vods.length,
        total: vods.length
    };
}

/**
 * 详情页
 */
async function detailContent(ids) {
    const list = [{
        vod_id: ids[0],
		vod_name: 'cctv',
        vod_play_from: 'cctv',
        // vod_play_url: '播放$https://m.yangshipin.cn/tv?pid=' + ids[0] + '&ptag=4_1.0.5.15187_copy,4_1.0.0.20034_copy'
        vod_play_url: `播放$https://w.yangshipin.cn/video?type=1&vid=2000204603&pid=${ids[0]}&ptag=4_2.7.2.23316_wxf`
    }];
    return { code: 1, msg: "数据列表", page: 1, pagecount: 1, limit: 1, total: 1, list };
}

/**
 * 搜索
 */
async function searchContent(key, quick, pg) {
    return { list: [] };
}

/**
 * 播放器
 */
async function playerContent(flag, id, vipFlags) {
	// Java.showWebView();
    return {
        type: 'sniff',
        url: id,
		headers: headers,
        script: `let t=setInterval(()=>{let p=document.querySelector("#v-live-video");if(p?.play){p.play();clearInterval(t)}},100);`,
        timeout: 15
    };
}


/* ---------------- 导出对象 ---------------- */
const spider = { init, homeContent, homeVideoContent, categoryContent, detailContent, searchContent, playerContent};
spider;
