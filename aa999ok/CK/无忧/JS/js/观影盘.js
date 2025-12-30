var rule = {
	author: 'cz',
	类型: '影视',
	title: '',
	编码: 'utf-8',
	搜索编码: '',
	hostJs: '',
	homeUrl: '',
	host: 'https://www.gying.si',
	url: '/fyclass/------fypage',
	class_name: "电影&剧集&动漫",
	class_url: "mv&tv&ac",
	searchUrl: '/s/1-0--fypage/**',
	detailUrl: '',
	searchable: 2,
	quickSearch: 0,
	filterable: 0,
	filter: '',
	filter_url: '',
	filter_def: '',
	headers: {
		'User-Agent': "Mozilla/5.0 (Linux; Android 12; TAS-AN00 Build/HUAWEITAS-AN00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/99.0.4844.88 Mobile Safari/537.36",
	},
	timeout: 5000,
	cate_exclude: '',
	play_parse: true,
	lazy: $js.toString(() => {
		if (/pan.quark.cn|drive.uc.cn/.test(input)) {
			input = input
		};
		let html = request(input);
		let hconf = html.match(/_obj.player=(.*?);/)[1];
		let json = JSON.parse(hconf);
		let url = json.url;
		input = {
			parse: 0,
			jx: 0,
			url: url,
		}
	}),
	double: true,
	推荐: '列表1;列表2;标题;图片;描述;链接;详情',
	一级: $js.toString(() => {
		let d = [];
		let html = request(input).match(/_obj.inlist=(.*?);/)[1];
		let data = JSON.parse(html);
		let ii = 0
		data.i.forEach(item => {
			d.push({
				url: HOST + '/' + data.ty + '/' + item,
				img: 'https://s.tutu.pm/img' + '/' + data.ty + '/' + item + '.webp',
				title: data.t[ii],
			});
			ii = ii + 1
		});
		setResult(d)
	}),
	二级: $js.toString(() => {
		let downurl = HOST + '/ajax/downurl/' + MY_URL.split("/")[4] + '_' + MY_URL.split("/")[3] + '/';
		let ck = reqCookie(HOST)
		log('****cookie***' + ck);
		let html = request(downurl, {
			headers: {
				'User-Agent': "Mozilla/5.0 (Linux; Android 12; TAS-AN00 Build/HUAWEITAS-AN00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/99.0.4844.88 Mobile Safari/537.36",
				'referer': MY_URL,
				'Cookie': "vrg_go=1; PHPSESSID=ohh0kd1aks7ptl5apvfl7kqr6a; vrg_sc=46042bc00d17403e1ac110655839a547"
			}
		});
		let json = JSON.parse(html);
		let html2 = request(input).match(/_obj.d=(.*?);/)[1];
		let json2 = JSON.parse(html2);
		VOD = {};
		VOD.vod_name = json2.title;
		VOD.vod_id = json2.id;
		VOD.vod_year = json2.year;
		VOD.vod_area = json2.diqu[0];
		VOD.vod_remarks = json2.times;
		VOD.type_name = json2.leixing[0];
		VOD.vod_content = json2.introduce;
		VOD.vod_actor = json2.zhuyan[0];
		VOD.vod_director = json2.daoyan[0];
		let playUrls = [];
		let playfrom = [];

		if (json.panlist) {
			let pplist = [];
			for (let i = 0; i < json.panlist.name.length; i++) {
				let pn = json.panlist.name[i].replace(/━|🔥|✅|一|🎬|—|💜|👉|🔶|▶️|❤️|👈|📕|🌸|】|【|🔔|🌹|🚥🔴|🧡|-|🚀|🟢|🤖|🚨|＞|＜/g, '').trim();
				if (/pan.quark.cn/.test(json.panlist.url[i])) {
					pn = '(夸克盘)☀' + pn
					let plist = pn + '$' + 'push://' + json.panlist.url[i];
					pplist.unshift(plist)
				} else if (/drive.uc.cn/.test(json.panlist.url[i])) {
					pn = '(UC盘)☀' + pn
					let plist = pn + '$' + 'push://' + json.panlist.url[i];
					pplist.unshift(plist)
				} else if (/alipan.com/.test(json.panlist.url[i])) {
					pn = '(阿里盘)☀' + pn
					let plist = pn + '$' + 'push://' + json.panlist.url[i];
					pplist.push(plist)
				}
			};
			playUrls.push(pplist.join('#'));
			playfrom.push("网盘");
		};
		if (json.playlist) {
			json.playlist.forEach((it) => {
				let wplist = [];
				for (let i = 0; i < it.list.length; i++) {
					let plist = it.list[i] + '$' + 'https://www.gying.si/py/' + it.i + '_' + (i + 1) + '.html';
					wplist.push(plist)
				};
				playUrls.push(wplist.join('#'));
				playfrom.push(it.t);
			});
		};
		VOD.vod_play_from = playfrom.join('$$$');
		VOD.vod_play_url = playUrls.join('$$$')
	}),
	搜索: '.sr_lists li;h3&&Text;img&&data-src;描述;a&&href;详情'
}