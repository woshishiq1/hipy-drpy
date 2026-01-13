# 可用壳（排名根据公开发布时间）
- 影视
    ```text
    https://github.com/FongMi/Release
    ```
- uz影视
    ```text
    https://t.me/uzVideoApp
    ```
- MiraPlay
    ```text
    https://apps.apple.com/us/app/miraplay/id6749287494?l=zh-Hans-CN
    ```
- PeekPili
    ```text
    https://github.com/ingriddaleusag-dotcom/PeekPiliRelease
    ```
- JSTV
    ```text
    https://t.me/jstvapp
    ```

# 更新说明
目前player和spider项目合并在一起了，actions自动发布的时候会一起编译提交，所以非必要，不需要更新player
- 2025/12/26
  - webdav支持百度分享挂载
  - webdav天翼挂载支持根目录文件，支持ios(爆米花播放)
  - 后台网盘设置不再显示未配置的网盘类型，填百度ck的时候提示"未定义的网盘类型"
- 2025/12/24 合并项目，更新百度无密码分享播放问题

---

# 使用说明（必读）

⚠️ **不建议在云服务器上运行**

- 很多源在云服务器环境下无法打开
- **如果是境外服务器可能造成网盘账号被封禁风险**

✅ **推荐运行环境**：

- 家用 **NAS**
- **软路由**
- 本地网络环境

---

## 一、部署步骤

### 1️⃣ 复制 Docker 目录

将 `docker` 目录复制到任意位置。

### 2️⃣ 启动服务

终端进入 `docker-compose.yml` 所在目录，执行：

```bash
docker-compose up -d
```

---

## 二、需要修改的配置文件

### 1️⃣ Vod 配置

```text
/docker/vod/config.json
根据实际情况修改配置内容。
```

---

### 2️⃣ Clash 配置

```text
/docker/clash/config.yaml
将你的 Clash 订阅地址 添加到指定位置即可，有能力的可以自己编写规则
```

---

## 三、后台管理信息

- 后台地址：

  ```text
  http://容器ip:8080
  ```

- 默认账号：
  - 用户名：`vodspider`
  - 密码：`abc123`

---

## 四、注意事项

- Docker 镜像下载可能被墙  
  👉 可使用镜像源：

  ```text
  https://dockerpull.com
  ```

- **更新说明**：
  - 通常只需要替换：
    ```text
    /docker/vod/index.js
    ```
  - 特殊情况下会更新 `player` 文件夹
  - 其余文件一般无需替换，最多修改 `config.json`

---

## 五、Telegram 配置示例

tgx 可以搜索 TG 群组，需要登陆 TG 客户端，配置示例：

```json
"tgclient": {
  "apiId": 11111,
  "apiHash": "xxxxxxxxxxxxxxxx",
  "autoDownPic": true
}
```

---

## 六、重定向配置说明

如果在 `config.json` 中配置了类似地址：

```text
http://localhost:3000/redirect/xxx
```

则需要在后台配置对应的 **重定向映射**。

### 示例

```json
{
  "xxx": "https://www.baidu.com"
}
```
