import req from '../../util/req.js';
import {MOBILE_UA, PC_UA} from '../../util/misc.js';
import {load} from 'cheerio';


// let url = 'https://zh.stripchatgirls.com';
let url = 'https://zh.superchat.live/';

async function request(reqUrl) {
    let resp = await req.get(reqUrl, {
        headers: {
            'Accept-Language': 'zh-CN,zh;q=0.8',
            'User-Agent': MOBILE_UA,
        },
    });
    return resp.data;
}

async function init(inReq, _outResp) {
    return {}
}

async function home(inReq, _outResp) {
    let classes = [{"type_id": 1, "type_name": "直播"}];
    return JSON.stringify({
        class: classes
    });
}


async function category(inReq, _outResp) {
    const html = await request('https://zh.stripchatgirls.com/api/front/v2/models?limit=20&topLimit=2000&favoritesLimit=12&primaryTag=girls');
    let videos = [];
    let j = 0;
    let blocks = html['blocks'];
    while(j<blocks.length){
        let i = 0;
        for(const list of blocks[j]['models']){
            if(i<blocks[j]['models'].length){
                videos.push({
                    vod_id: list['hlsPlaylist'],
                    vod_name: list['username'],
                    vod_pic:list['previewUrlThumbBig'],
                });
                i++;
            }
        }
        j++;
    }
    return JSON.stringify({
        list: videos,
    });
}

async function detail(inReq, _outResp) {
    const id = inReq.body.id;
    let vod = {};
    let playFroms = [];
    let playUrls = [];
    const temp = [];
    playFroms.push('不知道倾情打造');
    const playUrl = 'https://b-hls-14.doppiocdn.net/hls/'+id.split('/')[4]+'/'+id.split('/')[4]+'.m3u8';
    temp.push('不知道带你看美女😎'+'$'+playUrl);
    playUrls.push(temp.join('#'));
    vod.vod_play_from = playFroms.join('$$$');
    vod.vod_play_url = playUrls.join('$$$');
    return JSON.stringify({
        list: [vod],
    });
}

async function play(inReq, _outResp) {
    const id = inReq.body.id;
    return JSON.stringify({
        parse: 0,
        url: id,
    });
}


async function search(inReq, _outResp) {
    return{}
}

async function test(inReq, outResp) {
    try {
        const printErr = function (json) {
            if (json.statusCode && json.statusCode == 500) {
                console.error(json);
            }
        };
        const prefix = inReq.server.prefix;
        const dataResult = {};
        let resp = await inReq.server.inject().post(`${prefix}/init`);
        dataResult.init = resp.json();
        printErr(resp.json());
        resp = await inReq.server.inject().post(`${prefix}/home`);
        dataResult.home = resp.json();
        printErr(resp.json());
         if (dataResult.home.class.length > 0) {
            resp = await inReq.server.inject().post(`${prefix}/category`).payload({
                id: dataResult.home.class[0].type_id,
                page: 1,
                filter: true,
                filters: {},
            });
            dataResult.category = resp.json();
            printErr(resp.json());
            if (dataResult.category.list.length > 0) {
                resp = await inReq.server.inject().post(`${prefix}/detail`).payload({
                    id: dataResult.category.list[0].vod_id, // dataResult.category.list.map((v) => v.vod_id),
                });
                dataResult.detail = resp.json();
                printErr(resp.json());
                if (dataResult.detail.list.length > 0) {
                    dataResult.play = [];
                    for (const vod of dataResult.detail.list) {
                        const flags = vod.vod_play_from.split('$$$');
                        const ids = vod.vod_play_url.split('$$$');
                        for (let j = 0; j < flags.length; j++) {
                            const flag = flags[j];
                            const urls = ids[j].split('#');
                            for (let i = 0; i < urls.length && i < 2; i++) {
                                resp = await inReq.server
                                    .inject()
                                    .post(`${prefix}/play`)
                                    .payload({
                                        flag: flag,
                                        id: urls[i].split('$')[1],
                                    });
                                dataResult.play.push(resp.json());
                            }
                        }
                    }
                }
            }
        }
        resp = await inReq.server.inject().post(`${prefix}/search`).payload({
            wd: '爱',
            page: 1,
        });
        dataResult.search = resp.json();
        printErr(resp.json());
        return dataResult;
    } catch (err) {
        console.error(err);
        outResp.code(500);
        return {err: err.message, tip: 'check debug console output'};
    }
}

export default {
    meta: {
        key: 'sc',
        name: 'script直播',
        type: 3,
    },
    api: async (fastify) => {
        fastify.post('/init', init);
        fastify.post('/home', home);
        fastify.post('/category', category);
        fastify.post('/detail', detail);
        fastify.post('/play', play);
        fastify.post('/search', search);
        fastify.get('/test', test);
    },
};