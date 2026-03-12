globalThis.verifyBox = function(url) {
    const sendRequest = (requestUrl, options = {}) => {
        const res = request(requestUrl, {
            headers: rule.headers,
            withHeaders: true,
            redirect: false,
            method: 'GET',
            ...options
        });
        return typeof res === 'string' ? JSON.parse(res) : res;
    };
    
    const firstRes = sendRequest(url);
    const html = firstRes.body || firstRes;

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
  
    // 获取cookie的函数
    const getPhpSessionId = (response) => {
        const cookies = response['set-cookie'] || [];
        const cookieArr = Array.isArray(cookies) ? cookies : [cookies];
        const phpsessid = cookieArr.find(c => c?.includes('PHPSESSID'))?.split(';')[0]?.trim();
        return phpsessid || '';
    };

    // 提取当前响应的cookie
    let currentCookie = getPhpSessionId(firstRes);
    
    if (!/人机验证|防火墙正在检查/.test(html)) {
        // 如果没有验证，返回对象包含cookie和页面内容
        return {
            cookie: currentCookie,
            content: html
        };
    }

    const tokenMatch = html.match(/var token = encrypt\("([^"]+)"\)/);
    const key = tokenMatch ? tokenMatch[1] : '';

    const value = encrypt(url);
    const token = encrypt(key);
    const data = 'value=' + value + "&token=" + token;
    const yz_url = rule.host + '/robot.php';

    const verifyRes = sendRequest(yz_url, {
        headers: {
            'content-type': 'application/x-www-form-urlencoded',
            'origin': rule.host,
            'referer': rule.host,
            'cookie': currentCookie || ''
        },
        withHeaders: true,
        method: 'POST',
        body: data
    });

    const verifyData = verifyRes.body || verifyRes;
    let verifyMsg = verifyData;  
    if (typeof verifyData === 'string') {
        verifyMsg = JSON.parse(verifyData);
    }

    if (verifyMsg.msg === 'ok') {
        const start = Date.now();
        while (Date.now() - start < 1000) {
            // 空循环，等待1秒
        }

        const finalRes = request(url, {
            headers: {
                'cookie': currentCookie || ''
            },
            withHeaders: false,
            redirect: false,
            method: 'GET'
        });

        const finalContent = typeof finalRes === 'string' ? finalRes : (finalRes.body || finalRes);
        
        // 验证通过，返回包含cookie和页面内容的对象
        return {
            success: true,
            cookie: currentCookie,
            content: finalContent,
            message: '验证通过'
        };
    }

    // 验证失败，返回对象包含cookie和原始页面
    return {
        success: false,
        cookie: currentCookie,
        content: html,
        message: '验证失败'
    };
};

// 使用示例：
// const result = verifyBox('https://example.com/page');
// if (result.success) {
//     // 保存cookie供后续使用
//     const savedCookie = result.cookie;
//     // 使用cookie进行其他请求
//     const nextPage = request('https://example.com/next', {
//         headers: {
//             'cookie': savedCookie
//         }
//     });
// }

var rule = {
    类型: '影视',
    title: '剧巴巴',
    host: 'https://www.jubaba.cc',
    headers: {'User-Agent': 'MOBILE_UA'},
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
    推荐: $js.toString(() => {
        // 调用verifyBox获取验证结果
        let result = globalThis.verifyBox(MY_URL);
        
        // 从结果中提取cookie和页面内容
        let html = result.content;
        let phpsessid = result.cookie;
        
        // 如果有有效的cookie，将其保存到全局变量或localStorage中供后续使用
        if (phpsessid && phpsessid.trim() !== '') {
            // 保存到全局变量，后续的verifyBox调用会检查这个变量
            globalThis.savedPhpSessionId = phpsessid;
            
            // 也可以更新rule.headers中的cookie，让后续请求自动使用
            if (!rule.headers.cookie) {
                rule.headers.cookie = '';
            }
            // 更新或添加PHPSESSID到cookie
            let cookieStr = rule.headers.cookie;
            if (cookieStr.includes('PHPSESSID=')) {
                // 替换已有的PHPSESSID
                cookieStr = cookieStr.replace(/PHPSESSID=[^;]+/, phpsessid);
            } else {
                // 添加新的PHPSESSID
                cookieStr += (cookieStr ? '; ' : '') + phpsessid;
            }
            rule.headers.cookie = cookieStr;
        }
        
        let d = [];
        let list = pdfa(html, '.lazyload');
        list.forEach(it => {
            let title = pdfh(it, '.lazyload&&title');
            let href = pdfh(it, 'a&&href');
            let pic = pdfh(it, '.lazyload&&data-original');
            let remark = pdfh(it, '.text-right&&Text') || '';
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
    一级: $js.toString(() => {
        // 调用verifyBox获取验证结果
        let result = globalThis.verifyBox(MY_URL);
        
        // 从结果中提取cookie和页面内容
        let html = result.content;
        let phpsessid = result.cookie;
        
        // 如果有有效的cookie，将其保存到全局变量或localStorage中供后续使用
        if (phpsessid && phpsessid.trim() !== '') {
            // 保存到全局变量，后续的verifyBox调用会检查这个变量
            globalThis.savedPhpSessionId = phpsessid;
            
            // 也可以更新rule.headers中的cookie，让后续请求自动使用
            if (!rule.headers.cookie) {
                rule.headers.cookie = '';
            }
            // 更新或添加PHPSESSID到cookie
            let cookieStr = rule.headers.cookie;
            if (cookieStr.includes('PHPSESSID=')) {
                // 替换已有的PHPSESSID
                cookieStr = cookieStr.replace(/PHPSESSID=[^;]+/, phpsessid);
            } else {
                // 添加新的PHPSESSID
                cookieStr += (cookieStr ? '; ' : '') + phpsessid;
            }
            rule.headers.cookie = cookieStr;
        }
        
        let d = [];
        let list = pdfa(html, '.ewave-vodlist li');
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