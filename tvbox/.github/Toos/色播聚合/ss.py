# coding=utf-8
import requests
import time
import os
import logging
from logging.handlers import TimedRotatingFileHandler

# ===================== 配置区 =====================
BASE_URL = "http://api.hclyz.com:81/mf"
M3U_FILE = "色播聚合.m3u"
LOG_FILE = "scraper.log"

# 屏蔽词配置：包含以下关键词的标题将被过滤
BLACK_LIST = ["支付宝风控解除", "依依实力带飞"]

# Telegram 配置
TELEGRAM_BOT_TOKEN = "YOUR_BOT_TOKEN"
TELEGRAM_CHAT_ID = "YOUR_CHAT_ID"

HEADERS = {"User-Agent": "Mozilla/5.0"}
VALID_PREFIX = ("http://", "https://", "rtmp://")
# ==================================================

# --- 日志配置 ---
def setup_logging():
    logger = logging.getLogger("ScraperLogger")
    logger.setLevel(logging.INFO)
    
    # 格式化器：包含 [时间] [级别] 内容
    formatter = logging.Formatter('[%(asctime)s] %(levelname)s: %(message)s', datefmt='%Y-%m-%d %H:%M:%S')

    # 控制台输出
    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)

    # 文件输出：每 7 天滚动一次，保留 1 个备份
    file_handler = TimedRotatingFileHandler(
        LOG_FILE, when="D", interval=7, backupCount=1, encoding="utf-8"
    )
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    return logger

log = setup_logging()

def safe_get_json(url):
    """安全获取 JSON，失败返回 None"""
    try:
        r = requests.get(url, headers=HEADERS, timeout=10)
        if r.status_code != 200:
            return None
        return r.json()
    except Exception as e:
        log.error(f"网络请求异常: {url} -> {e}")
        return None

def is_valid_stream(url):
    """合法流地址判断"""
    url = url.lower()
    return url.startswith(VALID_PREFIX) and (".m3u8" in url or ".flv" in url or ".mp4" in url or url.startswith("rtmp://"))

def send_to_telegram_message(bot_token, chat_id, message):
    """发送文本消息到 Telegram"""
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    data = {'chat_id': chat_id, 'text': message, 'parse_mode': 'Markdown'}
    try:
        requests.post(url, data=data, timeout=15)
    except Exception as e:
        log.error(f"Telegram 消息发送失败: {e}")

def send_to_telegram_file(file_path, bot_token, chat_id):
    """发送文件到 Telegram"""
    url = f"https://api.telegram.org/bot{bot_token}/sendDocument"
    try:
        with open(file_path, 'rb') as f:
            files = {'document': f}
            data = {'chat_id': chat_id}
            r = requests.post(url, files=files, data=data, timeout=30)
        if r.status_code == 200:
            log.info(f"文件已发送到 Telegram（Chat ID: {chat_id}）")
        else:
            log.error(f"Telegram 上传失败，状态码：{r.status_code}")
    except Exception as e:
        log.error(f"Telegram 上传异常：{e}")

def main():
    total_error = 0
    total_success = 0
    total_filtered = 0  # 统计过滤数量

    if TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID:
        send_to_telegram_message(TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID, "🚀 开始采集直播源...")

    log.info("🚀 任务启动：开始抓取色播聚合数据")

    home = safe_get_json(f"{BASE_URL}/json.txt")
    if not home:
        log.error("首页数据获取失败，采集终止")
        return

    data = home.get("pingtai", [])[1:]
    data = sorted(data, key=lambda x: int(x.get("Number", 0) or 0), reverse=True)

    m3u_lines = ["#EXTM3U"]
    seen_urls = set()

    for item in data:
        room_title = item.get("title", "").strip()
        number = item.get("Number", "")
        address = item.get("address", "")

        log.info(f"📺 正在处理：{room_title}（{number}）")

        detail = safe_get_json(f"{BASE_URL}/{address}")
        if not detail:
            total_error += 1
            continue

        zhubo = detail.get("zhubo", [])
        if not zhubo:
            total_error += 1
            continue

        group_name = f"-{room_title}"

        for vod in zhubo:
            name = vod.get("title", "").strip()
            url = vod.get("address", "").strip()

            # 1. 过滤屏蔽词
            if any(keyword in name for keyword in BLACK_LIST):
                log.info(f"🚫 已过滤屏蔽词频道: {name}")
                total_filtered += 1
                continue

            # 2. 检查流有效性
            if not url or not is_valid_stream(url):
                total_error += 1
                continue

            # 3. 去重处理
            if url in seen_urls:
                continue

            seen_urls.add(url)
            m3u_lines.append(f'#EXTINF:-1 group-title="{group_name}",{name}')
            m3u_lines.append(url)
            total_success += 1

        time.sleep(0.3)  # 防限频

    # 保存 m3u
    try:
        with open(M3U_FILE, "w", encoding="utf-8") as f:
            f.write("\n".join(m3u_lines))
        log.info(f"📄 播放列表已生成: {M3U_FILE}")
    except Exception as e:
        log.error(f"写入文件失败: {e}")

    log.info(f"✅ 完成！有效：{total_success}，过滤：{total_filtered}，异常：{total_error}")

    if TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID:
        msg = (f"✅ 采集完成\n"
               f"有效流：{total_success}\n"
               f"已屏蔽：{total_filtered}\n"
               f"异常数：{total_error}")
        send_to_telegram_message(TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID, msg)
        send_to_telegram_file(M3U_FILE, TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID)

if __name__ == "__main__":
    main()