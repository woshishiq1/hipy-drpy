 var rule = {
        title: '4K影院',
        host: 'https://4kyingshi.com',
        url: '/vod/fyclass-fypage',
        searchUrl: '/vodsearch/-------------/?wd=**&submit=搜+索',
        searchable: 2,
        quickSearch: 0,
        filterable: 0,
        headers: {
            'User-Agent': 'UC_UA',
        },
        class_name: '电视剧&电影&综艺&动漫&短剧大全',
        class_url: '1&2&3&4&5',
        play_parse: true,
        lazy: "js:\n  let html = request(input);\n  let hconf = html.match(/r player_.*?=(.*?)</)[1];\n  let json = JSON5.parse(hconf);\n  let url = json.url;\n  if (json.encrypt == '1') {\n    url = unescape(url);\n  } else if (json.encrypt == '2') {\n    url = unescape(base64Decode(url));\n  }\n  if (/\\.(m3u8|mp4|m4a|mp3)/.test(url)) {\n    input = {\n      parse: 0,\n      jx: 0,\n      url: url,\n    };\n  } else {\n    input;\n  }",
        limit: 6,
        double: true,
        推荐: 'ul.stui-vodlist.clearfix;li;a&&title;.lazyload&&data-original;.pic-text&&Text;a&&href',
        一级: '.ul-imgtxt2&&li;.txt&&a&&b&&Text;img&&src;.txt&&a&&em&&Text;a&&href',
        二级: {
            title: '.m-text1&&h1&&Text',
            title1: '.stui-content__detail .title&&Text;.stui-content__detail&&p&&Text',
            img: '.txt&&img&&src',
            desc: '.txt p:eq(6)&&Text',
            content: '.txt p:eq(12)&&Text',
            tabs: $js.toString(() => {
                TABS=[];
                TABS.push("在线播放");
               // TABS.push("下载播放");
            }),
            lists: $js.toString(() => {
                LISTS = [];
                let lists1 = pdfa(html, '.plau-ul-list&&li').map(it => {
                    let _tt = pdfh(it, 'a&&Text');
                    let _uu = pdfh(it, 'a&&href');
                    return _tt + '$' + 'https://4kyingshi.com' + _uu
                });
                LISTS.push(lists1);
                //获取下载地址
                // let html2 = pdfa(html, '.bot:eq(2)')
                // // 使用正则表达式匹配所有的 <a> 标签及其内容
                // let regex = /<a\s+href="([^"]+)">第(\d+)集<\/a>/g;
                // let match;
                // let episodes = [];
                // while ((match = regex.exec(html2)) !== null) {
                //     let episodeNumber = '第' + match[2] + '集';
                //     let episodeUrl = match[1];
                //     episodes.push(episodeNumber + '$' + episodeUrl);
                // }
                // if (episodes.length) {
                //     LISTS.push(episodes);
                // }
                // //log(LISTS);
            }),
        }
    }