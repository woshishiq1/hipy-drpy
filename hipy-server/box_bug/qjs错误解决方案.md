1.改壳子的代码:
```java
 private void createObj() {
        String content = Module.get().fetch(api);
        if (content.startsWith("//bb")) {
            cat = true;
            ctx.execute(Module.get().bb(content));
        } else {
            cat = content.contains("__jsEvalReturn");
            ctx.evaluateModule(String.format(Module.get().fetch("assets://js/lib/spider.js"), api));
        }
        jsObject = (JSObject) ctx.get(ctx.getGlobalObject(), "__JS_SPIDER__");
    }
    
    @Override
            public byte[] getModuleBytecode(String moduleName) {
                String content = Module.get().fetch(moduleName);
                content = content.replace("__JS_SPIDER__", "globalThis.__JS_SPIDER__");
                if(content.startsWith("//DRPY")){
                    return Base64.decode(content.substring(6), Base64.URL_SAFE);
                } else if(content.startsWith("//bb")){
                    return Module.get().bb(content);
                } else {
                    return ctx.compileModule(content, moduleName);
                }
            }


```
内置文件http.js的代码
```javascript
// globalThis.md5 = md5X;
globalThis.req = (url, options) => http(url, Object.assign({
    async: false
}, options));

function http(url, options = {}) {
    if (options?.async === false) return _http(url, options)
    return new Promise(resolve => _http(url, Object.assign({
        complete: res => resolve(res)
    }, options))).catch(err => {
        console.error(err.name, err.message, err.stack)
        return {
            ok: false,
            status: 500,
            url
        }
    })
}

Object.defineProperty(globalThis, 'global', {
    enumerable: true,
    get() {
        return globalThis;
    },
    set() {}
});

Object.defineProperty(globalThis, 'window', {
    enumerable: true,
    get() {
        return globalThis;
    },
    set() {}
});

Object.defineProperty(globalThis, 'self', {
    enumerable: true,
    get() {
        return globalThis;
    },
    set() {}
});

```
[qjs错误修复图片](./qjs错误修复.png)

2.修改文件spider.js  
```javascript
import * as spider from '%s'

if (!globalThis.__JS_SPIDER__) {
    if (spider.__jsEvalReturn) {
        globalThis.__JS_SPIDER__ = spider.__jsEvalReturn()
    } else if (spider.default) {
        globalThis.__JS_SPIDER__ = typeof spider.default === 'function' ? spider.default() : spider.default
    }
}
```
[spider.js](./spider.js)