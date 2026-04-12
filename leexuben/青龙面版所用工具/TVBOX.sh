#!/bin/bash
# 终极低内存方案 - 直接Git操作，不处理文件内容

SOURCE_REPO="https://github.com/yuanwangokk-1/TV-BOX"
TARGET_REPO="https://${GITHUB_TOKEN}@github.com/leexuben/TV-BOX"

echo "🚀 使用Git原生同步 (零内存方案)"

# 直接操作远程仓库
git clone --depth=1 "$TARGET_REPO" temp_repo
cd temp_repo

git remote add source "$SOURCE_REPO"
git fetch source

# 使用Git的增量合并（最低内存）
git merge --strategy-option=theirs source/main

# 强制推送
git push --force origin main

cd ..
rm -rf temp_repo
echo "✅ 同步完成"