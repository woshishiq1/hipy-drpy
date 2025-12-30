log(typeof(pdfl));
var rule = {
  title: 'yydsvip',
  host: 'http://www.yydsvip.cn/',
  url: '/category/fyclass/page/fypage/',
  //url: '/index.php/vodshow/fyfilter.html',
  searchUrl: '/search/**/page/fypage/',
  searchable: 2,
  quickSearch: 0,
  filterable:0,//是否启用分类筛选,

	filter_def:{
		1:{cateId:'dianying'},
		2:{cateId:'juji'},
		3:{cateId:'dongman'},
		4:{cateId:'zongyi'}
	},
	headers:{
		'User-Agent': 'MOBILE_UA'
	},
  class_parse: '.layui-nav&&li;span&&Text;a&&href;.*/(.*?)/',
  cate_exclude: '游戏|软件|综合|商铺',
  play_parse: true,
  //推送阿里播放  支持影视壳
  lazy: $js.toString(() => {
        let url = input.startsWith('push://') ? input : 'push://' + input;
        input = {parse: 0, url: url};
    }),
  limit: 6,
  推荐: '.layui-content;.paging-aa&&.excerpt-sticky;.item-title&&Text;.lazy&&data-original;.item-category&&Text;h3&&a&&href',
  double: true,
  一级: '.paging-aa&&.excerpt-sticky;h2&&title;.lazy&&data-original;.viewfloat&&Text;h2&&a&&href',
  二级: {
    title: '.qzdy-title&&h1',
    img: 'p&&img&&src',
    desc: ';;;;',
    content: '.markdown-body&&p:eq(4)&&Text',
    tabs: '',
    lists: 'body&&.layui-btn'

  },
  搜索: '.layui-content .title-article;.index-post-text-small&&h2&&Text;.lazy&&data-original;.viewfloat&&Text;.index-post-text-small&&a&&href',
}