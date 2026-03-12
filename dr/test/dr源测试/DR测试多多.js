// DJ多多APP - drpy2规则 (完整确定版)
// 添加详细日志调试

const DJ_HOST1 = 'https://new.djduoduo.com';
const DJ_HOST2 = 'http://bdcdn.djduoduo.com';
const DJ_HOST3 = 'http://hscdn.dianyinduoduo.com';

const DJ_CKEY = 'e82a4a775c295bbbe33f66828a368b90';
const DJ_CIV = '8477d5a085c1d50d8a74811ec3e811e4';
const DJ_DKEY = 'e4fd094dfcae98f352ddf81ee760d891';
const DJ_DIV = '932ea49cfff68382f0516ccc63a52123';

const DJ_EXTRA = {
    "VerCode": 3966,
    "Ver": "3.9.66",
    "Channel": "Car",
    "Platform": "Android",
    "OSVer": 31,
    "Did": "120611636433",
    "AppId": 128,
    "Ts": 0,
    "VTs": 0
};

// 全局函数注册
globalThis.DJEncrypt = function(str) {
    let key = CryptoJS.enc.Hex.parse(DJ_CKEY);
    let iv = CryptoJS.enc.Hex.parse(DJ_CIV);
    return CryptoJS.AES.encrypt(str, key, {
        iv: iv,
        mode: CryptoJS.mode.CBC,
        padding: CryptoJS.pad.Pkcs7
    }).toString();
};

globalThis.DJDecrypt = function(str) {
    try {
        let key = CryptoJS.enc.Hex.parse(DJ_DKEY);
        let iv = CryptoJS.enc.Hex.parse(DJ_DIV);
        let decrypted = CryptoJS.AES.decrypt(str, key, {
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        });
        return decrypted.toString(CryptoJS.enc.Utf8);
    } catch(e) {
        log('DJDecrypt失败: ' + e.message + ', 输入: ' + str);
        return '';
    }
};

globalThis.DJGetData = function(path, dataObj) {
    let data = encodeURIComponent(DJEncrypt(JSON.stringify(dataObj)));
    let extra = encodeURIComponent(DJEncrypt(JSON.stringify(DJ_EXTRA)));
    let url = DJ_HOST1 + path + '&data=' + data + '&extra=' + extra;
    try {
        return JSON.parse(request(url, {headers: {'User-Agent': 'MOBILE_UA'}}));
    } catch(e) {
        log('DJGetData失败: ' + e.message);
        return {};
    }
};

globalThis.DJGetImg = function(item) {
    if (!item.Cover) return 'https://icdn.binmt.cc/2506/6847a82912a35.png';
    let id1 = String(item.Id).slice(-3);
    return item.Cover.indexOf('/dj/') >= 0 ? DJ_HOST2 + item.Cover : DJ_HOST2 + '/dj/cover/' + id1 + '/150/' + item.Cover;
};

globalThis.DJGetSonglistImg = function(item) {
    if (!item.Cover) return '';
    return item.Cover.indexOf('/dj/') >= 0 ? DJ_HOST2 + item.Cover : DJ_HOST2 + '/img/songlist/cover/' + String(item.Id).slice(-3) + '/150/' + item.Cover;
};

globalThis.DJGetVideoImg = function(item) {
    return DJ_HOST2 + '/v/cover/' + String(item.Id).slice(-3) + '/150/' + item.Cover;
};

// 构建音频URL（带解密）
globalThis.DJBuildAudioUrl = function(songId, path) {
    log('DJBuildAudioUrl 输入: songId=' + songId + ', path=' + path);
    let id1 = String(songId).slice(-3);
    let decryptedPath = DJDecrypt(path);
    log('DJBuildAudioUrl 解密后: ' + decryptedPath);
    if (!decryptedPath) return '';
    return DJ_HOST2 + '/dj/' + id1 + '/' + decryptedPath;
};

// 构建视频URL（带解密）
globalThis.DJBuildVideoUrl = function(vid, path) {
    log('DJBuildVideoUrl 输入: vid=' + vid + ', path=' + path);
    let id1 = String(vid).slice(-3);
    if (path.indexOf('.') >= 0) {
        return DJ_HOST3 + '/v/480p/' + id1 + '/' + path;
    }
    let decryptedPath = DJDecrypt(path);
    log('DJBuildVideoUrl 解密后: ' + decryptedPath);
    if (!decryptedPath) return '';
    return DJ_HOST3 + '/v/480p/' + id1 + '/' + decryptedPath;
};

var rule = {
    title: 'DJ多多',
    host: DJ_HOST1,
    url: 'js:',
    detailUrl: 'js:',
    searchUrl: 'js:',
    searchable: 2,
    quickSearch: 1,
    filterable: 0,
    headers: {'User-Agent': 'MOBILE_UA'},
    timeout: 5000,
    class_name: '热歌&3D&电音&车载&无损&新歌&原创&中文&伤感&铃声&老歌&DJ&歌单&频道&乐库&视频&排行',
    class_url: 'hot_v2&100&105&104&sq&new&ori&107&103&109&108&101&songlist&channel&yueku&video&rank',

    推荐: `js:
        let d = [];
        let html = DJGetData('/v4/getlist.php?act=hot_v2', {'PageNo': 0});
        if (html.List) {
            html.List.forEach(function(item) {
                d.push({
                    title: item.Name,
                    desc: (item.User || '未知') + ' • ' + (item.Duration / 60).toFixed(2) + '分 • 播放' + (item.PlCntAll || 0),
                    pic_url: DJGetImg(item),
                    url: item.Id + '#' + item.Path
                });
            });
        }
        setResult(d);
    `,

    一级: `js:
        let d = [];
        let page = parseInt(MY_PAGE) - 1;
        let tid = MY_CATE;
        
        if (tid === 'songlist') {
            let html = DJGetData('/v4/getlist.php?act=hot_songlist', {'PageNo': page});
            if (html.List) {
                html.List.forEach(function(item) {
                    d.push({
                        title: item.Name,
                        desc: '歌单',
                        pic_url: DJGetSonglistImg(item),
                        url: 'songlist#' + item.Id
                    });
                });
            }
        }
        else if (tid === 'channel') {
            let html = DJGetData('/v4/getlist.php?act=chnlist', {'Id': 2});
            if (html.List) {
                html.List.forEach(function(item) {
                    d.push({
                        title: item.Name,
                        desc: '频道',
                        pic_url: DJ_HOST2 + item.Cover,
                        url: 'channel#' + item.Id
                    });
                });
            }
        }
        else if (tid === 'yueku') {
            let html = DJGetData('/v4/getlist.php?act=cat', {'Id': 1, 'PageNo': page, 'Type': 'Up'});
            if (html.List) {
                html.List.forEach(function(item) {
                    d.push({
                        title: item.Name,
                        desc: (item.User || '未知') + ' • ' + (item.Duration / 60).toFixed(2) + '分',
                        pic_url: DJGetImg(item),
                        url: item.Id + '#' + item.Path
                    });
                });
            }
        }
        else if (tid === 'video') {
            let html = DJGetData('/v4/getlist.php?act=new_svideo', {'PageNo': page});
            if (html.List) {
                html.List.forEach(function(item) {
                    d.push({
                        title: item.Desc || '视频',
                        desc: 'DJ视频',
                        pic_url: DJGetVideoImg(item),
                        url: 'video#' + item.Id + '#' + item.Path
                    });
                });
            }
        }
        else if (tid === 'rank') {
            let html = DJGetData('/v4/getlist.php?act=rank_detail', {'Id': 100, 'PageNo': page});
            if (html.List) {
                html.List.forEach(function(item) {
                    d.push({
                        title: item.Name,
                        desc: (item.User || '未知') + ' • 播放' + (item.PlCntAll || 0),
                        pic_url: DJGetImg(item),
                        url: item.Id + '#' + item.Path
                    });
                });
            }
        }
        else {
            let act = /^[0-9]/.test(tid) ? 'homechn' : tid;
            let data1 = /^[0-9]/.test(tid) ? {'Id': parseInt(tid), 'PageNo': page} : {'PageNo': page};
            let html = DJGetData('/v4/getlist.php?act=' + act, data1);
            if (html.List) {
                html.List.forEach(function(item) {
                    d.push({
                        title: item.Name,
                        desc: (item.User || '未知') + ' • ' + (item.Duration / 60).toFixed(2) + '分 • 播放' + (item.PlCntAll || 0),
                        pic_url: DJGetImg(item),
                        url: item.Id + '#' + item.Path
                    });
                });
            }
        }
        setResult(d);
    `,

    // 二级 - 使用 $js.toString 模式
    二级: $js.toString(() => {
        let id = orId;
        log('========== 二级开始 ==========');
        log('orId: ' + orId);
        
        // 歌单详情
        if (id.indexOf('songlist#') === 0) {
            let songlistId = id.split('#')[1];
            log('歌单ID: ' + songlistId);
            let html = DJGetData('/v4/getlist.php?act=songlistdetail', {'Id': parseInt(songlistId), 'PageNo': 0});
            
            if (html.List && html.List.length > 0) {
                let playUrls = html.List.map(function(item) {
                    return item.Name + '$' + item.Id + '#' + item.Path;
                }).join('#');
                
                VOD = {
                    vod_name: '歌单列表',
                    vod_play_from: 'DJ多多',
                    vod_content: '共' + html.List.length + '首歌曲',
                    vod_play_url: playUrls
                };
                log('歌单VOD: ' + JSON.stringify(VOD));
            } else {
                VOD = {
                    vod_name: '空歌单',
                    vod_play_from: 'DJ多多',
                    vod_content: '暂无歌曲',
                    vod_play_url: '暂无$#'
                };
            }
        }
        // 频道详情
        else if (id.indexOf('channel#') === 0) {
            let channelId = id.split('#')[1];
            log('频道ID: ' + channelId);
            let html = DJGetData('/v4/getlist.php?act=chn', {'Id': channelId, 'PageNo': 0, 'Type': 'Hot'});
            
            if (html.List && html.List.length > 0) {
                let playUrls = html.List.map(function(item) {
                    return item.Name + '$' + item.Id + '#' + item.Path;
                }).join('#');
                
                VOD = {
                    vod_name: '频道列表',
                    vod_play_from: 'DJ多多',
                    vod_content: '共' + html.List.length + '首歌曲',
                    vod_play_url: playUrls
                };
                log('频道VOD: ' + JSON.stringify(VOD));
            } else {
                VOD = {
                    vod_name: '空频道',
                    vod_play_from: 'DJ多多',
                    vod_content: '暂无歌曲',
                    vod_play_url: '暂无$#'
                };
            }
        }
        // 视频
        else if (id.indexOf('video#') === 0) {
            log('视频: ' + id);
            VOD = {
                vod_name: 'DJ视频',
                vod_play_from: 'DJ多多',
                vod_content: '',
                vod_play_url: '播放$' + id
            };
        }
        // 普通歌曲
        else if (id.indexOf('#') > 0) {
            log('普通歌曲: ' + id);
            VOD = {
                vod_name: 'DJ音乐',
                vod_play_from: 'DJ多多',
                vod_content: '',
                vod_play_url: '播放$' + id
            };
        }
        else {
            log('未知类型: ' + id);
            VOD = {
                vod_name: '未知',
                vod_play_from: 'DJ多多',
                vod_content: '无法识别的ID: ' + id,
                vod_play_url: '错误$#'
            };
        }
        log('========== 二级结束 ==========');
    }),

    搜索: `js:
        let d = [];
        let html = DJGetData('/v4/search.php?act=sch', {
            'Query': KEY,
            'From': 'HotSearch',
            'Uid': 9447509,
            'PageNo': 0
        });
        if (html.List) {
            html.List.forEach(function(item) {
                d.push({
                    title: item.Name,
                    desc: (item.User || '未知') + ' • ' + (item.Duration / 60).toFixed(2) + '分 • 播放' + (item.PlCntAll || 0),
                    pic_url: DJGetImg(item),
                    url: item.Id + '#' + item.Path
                });
            });
        }
        setResult(d);
    `,

    // lazy - 带详细日志
    lazy: $js.toString(() => {
        log('========== lazy开始 ==========');
        log('input: ' + input);
        
        let id = input;
        
        // 处理 vod_play_url 格式：集名$链接
        if (id.indexOf('$') >= 0) {
            let parts = id.split('$');
            log('分割后: ' + JSON.stringify(parts));
            id = parts[1]; // 取链接部分
        }
        
        log('处理后ID: ' + id);
        
        let realUrl = '';
        
        // 视频格式: video#id#path
        if (id.indexOf('video#') === 0) {
            let parts = id.split('#');
            log('视频ID分割: ' + JSON.stringify(parts));
            if (parts.length >= 3) {
                realUrl = DJBuildVideoUrl(parts[1], parts[2]);
            }
        }
        // 音频格式: id#path
        else if (id.indexOf('#') > 0) {
            let parts = id.split('#');
            log('音频ID分割: ' + JSON.stringify(parts));
            if (parts.length >= 2) {
                realUrl = DJBuildAudioUrl(parts[0], parts[1]);
            }
        }
        
        log('最终URL: ' + realUrl);
        log('========== lazy结束 ==========');
        
        input = realUrl ? 
            {parse: 0, url: realUrl, header: {'User-Agent': 'MOBILE_UA'}} : 
            {parse: 0, url: 'http://localhost/error.mp3', header: {}};
    })
}