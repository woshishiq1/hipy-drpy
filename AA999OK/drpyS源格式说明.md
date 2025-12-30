# drpyS源属性说明

```javascript
var rule = {
    // 影视|漫画|小说
    类型: '影视',
    // 源标题
    title: '',
    // 源主域名，可以自动处理后续链接的相对路径
    host: '',
    // 源描述
    desc: '',
    // 源主页链接，作为推荐的this.input
    homeUrl: '',
    // 静态分类名称
    class_name: '电视剧&电影&动漫',
    // 静态分类id
    class_url: '2&1&3',
    // 源一级列表链接
    url: '',
    // 筛选链接
    filter_url: '',
    // 筛选数据，可以是object也可以是gzip后的字符串
    filter: '',
    // 源搜索链接
    searchUrl: '',
    // 允许搜索、允许快搜、允许筛选
    searchable: 1,
    quickSearch: 0,
    filterable: 1,
    // 源默认请求头、调用await request如果参数二不填会自动添加
    headers: {
        'User-Agent': 'okhttp/3.14.9',
    },
    // 接口访问超时时间
    timeout: 5000,
    // 是否需要调用免嗅lazy函数
    play_parse: true,
    // 动态抓域名函数，可以不存在，优先级最高，会影响后续相对链接，只返回域名，不要做其他事情
    hostJs: async function () {
        let {HOST} = this;
        return HOST
    },
    // 优先级略低于hostJs,只会在源初始化的时候执行一次，可以用于动态获取cookie等
    预处理: async function () {
        let {HOST} = this;
        return HOST
    },
    // 免嗅lazy执行函数
    lazy: async function () {
        let {input} = this;
        return {
            url: input,
            parse: 0
        }
    },
    // 可以不存在
    class_parse: async function () {
        let {input} = this;
        return {class: [{type_name: '', type_id: ''}], filters: {}}
    },
    // 可以不存在
    推荐: async function () {
        let {input} = this;
        return []
    },
    一级: async function () {
        let {input} = this;
        return []
    },
    二级: async function () {
        let {input} = this;
        return {}
    },
    搜索: async function () {
        let {input} = this;
        return []
    },
}
```

# action说明

返回的action里可以包含按钮,属性为`button`，按钮的值说明如下:

* 0:关闭按钮
* 1:取消按钮
* 2:确定和取消
* 3.确定、取消、重置
* 4.确定、取消、重置、预览

<img alt="详情见图" src="./images/action.jpg" width="100%"/>