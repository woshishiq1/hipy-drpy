# coding=utf-8
import os
import logging
import sys
import asyncio
import aiohttp

BASE_URL = "http://api.hclyz.com:81/mf"

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
TARGET_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "..", "lib"))
M3U_FILE = os.path.join(TARGET_DIR, "sbjh.m3u")

BLACK_LIST = ["支付宝风控解除", "依依实力带飞"]

HEADERS = {"User-Agent": "Mozilla/5.0"}
VALID_PREFIX = ("http://", "https://", "rtmp://")

MAX_WORKERS = 15

def setup_logging():
    logger = logging.getLogger("ScraperLogger")
    logger.setLevel(logging.INFO)
    
    formatter = logging.Formatter('[%(asctime)s] %(levelname)s: %(message)s', datefmt='%Y-%m-%d %H:%M:%S')

    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    return logger

log = setup_logging()

async def safe_get_json(url, session):
    try:
        async with session.get(url, headers=HEADERS, timeout=10) as r:
            if r.status != 200:
                return None
            return await r.json(content_type=None)
    except Exception as e:
        log.error(f"Request Exception: {url} -> {e}")
        return None

def is_valid_stream(url):
    url = url.lower()
    return url.startswith(VALID_PREFIX) and (".m3u8" in url or ".flv" in url or ".mp4" in url or url.startswith("rtmp://"))

async def process_platform(item, session, sem):
    async with sem:
        room_title = item.get("title", "").strip()
        number = item.get("Number", "")
        address = item.get("address", "")

        log.info(f"📺 Concurrent requests：{room_title}（{number}）")

        detail = await safe_get_json(f"{BASE_URL}/{address}", session)
        if not detail:
            return room_title, [], 1, 0

        zhubo = detail.get("zhubo", [])
        if not zhubo:
            return room_title, [], 1, 0

        group_name = f"{room_title}"
        results = []
        errors = 0
        filtered = 0

        for vod in zhubo:
            name = vod.get("title", "").strip()
            url = vod.get("address", "").strip()

            if any(keyword in name for keyword in BLACK_LIST):
                log.info(f"🚫 Blocked words: {name}")
                filtered += 1
                continue

            if not url or not is_valid_stream(url):
                errors += 1
                continue

            results.append((group_name, name, url))

        return room_title, results, errors, filtered

async def main_async():
    total_error = 0
    total_success = 0
    total_filtered = 0

    log.info("🚀 Task initiated.")
    log.info(f"📂 Output the absolute path：{M3U_FILE}")

    # aiohttp 连接池配置
    connector = aiohttp.TCPConnector(limit=MAX_WORKERS)
    async with aiohttp.ClientSession(connector=connector) as session:

        home = await safe_get_json(f"{BASE_URL}/json.txt", session)
        if not home:
            log.error("❌ Retrieval failed, collection terminated.")
            sys.exit(1)

        data = home.get("pingtai", [])[1:]
        data = sorted(data, key=lambda x: int(x.get("Number", 0) or 0), reverse=True)

        m3u_lines = ["#EXTM3U"]
        seen_urls = set()

        log.info(f"⚡ Multi-threading (Async): {MAX_WORKERS}")

        sem = asyncio.Semaphore(MAX_WORKERS)

        tasks = [process_platform(item, session, sem) for item in data]
        
        results = await asyncio.gather(*tasks)

        for room_title, res, errors, filtered in results:
            total_error += errors
            total_filtered += filtered
            
            for group_name, name, url in res:
                if url in seen_urls:
                    continue

                seen_urls.add(url)
                m3u_lines.append(f'#EXTINF:-1 group-title="{group_name}",{name}')
                m3u_lines.append(url)
                total_success += 1

    try:
        os.makedirs(os.path.dirname(M3U_FILE), exist_ok=True)
        
        with open(M3U_FILE, "w", encoding="utf-8") as f:
            f.write("\n".join(m3u_lines))
        log.info(f"📄 It has been generated and saved.")
        log.info(f"✅ Absolute path: {M3U_FILE}")
    except Exception as e:
        log.error(f"❌ Failed to write to file: {e}")
        sys.exit(1)

    summary_msg = f"Collection completed, valid：{total_success}，Shield：{total_filtered}，abnormal：{total_error}"
    log.info(summary_msg)
    
    print(f"::notice title=📁 Save path: {M3U_FILE}::{summary_msg}")

def main():
    asyncio.run(main_async())

if __name__ == "__main__":
    main()
