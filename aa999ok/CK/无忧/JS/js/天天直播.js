import req from '../../util/req.js';
import { PC_UA } from '../../util/misc.js';
import { load } from 'cheerio';
import pkg from 'lodash';

const { _ } = pkg;

let url = 'https://yyrzb01.vip';

async function request(reqUrl) {
    let resp = await req.get(reqUrl, {
        headers: {
            'User-Agent': PC_UA,
        },
    });
    return resp.data;
}

async function init(_inReq, _outResp) {
    return {};
}

async function home(_inReq, _outResp) {
    var html = await request(url);
    const $ = load(html);
    let classes = [];
    for (const a of $('div.top-grid a[href*="/zb/"]')) {
        const name = $(a).find('font')[0];
            classes.push({
                type_id: a.attribs.href,
                type_name: name.children[0].data
            });
    }
    return {
        class: classes,
    };
}

async function category(inReq, _outResp) {
    const tid = inReq.body.id;
    const html = await request(`${url}${tid}`);
    const $ = load(html);
    const items = $('div.item');
    let videos = items.map((_, item)=> {
        const it = $(item).find('a:first')[0];
        const img = $(item).find('img:first')[0];
        return {
            vod_id: it.attribs.href,
            vod_name: it.attribs.title,
            vod_pic: img.attribs['data-original'],
        };
    }).get();
    return JSON.stringify({
        list: videos,
    });
}

async function detail(inReq, _outResp) {
    const id = inReq.body.id;
    const html = await request(url+id);
    const $ = load(html);
    const play_list = html.match(/<iframe .*src="(.*?)"><\/iframe>/)[1];
    const playUrl = play_list.split('=')[1]+'.m3u8';
    let vod = {
        vod_id: id,
        vod_name: $('h1').text().trim(),
        vod_type: '直播啦！',
        vod_content: "免费资源请勿贩卖",
    }
    let playFroms = [];
    let playUrls = [];
    const temp = [];
    playFroms.push('由不知道倾情打造');
    temp.push('不知道带你看美女'+'$'+playUrl);
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
    const tid = inReq.body.id;
    const html = await request(`${url}${tid}`);
    const $ = load(html);
    const items = $('div.item');
    let videos = items.map((_, item)=> {
        const it = $(item).find('a:first')[0];
        const img = $(item).find('img:first')[0];
        return {
            vod_id: it.attribs.href,
            vod_name: it.attribs.title,
            vod_pic: img.attribs['data-original'],
        };
    }).get();
    return JSON.stringify({
        list: videos,
    });
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
                if (dataResult.detail.list && dataResult.detail.list.length > 0) {
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
        return { err: err.message, tip: 'check debug console output' };
    }
}

export default {
    meta: {
        key: 'ttzb',
        name: '天天直播',
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
