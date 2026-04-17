#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import sys
import json
import time
import requests
import base64

# ======================
# 配置（全部走环境变量，带默认值）
# ======================
SOURCES_JSON_PATH = os.environ.get("SOURCES_JSON_PATH", "sources.json")
TARGET_JSON_PATH = os.environ.get("TARGET_JSON_PATH", "青龙.json")

GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN", "")
GITHUB_REPO = os.environ.get("GITHUB_REPO", "")
GITHUB_BRANCH = os.environ.get("GITHUB_BRANCH", "main")

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; TVBoxMerge/1.0)"
}

# ======================
# 拉取站点
# ======================
def get_sites_from_url(url):
    try:
        r = requests.get(url, headers=HEADERS, timeout=15)
        if r.status_code == 200:
            data = json.loads(r.text)
            if isinstance(data, dict) and "sites" in data:
                return data["sites"]
            elif isinstance(data, list):
                return data
    except Exception as e:
        print(f"[拉取失败] {url} | {e}")
    return []

# ======================
# 修复路径
# ======================
def fix_site_paths(site, base):
    if not base:
        return site
    base = base.rstrip("/")
    for k, v in site.items():
        if isinstance(v, str) and v.startswith("./"):
            site[k] = base + "/" + v[2:]
    return site

# ======================
# GitHub 推送
# ======================
def push_to_github(path, content, repo, token, branch):
    api = f"https://api.github.com/repos/{repo}/contents/{path}"
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json"
    }

    sha = None
    r = requests.get(api, headers=headers, params={"ref": branch})
    if r.status_code == 200:
        sha = r.json().get("sha")

    data = {
        "message": f"Auto update {path} at {time.strftime('%Y-%m-%d %H:%M:%S')}",
        "content": base64.b64encode(content.encode("utf-8")).decode(),
        "branch": branch
    }
    if sha:
        data["sha"] = sha

    r = requests.put(api, headers=headers, json=data)
    return r.status_code in (200, 201)

# ======================
# 主流程
# ======================
def main():
    print("== TVBox 站点合并开始 ==")

    if not os.path.exists(SOURCES_JSON_PATH):
        print(f"[错误] 找不到 {SOURCES_JSON_PATH}")
        sys.exit(1)

    with open(SOURCES_JSON_PATH, "r", encoding="utf-8") as f:
        sources = json.load(f)

    sites = []
    keys = set()

    if os.path.exists(TARGET_JSON_PATH):
        with open(TARGET_JSON_PATH, "r", encoding="utf-8") as f:
            old = json.load(f)
            sites = old.get("sites", [])
            keys = {s.get("key") for s in sites if s.get("key")}

    for src in sources:
        url = src.get("url")
        base = src.get("base", "")
        if not url:
            continue

        print(f"[拉取] {url}")
        for s in get_sites_from_url(url):
            key = s.get("key")
            if key and key not in keys:
                sites.append(fix_site_paths(s, base))
                keys.add(key)

    result = {
        "sites": sites,
        "updateTime": time.strftime("%Y-%m-%d %H:%M:%S"),
        "total": len(sites)
    }

    with open(TARGET_JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=2)

    print(f"[完成] 共 {len(sites)} 个站点，已写入 {TARGET_JSON_PATH}")

    # ✅ GitHub 推送（仅在 Actions 且有配置时）
    if GITHUB_TOKEN and GITHUB_REPO:
        with open(TARGET_JSON_PATH, "r", encoding="utf-8") as f:
            content = f.read()
        ok = push_to_github(
            TARGET_JSON_PATH,
            content,
            GITHUB_REPO,
            GITHUB_TOKEN,
            GITHUB_BRANCH
        )
        print("[GitHub] 推送成功" if ok else "[GitHub] 推送失败")
    else:
        print("[提示] 未配置 GitHub，仅本地生成")

if __name__ == "__main__":
    main()
