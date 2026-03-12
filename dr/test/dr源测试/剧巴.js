globalThis.verifyBox = function(url) {
    const encrypt = (str) => {
        const chars = "PXhw7UT1B0a9kQDKZsjIASmOezxYG4CHo5Jyfg2b8FLpEvRr3WtVnlqMidu6cN";
        const len = chars.length;
        const result = new Array(str.length * 3);

        for (let i = 0, j = 0; i < str.length; i++, j += 3) {
            const char = str[i];
            const idx = chars.indexOf(char);

            const r1 = Math.random() * len | 0;
            const r2 = Math.random() * len | 0;

            result[j] = chars[r1];
            result[j + 1] = idx === -1 ? char : chars[(idx + 3) % len];
            result[j + 2] = chars[r2];
        }

        return CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(result.join('')));
    };
    var value = encrypt(url);
    var token = encrypt(/var token = encrypt\("([^"]+)"\)/);
    var data = 'value=' + encrypt(location.href) + '&token=' + encrypt(token);
    var xhr = new XMLHttpRequest();
    xhr.open('post', '${rule.host}/robot.php', false);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(data);
    
    if (xhr.status >= 200 && xhr.status < 300 || xhr.status == 304) {
        setTimeout(function() { location.reload(); }, 1000);
        return true;
    }
    return false;
};

var rule = {
    类型: '影视',
    title: '剧巴巴',
    host: 'https://www.jubaba.cc',
    headers: {
        'User-Agent': 'MOBILE_UA'
    },
    编码: 'utf-8',
    timeout: 5000,
    homeUrl: '/',
    url: '/vodshow/fyclass--------fypage---.html',
    detailUrl: '',
    searchUrl: '/vodsearch/**----------fypage---.html',
    searchable: 1,
    quickSearch: 1,
    filterable: 1,
    class_name: '电影&剧集&综艺&动漫',
    class_url: '1&2&3&4',
    play_parse: true,
    lazy: $js.toString(() => {
        let pclick = 'document.querySelector("#playleft iframe").contentWindow.document.querySelector("#start").click()';
        input = {
            parse: 1,
            url: input,
            js: pclick,
            click: pclick
        }
    }),
    limit: 9,
    double: false,
    推荐: '.lazyload;.lazyload&&title;.lazyload&&data-original;.text-right&&Text;a&&href',

    一级: $js.toString(() => {
        let cookie = getItem(RULE_CK, '');
        //log('储存的cookie:' + cookie);        
        let ret = request(MY_URL, {
            headers: {
                Referer: encodeUrl(MY_URL),
                Cookie: cookie,
            }
        });
        if (/人机验证/.test(ret)) {
            //log(ret);
            cookie = globalThis.verifyBox(MY_URL);
            if (cookie) {
                log(`本次成功过验证,cookie:${cookie}`);
                setItem(RULE_CK, cookie);
            } else {
                log(`本次验证失败,cookie:${cookie}`);
            }
            ret = request(MY_URL, {
                headers: {
                    Referer: encodeUrl(MY_URL),
                    Cookie: cookie,
                }
            });
        }
        let d = [];
        let list = pdfa(ret, '.ewave-vodlist li');
        list.forEach(it => {
            let title = pdfh(it, '.title&&Text');
            let href = pdfh(it, 'a.thumb-link&&href');
            let pic = pdfh(it, '.ewave-vodlist__thumb&&data-original');
            let remark = pdfh(it, '.pic-text&&Text') || '';
            let score = pdfh(it, '.pic-tag-h&&Text') || '';

            d.push({
                title: title,
                img: pic,
                desc: remark + ' ' + score,
                url: href
            });
        });
        setResult(d);
    }),
    二级: {
        title: 'h1&&span:eq(0)&&Text;.data--span:eq(0)&&Text',
        img: 'img.lazyload&&data-original',
        desc: '.v-thumb&&span&&Text;.data:eq(0)&&a:eq(-1)&&Text;.data:eq(0)&&a:eq(-2)&&Text;.data--span:eq(1)&&Text;.data--span:eq(2)&&Text',
        content: 'meta[name^=description]&&content',
        tabs: '.nav-tabs&&a',
        tab_text: 'body&&Text',
        lists: '.ewave-content__playlist:eq(#id)&&a',
        list_text: 'body&&Text',
        list_url: 'a&&href',
    },
    搜索: '*',
}