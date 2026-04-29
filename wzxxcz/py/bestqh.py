# -*- coding: utf-8 -*-
# 兼容：OK影视、影视仓、TVBox 全壳子
# 不转圈 + 不超时 + 稳定运行

CONFIG = {
    "HOST": "https://www.bestqh.com",
    "CATEGORIES": [
        {"type_id":"1","type_name":"电影"},
        {"type_id":"2","type_name":"电视剧"},
        {"type_id":"3","type_name":"综艺"},
        {"type_id":"4","type_name":"动漫"},
        {"type_id":"6","type_name":"短剧"}
    ]
}

import requests
import re
import json
import sys
from urllib.parse import urljoin

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36",
    "Referer": "https://www.bestqh.com"
}

def get_html(url):
    try:
        resp = requests.get(url, headers=HEADERS, timeout=5, verify=False)
        resp.encoding = "utf-8"
        return resp.text
    except:
        return ""

# 分类
def get_class():
    return CONFIG["CATEGORIES"]

# 首页
def get_home():
    html = get_html(CONFIG["HOST"])
    items = re.findall(r'<li class="video-item">.*?<a href="([^"]+)".*?data-original="([^"]+)".*?<h3><a.*?>([^<]+)</a>', html, re.S)
    res = []
    for x in items:
        res.append({"vod_id":x[0], "vod_name":x[2].strip(), "vod_pic":x[1]})
    return res[:30]

# 列表
def get_list(tid, pg=1):
    url = f"{CONFIG['HOST']}/type/{tid}/{pg}.html"
    html = get_html(url)
    items = re.findall(r'<li class="video-item">.*?<a href="([^"]+)".*?data-original="([^"]+)".*?<h3><a.*?>([^<]+)</a>', html, re.S)
    res = []
    for x in items:
        res.append({"vod_id":x[0], "vod_name":x[2].strip(), "vod_pic":x[1]})
    return res

# 搜索
def get_search(wd, pg=1):
    url = f"{CONFIG['HOST']}/search/{wd}/{pg}.html"
    html = get_html(url)
    items = re.findall(r'<li class="video-item">.*?<a href="([^"]+)".*?data-original="([^"]+)".*?<h3><a.*?>([^<]+)</a>', html, re.S)
    res = []
    for x in items:
        res.append({"vod_id":x[0], "vod_name":x[2].strip(), "vod_pic":x[1]})
    return res

# 详情
def get_detail(did):
    url = CONFIG["HOST"] + did
    html = get_html(url)

    try:
        title = re.search(r'<h2>([^<]+)</h2>', html).group(1).strip()
    except:
        title = ""
    try:
        pic = re.search(r'data-original="([^"]+)"', html).group(1)
    except:
        pic = ""
    try:
        desc = re.search(r'<div class="video-desc">([^<]+)</div>', html).group(1).strip()
    except:
        desc = "暂无简介"

    # 播放线路
    froms = []
    urls = []

    lines = re.findall(r'<div class="play-nav">.*?<ul>(.*?)</ul>', html, re.S)
    if lines:
        froms = re.findall(r'<li>([^<]+)</li>', lines[0])

    boxes = re.findall(r'<div class="play-box">.*?</div>', html, re.S)
    for box in boxes:
        eps = re.findall(r'<a href="([^"]+)">([^<]+)</a>', box)
        tmp = [f"{n.strip()}${urljoin(CONFIG['HOST'], u)}" for u, n in eps]
        urls.append("$$$".join(tmp))

    return {
        "vod_name": title,
        "vod_pic": pic,
        "vod_content": desc,
        "vod_play_from": "$$$".join(froms),
        "vod_play_url": "$$$".join(urls)
    }

# 执行入口
if __name__ == "__main__":
    try:
        cmd = sys.argv[1] if len(sys.argv) > 1 else ""
        if cmd == "home":
            print(json.dumps(get_home(), ensure_ascii=False))
        elif cmd == "list":
            tid = sys.argv[2] if len(sys.argv) > 2 else "1"
            pg = int(sys.argv[3]) if len(sys.argv) > 3 else 1
            print(json.dumps(get_list(tid, pg), ensure_ascii=False))
        elif cmd == "search":
            wd = sys.argv[2] if len(sys.argv) > 2 else ""
            pg = int(sys.argv[3]) if len(sys.argv) > 3 else 1
            print(json.dumps(get_search(wd, pg), ensure_ascii=False))
        elif cmd == "detail":
            did = sys.argv[2] if len(sys.argv) > 2 else ""
            print(json.dumps(get_detail(did), ensure_ascii=False))
        else:
            print(json.dumps(get_class(), ensure_ascii=False))
    except:
        print(json.dumps([], ensure_ascii=False))
