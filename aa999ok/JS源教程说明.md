
### 相关教程
[pyquery定位](https://blog.csdn.net/Arise007/article/details/79513094)

### 模板规则说明
所有相关属性说明
```javascript
var rule = {
    title:'',//规则标题,没有实际作用,但是可以作为cms类名称依据
    编码:'',//不填就默认utf-8
    搜索编码:'',//不填则不编码，默认都是按utf-8.可优先于全局编码属性.比如网页源码编码是gbk,这里可以指定utf-8搜索独立编码。多数情况这个属性不填或者填写gbk应对特殊的网站搜索
    host:'',//网页的域名根,包含http头如 https://www,baidu.com
    hostJs:'print(HOST);let html=request(HOST,{headers:{"User-Agent":PC_UA}});let src = jsp.pdfh(html,"ul&&li&&a&&href");print(src);HOST=src.replace("/index.php","")',//网页域名根动态抓取js代码。通过HOST=赋值
    homeUrl:'/latest/',//网站的首页链接,可以是完整路径或者相对路径,用于分类获取和推荐获取 fyclass是分类标签 fypage是页数
    url:'/fyclass/fypage.html[/fyclass/]',//网站的分类页面链接
    detailUrl:'https://yanetflix.com/voddetail/fyid.html',//非必填,二级详情拼接链接,感觉没啥卵用
    searchUrl:'',//搜索链接 可以是完整路径或者相对路径,用于分类获取和推荐获取 **代表搜索词 fypage代表页数
    searchable:0,//是否启用全局搜索,
    quickSearch:0,//是否启用快速搜索,
    filterable:0,//是否启用筛选,
    filter:{},// 筛选条件字典
    // 默认筛选条件字典(不同分类可以指定同样筛选参数的不同默认值)
    filter_def:{
        douyu:{
        area:'一起看',
        other:'..'
        },
        huya:{
        area:'影音馆',
        other:'..'
        }
    }, 
    // 筛选网站传参,会自动传到分类链接下(本示例中的url参数)-url里参数为fyfilter,可参考蓝莓影视.js
    filter_url:'style={{fl.style}}&zone={{fl.zone}}&year={{fl.year}}&fee={{fl.fee}}&order={{fl.order}}',
    // 注意,由于猫有配置缓存,搜索配置没法热加载，修改了js不需要重启服务器
    // 但是需要tv_box进设置里换源使配置重新装载
    headers:{//网站的请求头,完整支持所有的,常带ua和cookies
        'User-Agent':'MOBILE_UA',
        "Cookie": "searchneed=ok"
    },
    timeout:5000,//网站的全局请求超时,默认是3000毫秒
    class_name:'电影&电视剧&动漫&综艺',//静态分类名称拼接
    class_url:'1&2&3&4',//静态分类标识拼接
    //动态分类获取 列表;标题;链接;正则提取 不需要正则的时候后面别加分号
    class_parse:'#side-menu:lt(1) li;a&&Text;a&&href;com/(.*?)/',
    // 除开全局过滤之外还需要过滤哪些标题不视为分类
    cate_exclude:'',
    // 除开全局动态线路名过滤之外还需要过滤哪些线路名标题不视为线路
    tab_exclude:'',
    //移除某个线路及相关的选集|js1
    tab_remove:['tkm3u8'],
    //线路顺序,按里面的顺序优先，没写的依次排后面|js1
    tab_order:['lzm3u8','wjm3u8','1080zyk','zuidam3u8','snm3u8'],
    //线路名替换如:lzm3u8替换为量子资源|js1
    tab_rename:{'lzm3u8':'量子','1080zyk':'1080看','zuidam3u8':'最大资源','kuaikan':'快看',
    'bfzym3u8':'暴风','ffm3u8':'非凡','snm3u8':'索尼','tpm3u8':'淘片','tkm3u8':'天空',},

    // 服务器解析播放
    play_parse:true,
    // play_json　传数组或者　类　true/false 比如 0,1 如果不传会内部默认处理 不传和传0可能效果不同
    // 效果等同说明: play_json:[{re:'*', json:{jx:0, parse:1}}], 等同于 play_json:0,
    play_json:[{
        re:'*',
        json:{
            jx:1,
            parse:1,
        },
    }],
    //控制不同分类栏目下的总页面,不填就是默认999.哔哩影视大部分分类无法翻页，都需要指定页数为 1
    pagecount:{"1":1,"2":1,"3":1,"4":1,"5":1,"7":1,"时间表":1},
    // 自定义免嗅 
    lazy:'',
    // 首页推荐显示数量
    limit:6,
    double:true,//是否双层列表定位,默认false
    // 对图片加了referer验证的有效,海阔专用,普通规则请勿填写此键值
    图片来源:'@Referer=http://www.jianpianapp.com@User-Agent=jianpian-version350',
    // 替换所有图片链接 欲替换文本=>替换为文本
    图片替换:'https://www.keke6.app/=>https://vres.a357899.cn/',
    
    // js写法，仅js模式1有效.可以用于代码动态获取全局cookie之类的
    // 可操作变量有 rule_fetch_params,rule,以及基础的网页访问request,post等操作
    预处理:'rule_fetch_params.headers.Cookie = "xxxx";',
    // 类似海阔一级 列表;标题;图片;描述;链接;详情 其中最后一个参数选填
    // 如果是双层定位的话,推荐的第2段分号代码也是第2层定位列表代码
    推荐:'.col-sm-6;h3&&Text;img&&data-src;.date&&Text;a&&href',
    // 类似海阔一级 列表;标题;图片;描述;链接;详情 其中最后一个参数选填
    一级:'.col-sm-6;h3&&Text;img&&data-src;.date&&Text;a&&href',
    //二级发起访问前进行js处理。解决特殊情况一级给出的链接非二级真实源码而是前端重定向链接的源码
    二级访问前:'log(MY_URL);let jump=request(MY_URL).match(/href="(.*?)"/)[1];log(jump);MY_URL=urljoin2(MY_URL,jump)',
    // 二级可以是*,表示规则无二级,直接拿一级的链接进行嗅探
    // 二级 title: 片名;类型
    // 二级 desc: 主要信息;年代;地区;演员;导演
    // 或者 {title:'',img:'',desc:'',content:'',tabs:'',lists:'',tab_text:'body&&Text',list_text:'body&&Text',list_url:'a&&href'} 同海阔dr二级
    二级:'*',
    // 搜索可以是*,集成一级，或者跟一级一样的写法 列表;标题;图片;描述;链接;详情
    搜索:'*',
    // 本地代理规则，可用于修改m3u8文件文本去广告后返回代理文件地址，也可以代理加密图片
    proxy_rule:`js:
    log(input);
    input = [200,'text;plain','hello drpy']
    `,
    //是否启用辅助嗅探: 1,0
    sniffer:1,
    // 辅助嗅探规则
    isVideo:"http((?!http).){26,}\\.(m3u8|mp4|flv|avi|mkv|wmv|mpg|mpeg|mov|ts|3gp|rm|rmvb|asf|m4a|mp3|wma)",
    // 辅助嗅探规则js写法
    isVideo:`js:
    log(input);
    if(/m3u8/.test(input)){
    input = true
    }else{
    input = false
    }
    `,
}
```
模板继承写法
```javascript
var rule = Object.assign(muban.mxpro,{
title:'鸭奈飞',
host:'https://yanetflix.com',
url:'/index.php/vod/show/id/fyclass/page/fypage.html',
class_parse:`.navbar-items li:gt(1):lt(6);a&&Text;a&&href;.*/(.*?).html`,
});
```
模板继承写法(新)
```javascript
var rule = {
title:'cokemv',
模板:'mxpro',
host:'https://cokemv.me',
class_parse:`.navbar-items li:gt(1):lt(7);a&&Text;a&&href;/(\\d+).html`,
}
```

源正则写法说明  
```text
属性class_parse按;分隔后取[3]为分类的正则字符串。  
这里的正则跟js的/.*/这种写法相比，由于是字符串,需要实现字符串标准。
比如想实现 /(\d+)/ 那么字符串写法为 (\\d+)  
原理是 new RegExp('(\\d+)') = /(\d+)/

属性lazy由于是纯js代码实现,不存在正则转义问题。  
每个源的属性对应的值如果是字符串,可以用反引号``包含起来。
避免内部出现单双引号混用等需\转义问题
```

js:内置变量
input,html,VODS,VOD,TABS,LISTS,MY_CATE,MY_FL
getProxyUrl(获取壳子本地代理地址返回 /proxy?do=js的完整链接)

本地代理说明:
proxy_rule参数input赋值格式为三元素列表[status,content-type,data]  
如: [200,'text/plain','hello drpy']  
input = [200,'application/vnd.apple.mpegurl',m3u8]    
rsa加解密说明:
```js
log(typeof(rsaX));
if(typeof(rsaX)=='function'){
    rsaX(mode, pub, encrypt, input, inBase64, key, outBase64)
}
```



XYQHiker写法说明(中文模板)

//jsoup规则写法请查阅海阔视界或者海阔影视相关教程。不支持js写法
//本文档为完整模板，请不要去无中生有添加多余的键值参数。
//内置正则写法截取格式为 截取前缀&&截取后缀，&&代表前缀与后缀中间你需要截取的内容
{
    //规则名
    "规则名": "XYQHiker中文模板",
    //作者
    "规则作者": "",
    //请求头UA,键名$键值，每一组用#分开，不填则默认okhttp/3.12.11，可填MOBILE_UA，手机，PC_UA，电脑使用内置的手机版或电脑版UA
    //多个请求头参数写法示例，"User-Agent$PC_UA#Referer$http://ww.baidu.com#Cookie$ser=ok",每一组用#分开。
    //习惯查看手机源码写建议用手机版UA，习惯查看PC版源码写建议用电脑版UA，不支持Content-Type参数
    "请求头参数":"PC_UA",
    //网页编码格式默认UTF-8编码，UTF-8，GBK，GB2312
    "网页编码格式":"UTF-8",
    //图片是否需要代理
    "图片是否需要代理":"0",
    
    //是否开启获取首页数据，0关闭，1开启
    "是否开启获取首页数据":"0",
    //首页推荐数据获取链接
    "首页推荐链接": "http://www.lezhutv.com",
    //首页推荐列表数组截取。
    "首页列表数组规则": "body&&.myui-vodlist",
    //首页推荐片单列表数组定位。
    "首页片单列表数组规则": "li",
    //首页推荐片单信息jsoup与正则截取写法切换，只作用于html网页，1为jsoup写法(默认)，0为正则截取写法
    "首页片单是否Jsoup写法":"1",
    //下面这六个首页数据如果不填将调用分类那截取的配置（片单写法需一致且取值也得一致）。
    //首页片单标题
    "首页片单标题": "h4&&a&&Text",
    //首页推荐片单链接
    "首页片单链接": "h4&&a&&href",
    //首页推荐片单图片，支持自定义图片链接
    "首页片单图片": ".lazyload&&data-original",
    //首页推荐片单副标题
    "首页片单副标题":".pic-text&&Text",
    //首页推荐片单链接补前缀  
    "首页片单链接加前缀": "http://www.lezhutv.com",
    //首页推荐片单链接补后缀
    "首页片单链接加后缀": "",
    
    //分类链接起始页码,禁止负数和含小数点。
    "分类起始页码": "1",
    //分类链接,{cateId}是分类，{catePg}是页码,第一页没有页码的可以这样写 第二页链接[firstPage=第一页的链接]
    // https://www.libvio.me/show/{cateId}-{area}-{by}-{class}-{lang}----{catePg}---{year}.html
    "分类链接": "http://www.lezhutv.com/vodshow/{cateId}--------{catePg}---.html[firstPage=第一页不含页码的链接]",
    //分类名，分类1&分类2&分类3
    "分类名称": "电影&电视剧&综艺&动漫",
    //分类名替换词，替换词1&替换词2&替换词3，替换词包含英文&的用两个中文＆＆代替，示例：＆＆id=0&＆＆id=1
    "分类名称替换词": "1&2&3&4",
    //筛选数据，支持直写，clan://本地路径(可能有bug)，http云端链接，json格式，参考xpath的筛选写法，填ext可以使用下面手动填写的筛选数据。
    "筛选数据":{},
    
    //!!!要使用下面的筛选数据，筛选数据那一定要填ext，"筛选数据":"ext"
    //子分类名称，对应分类链接{cateId}，第一子分类1&第一子分类2||第二子分类1&第二子分类2
    "筛选子分类名称": "动作片&喜剧片||国产剧&日韩剧||空||国产动漫&日本动漫",
    //分类名替换词，替换词1&替换词2&替换词3，替换词包含英文&的用两个中文＆＆代替，示例：＆＆id=0&＆＆id=1，如果替换词与名称一致可填*
    "筛选子分类替换词": "5&6||13&14||空||26&27",
    //类型/剧情名称，对应分类链接{class}，剧情1&剧情2&剧情3
    "筛选类型名称": "爱情&喜剧&科幻",
    //类型/剧情替换词，替换词1&替换词2&替换词3。如果替换词与名称一致可填*
    "筛选类型替换词": "爱情&喜剧&科幻",
    //地区名称，对应分类链接{area}，地区1&地区2&地区3
    "筛选地区名称": "中国&新加坡",
    //地区替换词，替换词1&替换词2&替换词3，替换词包含英文&的用两个中文＆＆代替，示例：＆＆id=0&＆＆id=1，如果替换词与名称一致可填*
    "筛选地区替换词": "中国&新加坡",
    //年份名称，对应分类链接{year}，年份1&年份2&年份3
    "筛选年份名称": "2022&2021",
    //年份替换词，替换词1&替换词2&替换词3，如果替换词与名称一致可填*
    "筛选年份替换词": "2022&2021",
    //语言名称，对应分类链接{lang}，语言1&语言2&语言3
    "筛选语言名称": "国语&英语",
    //语言替换词，替换词1&替换词2&替换词3，如果替换词与名称一致可填*
    "筛选语言替换词": "国语&英语",
    //排序名称，对应分类链接{by}，排序1&排序2&排序3
    "筛选排序名称": "时间&人气&评分",
    //排序替换词，替换词1&替换词2&替换词3。如果替换词与名称一致可填*
    "筛选排序替换词": "time&hits&score",
    
    
    //分类页面截取数据模式，0为json，其它数字为普通网页。
    "分类截取模式": "1",
    //使用截取法从网页中截取json规则，只对截取模式0生效，如data(&&),中间那个&&就是代表json
    "分类Json数据二次截取":"",
    //分类列表数组定位，最多支持3层，能力有限，不是所有页面都能支持
    "分类列表数组规则": ".myui-vodlist&&li",
    //分类片单信息jsoup与正则截取写法切换，只作用于html网页，1为jsoup写法(默认)，0为正则截取写法
    "分类片单是否Jsoup写法":"1",
    //下面这六个分类数据如果不填将调用首页那截取的配置（片单写法需一致，且取值也得一致）。
    //分类片单标题
    "分类片单标题": "h4&&a&&Text",
    //分类片单链接
    "分类片单链接": "h4&&a&&href",
    //分类片单图片，支持自定义图片链接
    "分类片单图片": ".lazyload&&data-original",
    //分类片单副标题
    "分类片单副标题":".pic-text&&Text",
    //分类片单链接补前缀  
    "分类片单链接加前缀": "http://www.lezhutv.com",
    //分类片单链接补后缀
    "分类片单链接加后缀": "",
    
    //搜索请求头参数,不填则默认okhttp/3.12.11，可填MOBILE_UA或PC_UA使用内置的手机版或电脑版UA
    //多个请求头参数写法示例，键名$键值，每一组用#分开。"User-Agent$PC_UA#Referer$http://ww.baidu.com#Cookie$ser=ok"。
    "搜索请求头参数":"User-Agent$PC_UA",
    //搜索链接，搜索关键字用{wd}表示，post请求的最后面加;post
    //POST链接示例 http://www.lezhutv.com/index.php?m=vod-search;post
    "搜索链接": "http://www.lezhutv.com/index.php/vod/search/page/1/wd/{wd}.html",
    //POST搜索Params参数，只支持utf-8编码的请求，填写搜索关键字的键值，一般常见的是searchword和wd，不是POST搜索的可留空或删除。
    "POST请求数据":"wd={wd}&search=",
    
    //搜索截取模式,0为json搜索，只支持列表在list数组里的，其它数字为网页截取。
    "搜索截取模式": "0",
    //搜索列表数组定位，不填默认内置list，最多支持3层，能力有限，不是所有页面都能支持。
    "搜索列表数组规则": "list",
    //搜索片单信息jsoup与正则截取写法切换，只作用于html网页，1为jsoup写法(默认)，0为正则截取写法
    "搜索片单是否Jsoup写法":"1",
    //搜索片单图片，支持自定义图片链接
    "搜索片单图片": "pic",
    //搜索片单标题
    "搜索片单标题": "name",
    //搜索片单链接
    "搜索片单链接": "id",
    //搜索片单副标题
    "搜索片单副标题":"",
    //搜索片单链接补前缀
    "搜索片单链接加前缀": "http://www.lezhutv.com",
    //搜索片单链接补后缀，这个一般json搜索的需要
    "搜索片单链接加后缀": ".html",
    
    //片单链接是否直接播放，0否，1分类片单链接直接播放，2详情选集链接直接播放。
    //设置成直接播放后，后面3个参数请注意该留空的请务必留空。
    "链接是否直接播放": "0",
    //直接播放链接补前缀
    "直接播放链接加前缀": "https://live.52sf.ga/huya/",
    //直接播放链接补后缀，设置为#isVideo=true#可强制识别为视频链接
    "直接播放链接加后缀": "#isVideo=true#",
    //直接播放链接设置请求头，只对直链视频有效，每一组用#分开
    "直接播放直链视频请求头": "authority$ku.peizq.online#Referer$https://play.peizq.online",
    
    //项目信息jsoup与正则截取写法切换，1为jsoup写法(默认)，0为正则截取写法
    "详情是否Jsoup写法":"0",
    //类型数据，截取前缀&&截取后缀
    "类型详情": "",
    //年代数据，截取前缀&&截取后缀
    "年代详情": "",
    //地区数据，截取前缀&&截取后缀
    "地区详情": "",
    //演员数据，截取前缀&&截取后缀
    "演员详情": "演员：&&</p>",
    //简介内容，截取前缀&&截取后缀
    "简介详情": "简介：&&</p>",
    
    //线路截取区域，如果不需要请把tab_title或tab_arr_rule置空或者全部不要填。
    //线路截取数组
    "线路列表数组规则": ".tabs&&li",
    //线路标题，截取前缀&&截取后缀，
    //排除线路写法示例==> "线路标题": "h3&&Text[不包含:网盘,云盘]",
    "线路标题": "a&&alt",
    
    //列表数组截取，必须
    "播放列表数组规则": "body&&.play_list",
    //集数数组截取，必须
    "选集列表数组规则": "li",
    //集数标题与链接jsoup与正则截取写法切换，1为jsoup写法(默认)，0为正则截取写法
    "选集标题链接是否Jsoup写法":"1",
    //集数标题，截取前缀&&截取后缀
    "选集标题": "a&&Text",
    //集数链接，截取前缀&&截取后缀
    "选集链接": "a&&href",
    //选集是否反转显示
    "是否反转选集序列": "0",
    //集数链接补前缀
    "选集链接加前缀": "http://www.lezhutv.com",
    //集数链接补后缀
    "选集链接加后缀": "",
    
    //下面几个参数请勿乱用。否则可能会有副作用。
    //分析网页源码中有<script type="text/javascript">var player_aaaa={"flag":"play","encrypt这种源码的链接解析
    //如果网页源码里没有这种请设置为0
    "分析MacPlayer":"0",
    //是否开启手动嗅探，只对网页嗅探有效，0否，1是
    "是否开启手动嗅探":"0",
    //手动嗅探视频链接关键词，每个用#隔开
    "手动嗅探视频链接关键词":".mp4#.m3u8#.flv#video/tos",
    //手动嗅探视频链接过滤关键词,每个用#隔开
    "手动嗅探视频链接过滤词":".html#?http"
}




XYQHiker模板
{
   
    "规则名": "XYQHiker模板",
    "规则作者": "",
    "请求头参数":"MOBILE_UA",
    "网页编码格式":"UTF-8",
    "图片是否需要代理":"0",
    "是否开启获取首页数据":"0",
    "分类起始页码": "1",
    "分类链接": "https://www.l0l.tv/index.php/vod/show/id/{cateId}/page/{catePg}.html",
    "分类名称": "电影&电视剧&动漫&综艺&bilibili&",
    "分类名称替换词": "1&2&3&4&5&",
    "筛选数据":{},
    "分类截取模式": "1",
    "分类列表数组规则": ".list-width&&.top&&a",
    "分类片单是否Jsoup写法":"1",
    "分类片单标题": "a&&title",
    "分类片单链接": "a&&href",
    "分类片单图片": ".lazy.eclazy.br&&data-original",
    "分类片单副标题":"",
    "分类片单链接加前缀": "https://www.l0l.tv",
    "分类片单链接加后缀": "",
    "搜索请求头参数":"User-Agent$PC_UA",
    "搜索链接": "https://www.l0l.tv/index.php/ajax/suggest?mid=1&wd={wd}",
    "POST请求数据":"0",
    "搜索截取模式": "0",
    "搜索列表数组规则": "list",
    "搜索片单是否Jsoup写法":"1",
    "搜索片单图片": "pic",
    "搜索片单标题": "name",
    "搜索片单链接": "id",
    "搜索片单副标题":"",
    "搜索片单链接加前缀": "https://www.l0l.tv/index.php/vod/play/id/",
    "搜索片单链接加后缀": "/sid/1/nid/1.html",
    "详情是否Jsoup写法":"0",
    "类型详情": "",
    "年代详情": "",
    "地区详情": "",
    "演员详情": "导演：</span>&&</p>",
    "简介详情": "概要：</span>&&</p>",
    "线路列表数组规则": "#tag&&a",
    "线路标题": "a&&Text",
    "播放列表数组规则": "body&&.content_playlist",
    "选集列表数组规则": "li",
    "选集标题链接是否Jsoup写法":"1",
    "选集标题": "a&&Text",
    "选集链接": "a&&href",
    "是否反转选集序列": "0",
    "选集链接加前缀": "https://www.l0l.tv",
    "选集链接加后缀": "",
    "分析MacPlayer":"1",
    "是否开启手动嗅探":"1",
    "手动嗅探视频链接关键词":".mp4#.m3u8#.flv",
    "手动嗅探视频链接过滤词":".html#=http"
}









