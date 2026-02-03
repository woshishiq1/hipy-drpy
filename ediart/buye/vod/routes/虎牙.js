const axios = require("axios");
const crypto = require("crypto");
const https = require("https");
const qs = require("querystring");

const axiosInstance = axios.create({
    httpsAgent: new https.Agent({
        keepAlive: true,
        rejectUnauthorized: false
    }),
    timeout: 10000,
    headers: {
        "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15",
        "Referer": "https://m.huya.com/"
    }
});

const md5 = (text) => crypto.createHash("md5").update(text).digest("hex");

/* =========================
   分类（已同步 PHP 中的分类 ID）
========================= */
const CLASSES = [
    { type_id: "2135", type_name: "一起看" },
    { type_id: "1663", type_name: "正能量" },
    { type_id: "1", type_name: "网游竞技" },
    { type_id: "2", type_name: "单机热游" },
    { type_id: "3", type_name: "手游休闲" },
    { type_id: "2168", type_name: "颜值" }
];

async function _home() {
    return { class: CLASSES, filters: {} };
}

async function _category({ id, page }) {
    // 适配一起看分类或其他普通分类
    const url = `https://www.huya.com/cache.php?m=LiveList&do=getLiveListByPage&gameId=${id}&tagAll=0&page=${page}`;
    const res = await axiosInstance.get(url);
    const data = res.data?.data || {};
    const rooms = data.datas || [];

    return {
        page: data.page || page,
        pagecount: data.totalPage || 999,
        limit: rooms.length,
        total: rooms.length > 0 ? 9999 : 0,
        list: rooms.map(it => ({
            vod_id: it.profileRoom,
            vod_name: it.roomName || it.nick || "虎牙直播",
            vod_pic: it.screenshot,
            vod_remarks: `${it.totalCount || 0}人在线`
        }))
    };
}

async function _detail({ id }) {
    const roomId = Array.isArray(id) ? id[0] : id;
    return {
        list: [{
            vod_id: roomId,
            vod_name: "虎牙直播",
            vod_pic: "",
            vod_play_from: "虎牙直播",
            vod_play_url: `直播$${roomId}`
        }]
    };
}

/* =========================
   播放（基于 PHP 算法满血修复版）
========================= */
async function _play({ id }) {
    try {
        // 使用移动端接口获取基础流信息，匹配 PHP 逻辑
        const api = `https://mp.huya.com/cache.php?m=Live&do=profileRoom&roomid=${id}`;
        const res = await axiosInstance.get(api);
        const data = res.data?.data;

        if (!data || !data.stream) return { parse: 0, url: "" };

        const uid = data.profileInfo?.uid || "0";
        // 默认取第一个 FLV 线路
        const streamInfo = data.stream.baseSteamInfoList[0];
        const sStreamName = streamInfo.sStreamName;
        
        // 核心算法：同步 PHP 逻辑
        const seqid = String(parseInt(uid) + Date.now());
        const ctype = "huya_adr";
        const t = "102";
        // 过期时间设为 6 小时后 (21600秒)
        const wsTime = Math.floor(Date.now() / 1000 + 21600).toString(16);
        
        // 第一层哈希：ss = md5(seqid|ctype|t)
        const ss = md5(`${seqid}|${ctype}|${t}`);
        
        // 第二层哈希：使用关键 Salt
        const wsSecret = md5(`DWq8BcJ3h6DJt6TY_${uid}_${sStreamName}_${ss}_${wsTime}`);

        // 拼接最终地址：强制 ratio=0 (原画) 
        const playUrl = `https://al.flv.huya.com/src/${sStreamName}.flv?wsSecret=${wsSecret}&wsTime=${wsTime}&ctype=${ctype}&seqid=${seqid}&uid=${uid}&fs=bgct&ver=1&t=${t}&ratio=0`;

        return {
            parse: 0,
            url: playUrl,
            header: {
                "User-Agent": "Mozilla/5.0",
                "Referer": "https://www.huya.com/"
            }
        };
    } catch (e) {
        return { parse: 0, url: "" };
    }
}

/* =========================
   T4 框架导出
========================= */
const meta = {
    key: "huya",
    name: "虎牙直播",
    type: 4,
    api: "/video/HuyaLive",
    searchable: 0,
    quickSearch: 0,
    playable: 1
};

module.exports = async (app, opt) => {
    app.get(meta.api, async (req, reply) => {
        const { ac, t, pg, ids, play } = req.query;
        if (play) return await _play({ id: play });
        if (!ac) return await _home();
        if (ac === "detail") {
            if (t) return await _category({ id: t, page: parseInt(pg || "1") });
            if (ids) return await _detail({ id: ids.split(",") });
        }
        return { code: 400, msg: "参数错误" };
    });
    opt.sites.push(meta);
};
