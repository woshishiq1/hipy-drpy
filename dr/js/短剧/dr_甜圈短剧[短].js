var rule = {
    author: '小可乐/2503/第一版',
    title: '甜圈短剧[短]',
    类型: '影视',
    //host: 'https://api.cenguigui.cn',
    host: 'https://api-v2.cenguigui.cn',
    headers: {
        'User-Agent': 'MOBILE_UA'
    },
    编码: 'utf-8',
    timeout: 5000,
    homeUrl: '/api/duanju/api.php?classname=推荐榜&offset=0',
    url: '/api/duanju/api.php?classname=fyclass&offset=fypage',
    filter_url: '',
    detailUrl: '/api/duanju/api.php?book_id=fyid',
    searchUrl: '/api/duanju/api.php?name=**&page=fypage',
    limit: 9,
    double: false,
    class_name: '🔥 推荐榜&🎬 新剧&🎬 逆袭&🎬 霸总&🎬 现代言情&🎬 打脸虐渣&🎬 豪门恩怨&🎬 神豪&🎬 马甲&🎬 都市日常&🎬 战神归来&🎬 小人物&🎬 女性成长&🎬 大女主&🎬 穿越&🎬 都市修仙&🎬 强者回归&🎬 亲情&🎬 古装&🎬 重生&🎬 闪婚&🎬 赘婿逆袭&🎬 虐恋&🎬 追妻&🎬 天下无敌&🎬 家庭伦理&🎬 萌宝&🎬 古风权谋&🎬 职场&🎬 奇幻脑洞&🎬 异能&🎬 无敌神医&🎬 古风言情&🎬 传承觉醒&🎬 现言甜宠&🎬 奇幻爱情&🎬 乡村&🎬 历史古代&🎬 王妃&🎬 高手下山&🎬 娱乐圈&🎬 强强联合&🎬 破镜重圆&🎬 暗恋成真&🎬 民国&🎬 欢喜冤家&🎬 系统&🎬 真假千金&🎬 龙王&🎬 校园&🎬 穿书&🎬 女帝&🎬 团宠&🎬 年代爱情&🎬 玄幻仙侠&🎬 青梅竹马&🎬 悬疑推理&🎬 皇后&🎬 替身&🎬 大叔&🎬 喜剧&🎬 剧情',
    class_url: '推荐榜&新剧&逆袭&霸总&现代言情&打脸虐渣&豪门恩怨&神豪&马甲&都市日常&战神归来&小人物&女性成长&大女主&穿越&都市修仙&强者回归&亲情&古装&重生&闪婚&赘婿逆袭&虐恋&追妻&天下无敌&家庭伦理&萌宝&古风权谋&职场&奇幻脑洞&异能&无敌神医&古风言情&传承觉醒&现言甜宠&奇幻爱情&乡村&历史古代&王妃&高手下山&娱乐圈&强强联合&破镜重圆&暗恋成真&民国&欢喜冤家&系统&真假千金&龙王&校园&穿书&女帝&团宠&年代爱情&玄幻仙侠&青梅竹马&悬疑推理&皇后&替身&大叔&喜剧&剧情',
    推荐: '*',
    一级: 'json:data;title;cover;sub_title;book_id;video_desc',
    二级: $js.toString(() => {
        let kjson = JSON.parse(fetch(input));
        let kurl = kjson.data.map((it) => {
            return it.title + '$' + it.video_id
        });
        VOD = {
            vod_id: kjson.book_id,
            vod_name: kjson.book_name,
            type_name: kjson.category,
            vod_pic: kjson.book_pic,
            vod_remarks: `更新至${kjson.total}集`,
            vod_year: kjson.time.split('-')[0],
            vod_area: '中国',
            vod_lang: '国语',
            vod_director: kjson.author,
            vod_actor: `片长${kjson.duration}`,
            vod_content: kjson.desc,
            vod_play_from: '甜圈专线',
            vod_play_url: kurl.join("#")
        }
    }),
    搜索: '*;*;*;type;*;intro',
    play_parse: true,
    lazy: $js.toString(() => {
        let video_id = input;
        let qualities = ['1080p', '720p', '480p', '360p'];
        let xingzhige_url = '';
        for (let i = 0; i < qualities.length; i++) {
            let quality = qualities[i];
            let api_url = 'https://api.xingzhige.com/API/playlet/?video_id=' + video_id + '&quality=' + quality;
            try {
                let html = request(api_url, {
                    headers: {
                        'User-Agent': 'okhttp/3.12.11',
                        'Content-Type': 'application/json; charset=utf-8'
                    }
                });
                let data = JSON.parse(html);
                if (data && data.data && data.data.video && data.data.video.url) {
                    xingzhige_url = data.data.video.url;
                    break;
                }
            } catch (e) {
                continue;
            }
        }
        let urls = [];
        if (xingzhige_url) {
            urls.push("星之阁API", xingzhige_url);
        }

        let qualities_all = ['1080p', '720p'];
        qualities_all.forEach(quality => {
            let baseUrl = `https://mov.cenguigui.cn/duanju/api.php?video_id=${video_id}&type=mp4`;
            let url = baseUrl + '&level=' + quality;
            let label = `甜圈直连-${quality}`;
            urls.push(label, url);
        });

        let baseUrl1 = `${HOST}/api/duanju/api.php?video_id=${input}&type=mp4`;
        urls.push("甜圈API", baseUrl1);

        input = {
            parse: 0,
            url: urls
        };
    }),
}