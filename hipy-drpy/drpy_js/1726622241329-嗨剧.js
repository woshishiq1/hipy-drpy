var rule = {
    title: '',
    模板: '自动',
    host: 'https://www.haiju.vip',
    url: '/vodshow/fyclass--------fypage---.html',
    searchUrl: '/index.php/rss/index.xml?wd=**',
    搜索: `js:
let html=request(input);
let items=pdfa(html,'rss&&item');
log(items);
let d=[];
items.forEach(it=>{
    it=it.replace(/title|link|guid|pubDate|description/g,'p');
    log(it);
    let url=pdfh(it,'p:eq(1)&&Text');
    d.push({
    title:pdfh(it,'p&&Text') ,
    url: url,
    desc: pdfh(it,'p:eq(4)&&Text'),
    content: pdfh(it,'p:eq(3)&&Text'),
    pic_url: "",
});

});
setResult(d);
 `,
    lazy: $js.toString(() => {
        var html = JSON.parse(request(input).match(/r player_.*?=(.*?)</)[1])
        var url = html.url
        if (html.encrypt == '1') {
            url = unescape(url);
        } else if (html.encrypt == '2') {
            url = unescape(base64Decode(url));
        }

        var jx = request(HOST + '/static/player/' + html.from + '.js').match(/src="(.*?)'/)[1]
        log(jx)

        let jk = request(jx + url, {
            headers: {
                'Referer': input
            }
        })
        let lj = jk.match(/var config = {[\s\S]*?}/)[0]
        let Config = {};
        eval(lj + '\nConfig=config');
        log(Config)
        let body = 'url=' + Config.url + '&time=' + Config.time + '&key=' + Config.key
        let video = JSON.parse(request(jx.replace('?url=', 'api.php'), {
            body: body,
            method: 'POST'
        })).url

        function decrypt(text) {
            let decrypted = CryptoJS.AES.decrypt(text, CryptoJS.enc.Utf8.parse('DFGDFHffhhdgdg88'), /*key16位*/ {
                iv: CryptoJS.enc.Utf8.parse('SFDFGDGdsdgsga99'),
                /*iv16位*/
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
            });
            return decrypted.toString(CryptoJS.enc.Utf8)
        }

        let u = decrypt(video)
        log(u)
        input = {
            jx: 0,
            url: u,
            parse: 0,
        }

    })


}