var rule = {
    author: '',
    title: '4K大洋马',
    host: 'https://www.fullhd.xxx',
    url: '/zh/networks/fyclass/fypage/',
    homeUrl: '/',
    searchUrl: '/vodsearch/**----------fypage---.html',
    searchable: 2,
    quickSearch: 1,
    filterable: 1,
    limit: 30,
    编码: 'utf-8',
    timeout: 5000,
    headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'
    },
    class_parse: '.sites__list a;a&&Text;a&&href;/networks/(.*?)/',
    推荐: '.margin-fix .item;strong&&Text;img&&data-src||src;.duration&&Text;a&&href',
    一级: '.margin-fix .item;a&&title;img&&data-src||src;.duration&&Text;a&&href',
    二级: `js:
let html = request(input);
VOD = {};
 let r_ktabs = pdfa(html,'.video-js&&source');
 let ktabs = r_ktabs.map(it => pdfh(it, 'source&&label'));
 VOD.vod_play_from = ktabs.join('$$$');
let klists = [];
 let r_plists = pdfa(html, '.video-js&&source');
 r_plists.forEach((rp) => {
     let klist = pdfa(rp, 'source').map((it) => {
     return pdfh(it, 'source&&label') + '$' + pd(it, 'source&&src', input);
     });
     klist = klist.join('#');
     klists.push(klist);
 });
 VOD.vod_play_url = klists.join('$$$')
 `,
    搜索: '*',
}