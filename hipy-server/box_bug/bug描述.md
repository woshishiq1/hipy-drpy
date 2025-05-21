#### 长期收集box类软件强烈推荐优化的问题点

1.注入给js的req函数，原生获取数据的base64编码代码有误，可能导致数据大了自动分段无法解码问题
[错误点](./base64错误.jpg)  
[解决办法](./base64错误解决.png)

2.本地代理需要支持可选参数4和5，分别是headers和to_bytes。同时对py和js源生效  
[修改位置](./本地代理图片.jpg)  
建议代码:

```java
private Object[] proxy1(Map<String, String> params) {
        JSObject object = new JSUtils<String>().toObj(ctx, params);
        JSONArray array = ((JSArray) jsObject.getJSFunction("proxy").call(object)).toJsonArray();
        int code = array.optInt(0);
        String mime = array.optString(1);
        ByteArrayInputStream input = getStream(array.opt(2));
        Map<String, String> headers = null;
        if(array.length() > 3){
            headers = Json.toMap(array.opt(3).toString());
        }
        if (array.length() > 4) {
            try {
                int type = array.optInt(4);
                if (type == 1) {
                    String content = array.optString(2);
                    if (content.contains("base64,"))
                        content = content.substring(content.indexOf("base64,") + 7);
                    LOG.e(content);
                    input = new ByteArrayInputStream(Base64.decode(content, Base64.DEFAULT));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return new Object[]{code, mime, input, headers};
    }

```

3.t4搜索受数据无图片影响会自动乱请求detail接口，建议无图模式不要做这种操作，不然数据结果对不上  
预期及抓包发现搜索接口返回了很多条数据，结果壳子跑去执行了detail方法最后搜索数据不对了  
[接口抓包](./t4搜索接口.jpg)  
[问题](./t4搜索问题.jpg)

4.qjs缺少batchFetch函数的注入，期待壳子加入(hipy-t4已实现),下面是使用示例

```javascript
let data = batchFetch([{
    url: 'http://www.a.cn',
    options: {headers: {}, body: 'a=1&b=2', method: 'POST'}
}, {url: 'http://www.b.cn'}]);
log(data[0] + '=====' + data[1]);
```

[解决方案](./batchFetch解决方案.md)

5.壳子hipy兼容drpy源传参问题  
壳子自动处理的./和../相对路径替换存在逻辑漏洞，替换的结果可能不正确。建议修改
ext属性里不在开头出现的./或着../应该保持不变或着按照ext的完整路径来进行相对处理。  
目前大部分壳子都是按照api的路径来全局替换的，非常不合理

6.req的post不能正确处理content-type为post-form类型body自动编码
除了zyplayer和海阔视界之外所有box的req进行post提交行为的时候，表单参数是base64且长度超过一定值的时候貌似会表现异常。
疑似是壳子的req不能对这种content-type正确的进行编码提交。海阔、zy、hipy-t4都是正常的。不需要手动去编码提交参数。  
解决办法:req内部判断一下content-type，不需要postType这种参数

7.box的qjs加载有问题，drpy2受影响jinja无法正常用。  
[解决方案](./qjs错误解决方案.md)

### 已解决问题的壳子

| 问题\壳子 | BOX[黑白] | 影视仓 | easybox | 影视/ok | 海阔视界 | zyplayer | 装逼壳子/影图 | 爱佬版TV盒子 |
|-------|---------|-----|---------|-------|------|----------|---------|---------|
| 1     | ❌       | ❌   | ✅       | ✅     | ✅    | ✅        | ✅       | ❌       |
| 2     | ❌       | ❌   | ✅       | ✅     | ✅    | ✅        | ✅       | ❌       |
| 3     | ❌       | ❌   | ✅       | ✅     | ✅    | ✅        | ✅       | ❌       |
| 4     | ❌       | ❌   | ✅       | ❌     | ✅    | ❌        | ✅       | ❌       |
| 5     | ❌       | ❌   | ✅       | ❌     | ✅    | ✅        | ✅       | ✅       |
| 6     | ❌       | ❌   | ✅       | ❌     | ✅    | ✅        | ❌       | ❌       |
| 7     | ❌       | ❌   | ✅       | ❌     | ✅    | ✅        | ❌       | ❌       |
