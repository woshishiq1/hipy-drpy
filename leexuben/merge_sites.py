#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import sys
import json
import time
import requests
import subprocess
import shutil
from pathlib import Path

# ======================
# 配置（全部走环境变量，带默认值）
# ======================
SOURCES_JSON_PATH = os.environ.get("SOURCES_JSON_PATH", "sources.json")
TARGET_JSON_PATH = os.environ.get("TARGET_JSON_PATH", "TV.json")

# Git 配置（新增）
GIT_REPO_DIR = os.environ.get("GIT_REPO_DIR", "./git_repo")  # 本地克隆的仓库目录
GIT_REMOTE_URL = os.environ.get("GIT_REMOTE_URL", "")  # Git 仓库远程地址，如：https://github.com/leexuben/TVBOX-merge.git 或 git@github.com:leexuben/TVBOX-merge.git
GIT_BRANCH = os.environ.get("GIT_BRANCH", "main")  # 推送分支
GIT_COMMIT_MESSAGE = os.environ.get("GIT_COMMIT_MESSAGE", "🔄 自动更新 TV.json (站点 & Live)")

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
# Git 强制推送功能（新增核心部分）
# ======================
def git_force_push(target_file_path, commit_message):
    """
    将指定的目标文件通过 Git 强制推送到远程仓库
    """
    print("=" * 50)
    print("[Git] 开始 Git 强制推送流程")
    print(f"[Git] 目标文件: {target_file_path}")
    print(f"[Git] 远程仓库: {GIT_REMOTE_URL}")
    print(f"[Git] 分支: {GIT_BRANCH}")
    print("=" * 50)

    # 1. 检查是否设置了远程仓库地址
    if not GIT_REMOTE_URL:
        print("[Git] 错误: 未设置 GIT_REMOTE_URL 环境变量")
        return False

    # 2. 克隆或准备本地仓库目录
    repo_dir = GIT_REPO_DIR
    target_file = target_file_path

    try:
        # 如果目录已存在，先删除（确保干净）
        if os.path.exists(repo_dir):
            print(f"[Git] 清理旧仓库目录: {repo_dir}")
            shutil.rmtree(repo_dir)

        # 克隆仓库（裸克隆不推荐，我们直接克隆普通仓库）
        print(f"[Git] 克隆仓库到: {repo_dir}")
        clone_cmd = ["git", "clone", GIT_REMOTE_URL, repo_dir]
        result = subprocess.run(clone_cmd, capture_output=True, text=True, timeout=30)
        if result.returncode != 0:
            print(f"[Git] 克隆失败: {result.stderr}")
            return False

        # 进入仓库目录
        os.chdir(repo_dir)

        # 检查是否有该文件，如果没有则从外部复制进来
        if not os.path.exists(target_file):
            # 假设目标文件在脚本同目录，复制到仓库目录
            script_dir = os.path.dirname(os.path.abspath(__file__))
            source_file = os.path.join(script_dir, target_file)
            if os.path.exists(source_file):
                print(f"[Git] 复制目标文件到仓库: {source_file} -> {repo_dir}/{target_file}")
                shutil.copy2(source_file, repo_dir)
            else:
                print(f"[Git] 错误: 目标文件 {target_file} 不存在于脚本目录")
                return False

        # 拉取最新代码（避免冲突，虽然我们要强制推送）
        print(f"[Git] 拉取最新代码 (git pull)")
        pull_cmd = ["git", "pull", "origin", GIT_BRANCH]
        pull_result = subprocess.run(pull_cmd, capture_output=True, text=True, timeout=20)
        if pull_result.returncode != 0:
            print(f"[Git] 拉取失败（可能首次克隆无更新）: {pull_result.stderr}")
            # 首次克隆可能没有远程分支，忽略错误

        # 添加目标文件
        print(f"[Git] 添加文件: {target_file}")
        add_cmd = ["git", "add", target_file]
        add_result = subprocess.run(add_cmd, capture_output=True, text=True, timeout=10)
        if add_result.returncode != 0:
            print(f"[Git] 添加文件失败: {add_result.stderr}")
            return False

        # 检查是否有变更
        status_cmd = ["git", "status", "--porcelain"]
        status_result = subprocess.run(status_cmd, capture_output=True, text=True, timeout=10)
        if not status_result.stdout.strip():
            print(f"[Git] 没有变更，无需提交")
            return True

        # 提交
        print(f"[Git] 提交变更: {commit_message}")
        commit_cmd = ["git", "commit", "-m", commit_message]
        commit_result = subprocess.run(commit_cmd, capture_output=True, text=True, timeout=10)
        if commit_result.returncode != 0:
            print(f"[Git] 提交失败: {commit_result.stderr}")
            return False

        # 强制推送到远程
        print(f"[Git] 强制推送分支: {GIT_BRANCH}")
        push_cmd = ["git", "push", "origin", GIT_BRANCH, "--force"]
        push_result = subprocess.run(push_cmd, capture_output=True, text=True, timeout=20)
        if push_result.returncode != 0:
            print(f"[Git] 强制推送失败: {push_result.stderr}")
            return False

        print(f"[Git] ✅ 强制推送成功！")
        return True

    except Exception as e:
        print(f"[Git] 异常: {e}")
        return False
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

    # ========== 新增：执行 Git 强制推送 ==========
    print("\n" + "=" * 50)
    print("[流程] 开始 Git 强制推送流程")
    print("=" * 50)

    git_success = git_force_push(TARGET_JSON_PATH, GIT_COMMIT_MESSAGE)

    if git_success:
        print("[最终] ✅ 脚本执行完成 & Git 强制推送成功")
    else:
        print("[最终] ⚠️  脚本执行完成，但 Git 强制推送失败，请检查配置")

# ======================
# 入口
# ======================
if __name__ == "__main__":
    main()
