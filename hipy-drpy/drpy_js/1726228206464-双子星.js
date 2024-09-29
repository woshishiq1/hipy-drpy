  var rule = {
      title: '双子星',
      homeUrl: '',//分类和推荐页获取网址没有默认用主页host
      host: 'https://www.star2.cn',
      url: '/fyclass_fypage/[/fyclass/]',
      detailUrl:'',
      searchUrl: '/search/?keyword=**',
      searchable: 2,
      quickSearch: 0,
      filterable: 1,
      filter: '',
      filter_url: '',
      filter_def: {},
      headers: {'User-Agent': 'MOBILE_UA', },
      timeout: 5000,
      class_name: "短剧&国剧&综艺&电影&韩日&英美&外剧&动漫&其他",//静态分类
      class_url: "dj&ju&zy&dy&rh&ym&wj&dm&qt",//静态分类
    //  class_parse: '#side-menu li;a&&Text;a&&href;/(.*?)\.html',//动态分类/(\\d+).html(数字)  .*/(.*?).html(非数字)
      cate_exclude: '|',//需要排除的分类
      play_parse: true,
      lazy: `js:input = {parse: 1, url: input, js: '',header:rule.headers}`,//按需加载库
      double: true,//推荐页双层显示
      //推荐:列表1;列表2;标题;图片;描述;链接;详情
      推荐: ';;;;;;',
      //一级: '列表;标题;图片;描述;链接;详情',
      一级: '.erx-list a;a&&Text;;.i&&Text;a&&href;',
      二级: {
          title: 'vod_name;vod_type',
          img: '.dlipp-dl-btn&&img&&src',
          desc: '主要信息;年代;地区;演员;导演',
          content: '简介',
          tabs: '.dlipp-cont-bd',//线路数组
          lists: '.dlipp-dl-btn',//集数组
          tab_text: 'img&&alt',//线路名
          list_text: 'a&&Text',//集名
          list_url: 'a&&href',//集链接
          list_url_prefix: 'push://'
      },
      //搜索: '列表;标题;图片;描述;链接;详情',
      搜索: '*',//'*',
  }