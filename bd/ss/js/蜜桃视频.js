var rule = {
    title: '多吃枸杞啊',
    编码: 'utf-8',
    搜索编码: '', //不填则不编码，默认都是按utf-8.可优先于全局编码属性.比如网页源码编码是gbk,这里可以指定utf-8搜索独立编码。多数情况这个属性不填或者填写gbk应对特殊的网站搜索
    host: 'https://www.mtrt191.cc:9527/',
    url: '/type/fyclass/---fypage',
    searchUrl: '/search/**/fypage',
    searchable: 0, //是否启用全局搜索,
    quickSearch: 0, //是否启用快速搜索,
    filterable: 0, //是否启用筛选,
    //filter: {}, // 筛选条件字典
    // 默认筛选条件字典(不同分类可以指定同样筛选参数的不同默认值)
    //filter_def: {
    //  guochan: {
    // area: '一起看',
    //  other: '..'
    //  },
    // huya: {
    //     area: '影音馆',
    //    other: '..'
    //  }
    //},
    // 筛选网站传参,会自动传到分类链接下(本示例中的url参数)-url里参数为fyfilter,可参考蓝莓影视.js
    //filter_url: 'style={{fl.style}}&zone={{fl.zone}}&year={{fl.year}}&fee={{fl.fee}}&order={{fl.order}}',
    // 注意,由于猫有配置缓存,搜索配置没法热加载，修改了js不需要重启服务器
    // 但是需要tv_box进设置里换源使配置重新装载
    headers: { //网站的请求头,完整支持所有的,常带ua和cookies
        'User-Agent': 'MOBILE_UA',
        "Cookie": "searchneed=ok"
    },
    timeout: 5000, //网站的全局请求超时,默认是3000毫秒
    class_name: '國产&傳媒&日韓&解說&歐美&動漫&AI換臉&同性&女优&三級片',
    class_url: 'guochan&chuanmei&chigua&rihan&oumei&dongman&AIhuanlian&tongxing&nvyou&sanjipian',
    play_parse: true,
    // 自定义免嗅 
    lazy: '',
    // 首页推荐显示数量
    limit: 6,
    double: true, //是否双层列表定位,默认false
    // 对图片加了referer验证的有效,海阔专用,普通规则请勿填写此键值
   // 图片来源: '@Referer=https://www.mtrt191.cc:9527/@User-Agent',
    // js写法，仅js模式1有效.可以用于代码动态获取全局cookie之类的
    // 可操作变量有 rule_fetch_params,rule,以及基础的网页访问request,post等操作
    // 类似海阔一级 列表;标题;图片;描述;链接;详情 其中最后一个参数选填
    // 如果是双层定位的话,推荐的第2段分号代码也是第2层定位列表代码
    推荐: '.purple-v-list&&.purple-v-item&&div;.purple-v-title&&Text;img&&data-original;.purple-v-hits&&Text;.purple-v-title&&data-href',
    // 类似海阔一级 列表;标题;图片;描述;链接;详情 其中最后一个参数选填
    一级: '.purple-v-list&&.purple-v-item&&;.purple-v-title&&Text;img&&data-original;.purple-v-image-bottom&&Text;.purple-v-title&&data-href',
    // 二级 title: 片名;类型
    // 二级 desc: 主要信息;年代;地区;演员;导演
    // 或者 {title:'',img:'',desc:'',content:'',tabs:'van-icon van-icon-warning',lists:'',tab_text:'body&&Text',list_text:'body&&Text',list_url:'a&&href'} 同海阔dr二级
    二级: '*',
    // 搜索可以是*,集成一级，或者跟一级一样的写法 列表;标题;图片;描述;链接;详情
    搜索: '*',
}