var rule = {
    title: '919体育直播',
    host: 'https://01cs01.fusk39cd.com',
    url: '/api/web/live_lists/fyclass',
    searchUrl: '',
    searchable: 0,
    quickSearch: 0,
    filterable: 0,
    headers: {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',
        'Accept': 'application/json, text/plain, */*',
        'Referer': 'https://01cs01.fusk39cd.com/'
    },
    timeout: 5000,
    class_name: '全部&足球&篮球',
    class_url: '1&2&3',
    play_parse: true,
    
    一级: $js.toString(() => {
        let items = [];
        let html = request(input);
        let json = JSON.parse(html);
        let list = (json.data && json.data.data) ? json.data.data : [];

        list.forEach(it => {
            let viewers = it.viewer > 10000 ? (it.viewer / 10000).toFixed(1) + 'w' : (it.viewer || 0);
            let title = (it.home_team_zh || '未知') + ' VS ' + (it.away_team_zh || '未知');
            
            let type = it.type || (input.includes('/2') ? '2' : (input.includes('/3') ? '3' : '1'));
            let match_id = it.match_id || it.tournament_id || '0';
            let member_id = it.member_id || it.uid || '0';
            
            let detailParams = type + '$' + match_id + '$' + member_id;
            
            items.push({
                title: title,
                img: it.cover || it.home_logo || it.away_logo,
                desc: '🔥' + viewers + ' | ' + (it.league_name_zh || '体育') + ' | ' + (it.nickname || '主播'),
                url: detailParams
            });
        });
        setResult(items);
    }),

    二级: $js.toString(() => {
        let params = orId.split('$');
        let type = params[0];
        let mid = params[1];
        let uid = params[2];
        
        let detailUrl = rule.host + '/api/web/live_lists/' + type + '/detail/' + mid + '?member_id=' + uid;
        
        let html = request(detailUrl, {
            headers: {
                'Referer': rule.host + '/live/' + mid + '/' + type + '/' + uid
            }
        });
        
        let jo = JSON.parse(html);
        VOD = {};

        if (jo.code === 200 && jo.data && jo.data.detail) {
            let detail = jo.data.detail;
            let more = jo.data.more || [];

            VOD = {
                vod_name: (detail.home_team_zh || '未知') + ' VS ' + (detail.away_team_zh || '未知'),
                vod_pic: detail.cover || detail.home_logo || '',
                type_name: detail.league_name_zh || '体育直播',
                vod_remarks: '🔥人气: ' + (detail.viewer || 0) + ' | 比分: ' + (detail.home_score || 0) + '-' + (detail.away_score || 0) + (detail.on_time ? ' (' + detail.on_time + ')' : ''),
                vod_content: '赛事公告: ' + (detail.room_notice || detail.room_notice_new || '精彩赛事，不容错过'),
                vod_actor: detail.nickname || detail.username || '体育主播'
            };

            let extractLinks = (obj, defaultName) => {
                let urls = [];
                let streamFields = [
                    { keys: ['screen_url_m3u8', 'screen_url_m3u8', 'stream_m3u8', 'm3u8_url'], name: 'M3U8' },
                    { keys: ['stream', 'stream_url', 'pull_stream_url'], name: '高清FLV' },
                    { keys: ['url_flv', 'flv_url', 'screen_url'], name: 'FLV' },
                    { keys: ['url', 'live_url', 'play_url'], name: '备用' }
                ];

                streamFields.forEach(field => {
                    for (let key of field.keys) {
                        if (obj[key] && typeof obj[key] === 'string' && obj[key].length > 10) {
                            let link = obj[key];
                            if (link.startsWith('//')) link = 'https:' + link;
                            if (!urls.some(u => u.split('$')[1] === link)) {
                                urls.push(field.name + '$' + link);
                            }
                            break;
                        }
                    }
                });

                return urls.filter((item, index, self) => 
                    index === self.findIndex(t => t.split('$')[1] === item.split('$')[1])
                ).join('#');
            };

            let playSources = [];
            let playUrls = [];

            let mainStream = extractLinks(detail);
            if (mainStream) {
                playSources.push(detail.nickname || detail.username || '主信号');
                playUrls.push(mainStream);
            }

            more.forEach((m, index) => {
                let streamData = { ...detail, ...m };
                let s = extractLinks(streamData);
                if (s) {
                    let anchorName = m.nickname || m.username || '信号' + (index + 2);
                    if (!playSources.includes(anchorName)) {
                        playSources.push(anchorName);
                        playUrls.push(s);
                    }
                }
            });

            if (playUrls.length === 0) {
                let fallbackUrls = [];
                let possibleUrls = [
                    detail.screen_url_m3u8,
                    detail.stream,
                    detail.url_flv,
                    detail.screen_url,
                    detail.url
                ];
                
                possibleUrls.forEach((url, idx) => {
                    if (url && url.length > 10) {
                        if (url.startsWith('//')) url = 'https:' + url;
                        let names = ['M3U8', '高清FLV', 'FLV', '高清', '备用'];
                        fallbackUrls.push(names[idx] + '$' + url);
                    }
                });
                
                if (fallbackUrls.length > 0) {
                    playSources.push('默认线路');
                    playUrls.push(fallbackUrls.join('#'));
                }
            }

            if (playSources.length > 0) {
                VOD.vod_play_from = playSources.join('$$$');
                VOD.vod_play_url = playUrls.join('$$$');
            } else {
                VOD.vod_content = '暂无直播信号';
            }
            
            if (detail.home_score !== undefined && detail.away_score !== undefined) {
                VOD.vod_remarks += ' | 比分 ' + detail.home_score + '-' + detail.away_score;
                if (detail.on_time) {
                    VOD.vod_remarks += ' (' + detail.on_time + ')';
                }
            }
            
        } else {
            VOD = { 
                vod_name: '赛事已结束', 
                vod_content: '未获取到直播数据',
                vod_remarks: '暂无信号'
            };
        }
    }),

    搜索: '*'
};