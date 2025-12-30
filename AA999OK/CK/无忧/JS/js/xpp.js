var rule = {
    title: '小盘盘[搜]',
    host: 'https://xpanpan.site',
    url: '/category/fyclass/page/fypage',
    searchUrl: 'https://xpanpan.site/?s=**',
    searchable: 2,
    quickSearch: 0,
    headers: {
        'User-Agent': 'MOBILE_UA',
    },
    timeout: 5000,
    class_name:'影视天地&动漫资源&夸克网盘&阿里云盘&迅雷云盘&移动云盘',
	class_url:'video-tv-list&cartoon-list&kua-ke-wang-pan-list&ali-yun-pan-list&xun-lei-yun-pan-list&yi-dong-yun-pan-list',
    play_parse: true,
    //推送阿里播放  支持影视壳
  lazy: $js.toString(() => {
        let url = input.startsWith('push://') ? input : 'push://' + input;
        input = {parse: 0, url: url};
    }),
    一级: '.bloglo-flex-row .col-md-12;h4&&a&&title; ;.cat-links&&a&&Text;h4&&a&&href',
    二级: {
    "title": ".entry-header&&Text;.detail-icon&&Text",
    "img": "",
    "desc": "",
    "content": "",
    "tabs": "",
    "lists": ".entry-content&&ul&&li",
    "list_text": "li&&Text"
            },
    搜索: '*',
}