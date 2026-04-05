let host = 'https://mov.cenguigui.cn/duanju/api.php?';
let headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 13; M2102J2SC Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/141.0.7390.17 Mobile Safari/537.36'
};

async function init(cfg) {}

function getList(data) {
    let videos = [];
    let list = data.data || [];
    list.forEach(it => {
        videos.push({
            vod_id: it.book_id,
            vod_name: it.title,
            vod_pic: it.cover,
            vod_remarks: "共" + it.episode_cnt + "集"
        });
    });
    return videos;
}

async function home(filter) {
    return JSON.stringify({
        class: [{"type_id":"推荐榜","type_name":"推荐榜"},{"type_id":"新剧","type_name":"新剧"},{"type_id":"逆袭","type_name":"逆袭"},{"type_id":"霸总","type_name":"霸总"},{"type_id":"现代言情","type_name":"现代言情"},{"type_id":"打脸虐渣","type_name":"打脸虐渣"},{"type_id":"豪门恩怨","type_name":"豪门恩怨"},{"type_id":"神豪","type_name":"神豪"},{"type_id":"马甲","type_name":"马甲"},{"type_id":"都市日常","type_name":"都市日常"},{"type_id":"战神归来","type_name":"战神归来"},{"type_id":"小人物","type_name":"小人物"},{"type_id":"女性成长","type_name":"女性成长"},{"type_id":"大女主","type_name":"大女主"},{"type_id":"穿越","type_name":"穿越"},{"type_id":"都市修仙","type_name":"都市修仙"},{"type_id":"强者回归","type_name":"强者回归"},{"type_id":"亲情","type_name":"亲情"},{"type_id":"古装","type_name":"古装"},{"type_id":"重生","type_name":"重生"},{"type_id":"闪婚","type_name":"闪婚"},{"type_id":"赘婿逆袭","type_name":"赘婿逆袭"},{"type_id":"虐恋","type_name":"虐恋"},{"type_id":"追妻","type_name":"追妻"},{"type_id":"天下无敌","type_name":"天下无敌"},{"type_id":"家庭伦理","type_name":"家庭伦理"},{"type_id":"萌宝","type_name":"萌宝"},{"type_id":"古风权谋","type_name":"古风权谋"},{"type_id":"职场","type_name":"职场"},{"type_id":"奇幻脑洞","type_name":"奇幻脑洞"},{"type_id":"异能","type_name":"异能"},{"type_id":"无敌神医","type_name":"无敌神医"},{"type_id":"古风言情","type_name":"古风言情"},{"type_id":"传承觉醒","type_name":"传承觉醒"},{"type_id":"现言甜宠","type_name":"现言甜宠"},{"type_id":"奇幻爱情","type_name":"奇幻爱情"},{"type_id":"乡村","type_name":"乡村"},{"type_id":"历史古代","type_name":"历史古代"},{"type_id":"王妃","type_name":"王妃"},{"type_id":"高手下山","type_name":"高手下山"},{"type_id":"娱乐圈","type_name":"娱乐圈"},{"type_id":"强强联合","type_name":"强强联合"},{"type_id":"破镜重圆","type_name":"破镜重圆"},{"type_id":"暗恋成真","type_name":"暗恋成真"},{"type_id":"民国","type_name":"民国"},{"type_id":"欢喜冤家","type_name":"欢喜冤家"},{"type_id":"系统","type_name":"系统"},{"type_id":"真假千金","type_name":"真假千金"},{"type_id":"龙王","type_name":"龙王"},{"type_id":"校园","type_name":"校园"},{"type_id":"穿书","type_name":"穿书"},{"type_id":"女帝","type_name":"女帝"},{"type_id":"团宠","type_name":"团宠"},{"type_id":"年代爱情","type_name":"年代爱情"},{"type_id":"玄幻仙侠","type_name":"玄幻仙侠"},{"type_id":"青梅竹马","type_name":"青梅竹马"},{"type_id":"悬疑推理","type_name":"悬疑推理"},{"type_id":"皇后","type_name":"皇后"},{"type_id":"替身","type_name":"替身"},{"type_id":"大叔","type_name":"大叔"},{"type_id":"喜剧","type_name":"喜剧"},{"type_id":"剧情","type_name":"剧情"}]
    });
}

async function homeVod() {
    let resp = await req(host+"classname=新剧&page=1", {
        headers
    });
    let data = JSON.parse(resp.content);
    return JSON.stringify({
        list: getList(data)
    });
}

async function category(tid, pg, filter, extend) {
    const p = pg || 1;    
    let url = `${host}classname=${tid}&page=${p}`;
    let resp = await req(url, {
        headers
    });
    let data = JSON.parse(resp.content);
    return JSON.stringify({
        list: getList(data),
        page: parseInt(p)
    });
}

async function detail(id) {
    const url = `${host}book_id=${id}`;
    const resp = await req(url, { headers });
    const json = JSON.parse(resp.content);
    const playUrl = (json.data || []).map(it => `${it.title}$https://mov.cenguigui.cn/duanju/api.php?video_id=${it.video_id}&type=mp4`).join('#');
    return JSON.stringify({
        list: [{
            vod_id: id,
            vod_name: json.book_name || '',
            vod_pic: json.book_pic || '',
            vod_year: json.time || '',
            vod_remarks: "更新至"+json.total+"集"+"|"+"时长:"+json.duration,
            type_name: (json.category_names || []).join(','),
            vod_director: json.author || '',
            vod_content: json.desc || '',
            vod_play_from: '红果速播',
            vod_play_url: playUrl
        }]
    });
}

async function search(wd, quick, pg) {
    const p = pg || 1;    
    let url = `${host}name=${wd}&page=${p}`;
    let resp = await req(url, {
        headers
    });
    let data = JSON.parse(resp.content);
    return JSON.stringify({
        list: getList(data),
        page: parseInt(p)
    });
}

async function play(flag, id, flags) {
    return JSON.stringify({
        parse: 0,
        url: id,
        header: headers
    });
}

export default {
    init,
    home,
    homeVod,
    category,
    detail,
    search,
    play
};
