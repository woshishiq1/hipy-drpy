const axios = require("axios");

const meta = {
    key: "emby_xiaoya",         
    name: "Emby小雅",           
    type: 4,                    
    api: "/video/emby_xiaoya",  
    searchable: 1,              
    quickSearch: 1,             
    filterable: 1,             
    changeable: 0,              
};

const config = {
    host: 'http://122.193.52.79:8899', 
    userId: "40a02f8503ce4de49d58331a282dcea1",
    token: "e766b6fff4f14f089f01d8a06f5da1de",
    deviceId: "ea27caf7-9a51-4209-b1a5-374bf30c2ffd",
    clientVersion: "4.9.0.31"
};

const deviceProfile = {
    DeviceProfile: {
        MaxStaticBitrate: 140000000,
        MaxStreamingBitrate: 140000000,
        DirectPlayProfiles: [
            { Container: 'mp4,mkv,webm', Type: 'Video', VideoCodec: 'h264,h265,av1,vp9', AudioCodec: 'aac,mp3,opus,flac' },
            { Container: 'mp3,aac,flac,opus', Type: 'Audio' },
        ],
        TranscodingProfiles: [
            { Container: 'mp4', Type: 'Video', VideoCodec: 'h264', AudioCodec: 'aac', Context: 'Streaming', Protocol: 'http' },
        ],
    },
};

async function _request(url, options = {}) {
    try {
        const response = await axios({
            url,
            method: options.method || 'GET',
            data: options.body,
            headers: {
                'X-Emby-Token': config.token,
                'X-Emby-Client': 'Emby Web',
                'X-Emby-Device-Id': config.deviceId,
                'X-Emby-Client-Version': config.clientVersion,
                'Content-Type': 'application/json',
                ...options.headers,
            },
            timeout: 15000,
        });
        return response.data;
    } catch (err) {
        return null;
    }
}

const buildUrl = (path, params = {}) => {
    const baseUrl = path.startsWith('/emby') ? path : `/emby${path}`;
    const url = new URL(`${config.host}${baseUrl}`);
    Object.entries(params).forEach(([k, v]) => {
        if (v !== undefined && v !== null && v !== '') url.searchParams.append(k, v);
    });
    return url.toString();
};

const extractVideos = (items, width = 300) => {
    return (items || []).map((i) => {
        let remarks = i.ProductionYear ? `${i.ProductionYear}` : '';
        if (i.CommunityRating) remarks += ` · ⭐${i.CommunityRating.toFixed(1)}`;
        if (i.Type === 'Folder') remarks = '目录';

        return {
            vod_id: i.Id,
            vod_name: i.Name,
            vod_pic: buildUrl(`/Items/${i.Id}/Images/Primary`, { maxWidth: width, tag: i.ImageTags?.Primary }),
            vod_remarks: remarks,
            tag: (i.Type === 'Folder' || i.Type === 'CollectionFolder' || i.Type === 'UserView') ? 'folder' : 'video'
        };
    });
};

async function _home() {
    const classJson = await _request(buildUrl(`/Users/${config.userId}/Views`));
    const classes = (classJson?.Items || [])
        .filter(i => !/播放列表|相机/.test(i.Name))
        .map(i => ({ type_id: i.Id, type_name: i.Name }));

    const listUrl = buildUrl(`/Users/${config.userId}/Items`, {
        SortBy: 'DateCreated',
        SortOrder: 'Descending',
        IncludeItemTypes: 'Movie,Series',
        Recursive: 'true',
        Fields: 'PrimaryImageAspectRatio,ProductionYear,CommunityRating',
        Limit: 40,
    });
    const listJson = await _request(listUrl);
    
    return { class: classes, list: extractVideos(listJson?.Items || []) };
}

async function _category(body) {
    const { id, page } = body;
    const limit = 40;
    
    const url = buildUrl(`/Users/${config.userId}/Items`, {
        ParentId: id,
        Recursive: 'true',
        Fields: 'PrimaryImageAspectRatio,ProductionYear,CommunityRating',
        StartIndex: (page - 1) * limit,
        Limit: limit,
        IncludeItemTypes: 'Movie,Series',
        SortBy: 'DateLastContentAdded,SortName',
        SortOrder: 'Descending'
    });
    const json = await _request(url);
    return {
        page: page,
        pagecount: Math.ceil((json?.TotalRecordCount || 0) / limit),
        list: extractVideos(json?.Items)
    };
}

async function _detail(body) {
    const id = body.id[0];
    const item = await _request(buildUrl(`/Users/${config.userId}/Items/${id}`, { 
        Fields: 'Overview,Genres,People,ProductionYear,CommunityRating' 
    }));
    if (!item) return { list: [] };

    const video = {
        vod_id: item.Id,
        vod_name: item.Name,
        vod_pic: buildUrl(`/Items/${item.Id}/Images/Primary`, { maxWidth: 600 }),
        type_name: item.Genres?.join('/') || 'Emby',
        vod_year: item.ProductionYear || '',
        vod_content: (item.Overview || '暂无简介').trim(),
        vod_remarks: item.CommunityRating ? `⭐评分：${item.CommunityRating.toFixed(1)}` : item.ProductionYear || '',
        vod_director: item.People?.filter(p => p.Type === 'Director').map(p => p.Name).join('/') || '',
        vod_actor: item.People?.filter(p => p.Type === 'Actor').slice(0, 5).map(p => p.Name).join('/') || '',
    };

    if (item.Type === 'Series') {
        const seasonsJson = await _request(buildUrl(`/Shows/${id}/Seasons`, { UserId: config.userId }));
        const seasons = seasonsJson?.Items || [];
        const fromList = [];
        const urlList = [];
        for (const season of seasons) {
            const episodesJson = await _request(buildUrl(`/Users/${config.userId}/Items`, {
                ParentId: season.Id,
                Recursive: 'true',
                IncludeItemTypes: 'Episode',
                OrderBy: 'SortName'
            }));
            const episodes = episodesJson?.Items || [];
            if (episodes.length > 0) {
                fromList.push(season.Name);
                urlList.push(episodes.map(e => `${e.Name}$${e.Id}`).join('#'));
            }
        }
        video.vod_play_from = fromList.join('$$$');
        video.vod_play_url = urlList.join('$$$');
    } else {
        video.vod_play_from = "EMBY直链";
        video.vod_play_url = `${item.Name}$${item.Id}`;
    }
    return { list: [video] };
}

async function _search(body) {
    const { wd, page } = body;
    const limit = 40;
    const url = buildUrl(`/Users/${config.userId}/Items`, {
        Recursive: 'true',
        SearchTerm: wd,
        StartIndex: (page - 1) * limit,
        Limit: limit,
        IncludeItemTypes: 'Movie,Series',
        GroupProgramsBySeries: 'true', 
        Fields: 'PrimaryImageAspectRatio,ProductionYear,CommunityRating'
    });
    const json = await _request(url);
    return { list: extractVideos(json?.Items) };
}

async function _play(body) {
    const { id } = body;
    const url = buildUrl(`/Items/${id}/PlaybackInfo`, { UserId: config.userId });
    const json = await _request(url, { method: 'POST', body: deviceProfile });
    const mediaSource = json?.MediaSources?.[0];
    if (!mediaSource) return { parse: 0, url: '' };
    let playUrl = mediaSource.DirectStreamUrl || mediaSource.Path;
    if (playUrl && (playUrl.startsWith('/') || !playUrl.startsWith('http'))) {
        playUrl = `${config.host}${playUrl.startsWith('/') ? '' : '/'}${playUrl}`;
    }
    return {
        parse: 0,
        url: playUrl,
        header: { 
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'X-Emby-Token': config.token 
        }
    };
}

module.exports = async (app, opt) => {
    app.get(meta.api, async (req, res) => {
        const { ac, t, pg, ids, wd, play } = req.query;
        const page = parseInt(pg || "1");

        try {
            if (play) return await _play({ id: play });
            if (wd) return await _search({ wd, page });
            if (!ac) return await _home();
            if (ac === "detail") {
                if (t) return await _category({ id: t, page });
                if (ids) return await _detail({ id: ids.split(",").filter(Boolean) });
            }
            return { msg: "unsupported" };
        } catch (e) {
            return { msg: e.message };
        }
    });
    opt.sites.push(meta);
};