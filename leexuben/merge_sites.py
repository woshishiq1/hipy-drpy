#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import sys
import json
import time
import requests

# ======================
# 配置（全部走环境变量，带默认值）
# ======================
SOURCES_JSON_PATH = os.environ.get("SOURCES_JSON_PATH", "sources.json")
TARGET_JSON_PATH = os.environ.get("TARGET_JSON_PATH", "TV.json")

MY_GITHUB_TOKEN = os.environ.get("MY_GITHUB_TOKEN", "")
GITHUB_REPO = os.environ.get("GITHUB_REPO", "leexuben/TVBOX-merge")
GITHUB_BRANCH = os.environ.get("GITHUB_BRANCH", "main")

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; TVBoxMerge/1.0)"
}

# ======================
# 拉取站点 / lives
# ======================
def get_data_from_url(url):
    """
    返回:
    {
        "sites": [...],
        "lives": [...]
    }
    """
    try:
        r = requests.get(url, headers=HEADERS, timeout=15)
        if r.status_code == 200:
            data = json.loads(r.text)

            sites = []
            lives = []

            if isinstance(data, dict):
                if "sites" in data and isinstance(data["sites"], list):
                    sites = data["sites"]
                if "lives" in data and isinstance(data["lives"], list):
                    lives = data["lives"]
            elif isinstance(data, list):
                # 兼容旧格式，当成 sites
                sites = data

            return {
                "sites": sites,
                "lives": lives
            }
    except Exception as e:
        print(f"[拉取失败] {url} | {e}")
    return {"sites": [], "lives": []}



# ======================
# 修复路径
# ======================
def fix_item_paths(item, base):
    if not base:
        return item
    base = base.rstrip("/")
    for k, v in item.items():
        if isinstance(v, str) and v.startswith("./"):
            item[k] = base + "/" + v[2:]
    return item



# ======================
# 主流程
# ======================
def main():
    print("=" * 60)
    print("TVBox 站点 & Live 合并脚本")
    print(f"时间: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)

    if not os.path.exists(SOURCES_JSON_PATH):
        print(f"[错误] 找不到源配置文件: {SOURCES_JSON_PATH}")
        sys.exit(1)

    with open(SOURCES_JSON_PATH, "r", encoding="utf-8") as f:
        sources = json.load(f)

    print(f"[读取] 加载了 {len(sources)} 个源")

    # ---------- 读取目标文件 ----------
    if os.path.exists(TARGET_JSON_PATH):
        with open(TARGET_JSON_PATH, "r", encoding="utf-8") as f:
            target_data = json.load(f)

        sites = target_data.get("sites", [])
        lives = target_data.get("lives", [])
        existing_fields = {
            k: v for k, v in target_data.items()
            if k not in ("sites", "lives")
        }

        print(f"[读取] 现有 sites: {len(sites)}")
        print(f"[读取] 现有 lives: {len(lives)}")
    else:
        sites = []
        lives = []
        existing_fields = {}

    site_keys = {s.get("key") for s in sites if s.get("key")}
    live_names = {l.get("name") for l in lives if l.get("name")}

    # ---------- 合并 ----------
    added_sites = 0
    added_lives = 0

    for i, src in enumerate(sources, 1):
        url = src.get("url")
        base = src.get("base", "")
        if not url:
            continue

        print(f"[{i}/{len(sources)}] 处理: {url}")

        data = get_data_from_url(url)

        # 合并 sites
        for s in data.get("sites", []):
            key = s.get("key")
            if key and key not in site_keys:
                sites.append(fix_item_paths(s, base))
                site_keys.add(key)
                added_sites += 1

        # ✅ 合并 lives（按 name 去重）
        for l in data.get("lives", []):
            name = l.get("name")
            if name and name not in live_names:
                lives.append(fix_item_paths(l, base))
                live_names.add(name)
                added_lives += 1

    # ---------- 写出 ----------
    result = {
        "sites": sites,
        "lives": lives,
        **existing_fields
    }

    with open(TARGET_JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=2)

    print("=" * 60)
    print(f"[完成] sites 总数: {len(sites)}，新增: {added_sites}")
    print(f"[完成] lives 总数: {len(lives)}，新增: {added_lives}")
    print(f"[完成] 已写入 {TARGET_JSON_PATH}")
    print("=" * 60)



if __name__ == "__main__":
    main()
