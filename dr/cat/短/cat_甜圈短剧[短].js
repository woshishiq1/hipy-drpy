/**
 * 甜圈短剧
 * @header({
 searchable: 1,
 filterable: 1,
 quickSearch: 1,
 '类型': '短剧',
 title: '甜圈短剧[短]',
 lang: 'cat'
 })
 */

class Spider extends BaseSpider {

    constructor() {
        super();
        this.host = 'https://mov.cenguigui.cn';
        this.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36',
            'Referer': 'https://mov.cenguigui.cn/'
        };
    }

    init(extend = '') {
        return '';
    }

    getName() {
        return '甜圈短剧';
    }

    isVideoFormat(url) {
        return true;
    }

    manualVideoCheck() {
        return false;
    }

    destroy() {
    }

    homeContent(filter) {
        const classes = [
            {'type_id': '逆袭', 'type_name': '🎬 逆袭'},
            {'type_id': '霸总', 'type_name': '🎬 霸总'},
            {'type_id': '现代言情', 'type_name': '🎬 现代言情'},
            {'type_id': '打脸虐渣', 'type_name': '🎬 打脸虐渣'},
            {'type_id': '豪门恩怨', 'type_name': '🎬 豪门恩怨'},
            {'type_id': '神豪', 'type_name': '🎬 神豪'},
            {'type_id': '马甲', 'type_name': '🎬 马甲'},
            {'type_id': '都市日常', 'type_name': '🎬 都市日常'},
            {'type_id': '战神归来', 'type_name': '🎬 战神归来'},
            {'type_id': '小人物', 'type_name': '🎬 小人物'},
            {'type_id': '女性成长', 'type_name': '🎬 女性成长'},
            {'type_id': '大女主', 'type_name': '🎬 大女主'},
            {'type_id': '穿越', 'type_name': '🎬 穿越'},
            {'type_id': '都市修仙', 'type_name': '🎬 都市修仙'},
            {'type_id': '强者回归', 'type_name': '🎬 强者回归'},
            {'type_id': '亲情', 'type_name': '🎬 亲情'},
            {'type_id': '古装', 'type_name': '🎬 古装'},
            {'type_id': '重生', 'type_name': '🎬 重生'},
            {'type_id': '闪婚', 'type_name': '🎬 闪婚'},
            {'type_id': '赘婿逆袭', 'type_name': '🎬 赘婿逆袭'},
            {'type_id': '虐恋', 'type_name': '🎬 虐恋'},
            {'type_id': '追妻', 'type_name': '🎬 追妻'},
            {'type_id': '天下无敌', 'type_name': '🎬 天下无敌'},
            {'type_id': '家庭伦理', 'type_name': '🎬 家庭伦理'},
            {'type_id': '萌宝', 'type_name': '🎬 萌宝'},
            {'type_id': '古风权谋', 'type_name': '🎬 古风权谋'},
            {'type_id': '职场', 'type_name': '🎬 职场'},
            {'type_id': '奇幻脑洞', 'type_name': '🎬 奇幻脑洞'},
            {'type_id': '异能', 'type_name': '🎬 异能'},
            {'type_id': '无敌神医', 'type_name': '🎬 无敌神医'},
            {'type_id': '古风言情', 'type_name': '🎬 古风言情'},
            {'type_id': '传承觉醒', 'type_name': '🎬 传承觉醒'},
            {'type_id': '现言甜宠', 'type_name': '🎬 现言甜宠'},
            {'type_id': '奇幻爱情', 'type_name': '🎬 奇幻爱情'},
            {'type_id': '乡村', 'type_name': '🎬 乡村'},
            {'type_id': '历史古代', 'type_name': '🎬 历史古代'},
            {'type_id': '王妃', 'type_name': '🎬 王妃'},
            {'type_id': '高手下山', 'type_name': '🎬 高手下山'},
            {'type_id': '娱乐圈', 'type_name': '🎬 娱乐圈'},
            {'type_id': '强强联合', 'type_name': '🎬 强强联合'},
            {'type_id': '破镜重圆', 'type_name': '🎬 破镜重圆'},
            {'type_id': '暗恋成真', 'type_name': '🎬 暗恋成真'},
            {'type_id': '民国', 'type_name': '🎬 民国'},
            {'type_id': '欢喜冤家', 'type_name': '🎬 欢喜冤家'},
            {'type_id': '系统', 'type_name': '🎬 系统'},
            {'type_id': '真假千金', 'type_name': '🎬 真假千金'},
            {'type_id': '龙王', 'type_name': '🎬 龙王'},
            {'type_id': '校园', 'type_name': '🎬 校园'},
            {'type_id': '穿书', 'type_name': '🎬 穿书'},
            {'type_id': '女帝', 'type_name': '🎬 女帝'},
            {'type_id': '团宠', 'type_name': '🎬 团宠'},
            {'type_id': '年代爱情', 'type_name': '🎬 年代爱情'},
            {'type_id': '玄幻仙侠', 'type_name': '🎬 玄幻仙侠'},
            {'type_id': '青梅竹马', 'type_name': '🎬 青梅竹马'},
            {'type_id': '悬疑推理', 'type_name': '🎬 悬疑推理'},
            {'type_id': '皇后', 'type_name': '🎬 皇后'},
            {'type_id': '替身', 'type_name': '🎬 替身'},
            {'type_id': '大叔', 'type_name': '🎬 大叔'},
            {'type_id': '喜剧', 'type_name': '🎬 喜剧'},
            {'type_id': '剧情', 'type_name': '🎬 剧情'}
        ];

        return {
            class: classes,
            filters: {}
        };
    }

    homeVideoContent() {
        return this.categoryContent('逆袭', 1);
    }

    async categoryContent(tid, pg, filter, extend) {
        try {
            const page = parseInt(pg) || 1;
            const offset = (page - 1) * 13;

            // 构建查询参数
            const params = {
                classname: tid,
                offset: offset.toString()
            };

            const queryString = new URLSearchParams(params).toString();
            const url = `${this.host}/duanju/api.php?${queryString}`;

            const response = await this.fetch(url, {}, this.headers);
            const json = response.data || {};
            const data = json.data || [];

            const videos = [];
            for (const k of data) {
                videos.push({
                    vod_id: k.book_id,
                    vod_name: k.title,
                    vod_pic: k.cover,
                    vod_remarks: `${k.episode_cnt || '未知'}集 | ⭐${k.score || '0'}`
                });
            }

            return {
                list: videos,
                page: page,
                pagecount: 999,
                limit: 20,
                total: 9999
            };

        } catch (error) {
            console.error(`categoryContent error: ${error.message}`);
            return {
                list: [],
                page: pg,
                pagecount: 0,
                limit: 20,
                total: 0
            };
        }
    }

    async detailContent(ids) {
        try {
            const id = ids[0];
            const params = {
                book_id: id
            };
            const queryString = new URLSearchParams(params).toString();
            const url = `${this.host}/duanju/api.php?${queryString}`;

            const response = await this.fetch(url, {}, this.headers);
            const json = response.data || {};

            const play_urls = [];
            if (json.data && Array.isArray(json.data)) {
                for (const i of json.data) {
                    play_urls.push(`${i.title}$${i.video_id}`);
                }
            }

            const vod = {
                vod_id: id,
                vod_name: json.title,
                type_name: json.category,
                vod_year: json.time,
                vod_remarks: `共${json.episode_cnt || ''}集`,
                vod_content: json.desc || '暂无简介',
                vod_play_from: '甜圈播放',
                vod_play_url: play_urls.join('#')
            };

            return {list: [vod]};

        } catch (error) {
            console.error(`detailContent error: ${error.message}`);
            return {list: []};
        }
    }

    async searchContent(key, quick, pg = '1') {
        return this.categoryContent(key, pg);
    }

    async playerContent(flag, id, vipFlags) {
        try {
            const params = {
                video_id: id
            };
            const queryString = new URLSearchParams(params).toString();
            const url = `${this.host}/duanju/api.php?${queryString}&type=mp4`;
            // console.log('url:', url);
            const response = await this.fetch(url, {redirect: false}, this.headers);
            // console.log(response.headers);
            if (response.headers && response.headers.location) {
                return {
                    parse: 0,
                    url: response.headers.location + '#.mp4',
                    header: {
                        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36',
                    }
                };
            }

        } catch (error) {
            console.error(`playerContent error: ${error.message}`);
            return {parse: 0, url: ''};
        }
    }

    localProxy(param) {
        return null;
    }
}

export default new Spider();