#!/bin/bash
set -x
# 配置信息
SOURCE_REPO="https://github.com/ljlfct01/ljlfct01.github.io"
TARGET_REPO="https://${GITHUB_TOKEN}@github.com/leexuben/ljlfct01.github.io"
TEMP_DIR=$(mktemp -d)

echo "使用临时目录: $TEMP_DIR"
cd $TEMP_DIR

# 配置 Git
git config --global user.name "leexuben"
git config --global user.email "745425103@qq.com"

# 函数：获取仓库文件列表和哈希
get_repo_files() {
    local repo_url=$1
    local dir_name=$2
    
    echo "克隆仓库: $repo_url"
    timeout 600 git clone --depth=1 --filter=tree:0 "$repo_url" "$dir_name"
    cd "$dir_name"
    
    # 获取文件列表和哈希
    find . -type f -not -path './.git/*' -exec sha256sum {} \; | sort > "../${dir_name}_files.txt"
    cd ..
}

# 函数：同步文件
sync_files() {
    local source_dir=$1
    local target_dir=$2
    
    cd "$target_dir"
    
    # 比较文件差异
    while IFS= read -r line; do
        file_hash=$(echo "$line" | awk '{print $1}')
        file_path=$(echo "$line" | awk '{print $2}' | sed 's/^\.\///')
        
        # 检查目标文件是否存在且哈希相同
        if [ -f "$file_path" ]; then
            target_hash=$(sha256sum "$file_path" | awk '{print $1}')
            if [ "$target_hash" != "$file_hash" ]; then
                echo "更新文件: $file_path"
                cp "../$source_dir/$file_path" "$file_path"
            fi
        else
            echo "新增文件: $file_path"
            mkdir -p "$(dirname "$file_path")"
            cp "../$source_dir/$file_path" "$file_path"
        fi
    done < "../${source_dir}_files.txt"
    
    # 删除源仓库不存在的文件
    while IFS= read -r line; do
        file_path=$(echo "$line" | awk '{print $2}' | sed 's/^\.\///')
        if ! grep -q "$file_path" "../${source_dir}_files.txt"; then
            echo "删除文件: $file_path"
            rm -f "$file_path"
            # 删除空目录
            dir_path=$(dirname "$file_path")
            if [ -d "$dir_path" ] && [ -z "$(ls -A "$dir_path")" ]; then
                rmdir "$dir_path"
            fi
        fi
    done < "../${target_dir}_files.txt"
    
    cd ..
}

# 主同步流程
main() {
    # 获取源仓库文件信息
    get_repo_files "$SOURCE_REPO" "source_repo"
    
    # 获取目标仓库文件信息
    get_repo_files "$TARGET_REPO" "target_repo"
    
    # 比较两个仓库的最近提交时间
    cd "source_repo"
    source_date=$(git log -1 --format=%ct)
    cd "../target_repo"
    target_date=$(git log -1 --format=%ct)
    cd ..
    
    if [ "$source_date" -gt "$target_date" ]; then
        echo "源仓库有更新，开始同步..."
        
        # 同步文件
        sync_files "source_repo" "target_repo"
        
        # 提交更改
        cd "target_repo"
        if [ -n "$(git status --porcelain)" ]; then
            echo "提交更改到目标仓库"
            git add .
            git commit -m "自动同步 $(date '+%Y-%m-%d %H:%M:%S')"
            timeout 300 git push origin main
            echo "✅ 同步完成"
        else
            echo "✅ 文件已是最新，无需同步"
        fi
    else
        echo "✅ 目标仓库已是最新版本，无需同步"
    fi
}

# 执行主函数
main

# 清理
cd /
rm -rf "$TEMP_DIR"
echo "脚本执行完成"