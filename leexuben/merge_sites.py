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

# 注意：GitHub Actions 会自动提供 GITHUB_TOKEN 环境变量
# 但在 Secrets 中我们不能用 GITHUB_TOKEN 这个名称
# 所以我们用自定义名称，然后通过工作流传递
MY_GITHUB_TOKEN = os.environ.get("MY_GITHUB_TOKEN", "")
GITHUB_REPO = os.environ.get("GITHUB_REPO", "leexuben/TVBOX-merge")
GITHUB_BRANCH = os.environ.get("GITHUB_BRANCH", "main")

# 打印调试信息
print(f"[调试] MY_GITHUB_TOKEN 长度: {len(MY_GITHUB_TOKEN)}")
print(f"[调试] GITHUB_REPO: {GITHUB_REPO}")
print(f"[调试] GITHUB_BRANCH: {GITHUB_BRANCH}")

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
# 主流程
# ======================
def main():
    print("=" * 60)
    print("TVBox 站点合并脚本")
    print(f"时间: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    
    # 1. 检查源配置文件
    if not os.path.exists(SOURCES_JSON_PATH):
        print(f"[错误] 找不到源配置文件: {SOURCES_JSON_PATH}")
        sys.exit(1)
    
    # 2. 读取源配置
    try:
        with open(SOURCES_JSON_PATH, "r", encoding="utf-8") as f:
            sources = json.load(f)
        print(f"[读取] 加载了 {len(sources)} 个源")
    except Exception as e:
        print(f"[错误] 读取源配置失败: {e}")
        sys.exit(1)
    
    # 3. 读取现有目标文件（如果存在）
    if os.path.exists(TARGET_JSON_PATH):
        try:
            with open(TARGET_JSON_PATH, "r", encoding="utf-8") as f:
                target_data = json.load(f)
            sites = target_data.get("sites", [])
            # 获取现有的非 sites 字段
            existing_fields = {k: v for k, v in target_data.items() if k != "sites"}
            print(f"[读取] 现有文件包含 {len(sites)} 个站点")
        except Exception as e:
            print(f"[警告] 读取目标文件失败，将新建: {e}")
            sites = []
            existing_fields = {}
    else:
        print(f"[提示] 目标文件不存在，将创建新文件")
        sites = []
        existing_fields = {}
    
    # 获取现有站点的 key 集合
    keys = {s.get("key") for s in sites if s.get("key")}
    
    # 4. 合并站点
    added_count = 0
    for i, src in enumerate(sources, 1):
        url = src.get("url")
        base = src.get("base", "")
        if not url:
            continue
        
        print(f"[{i}/{len(sources)}] 处理: {url}")
        new_sites = get_sites_from_url(url)
        for s in new_sites:
            key = s.get("key")
            if key and key not in keys:
                sites.append(fix_site_paths(s, base))
                keys.add(key)
                added_count += 1
    
    # 5. 生成结果，保留现有的非 sites 字段
    result = {
        "sites": sites,
        **existing_fields,  # 保留现有的非 sites 字段
    }
    
    # 6. 写入本地文件
    with open(TARGET_JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=2)
    
    print(f"[完成] 共 {len(sites)} 个站点，新增 {added_count} 个，已写入 {TARGET_JSON_PATH}")

if __name__ == "__main__":
    main()
