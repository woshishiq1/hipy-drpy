#!/usr/bin/env bash
# 适配 Android/Termux/MT 管理器环境

# ================= 配置区 =================
MY_REPO_URL="https://github.com/cluntop/tvbox.git"
LOG_FILE="/data/data/bin.mt.plus/home/tvbox/.github/git.log"

# ================= 颜色与样式 =================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

# ================= 基础函数 =================
mkdir -p "$(dirname "$LOG_FILE")" 2>/dev/null

log() {
    if [ -w "$(dirname "$LOG_FILE")" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    fi
}

success_msg() { echo -e "${GREEN}✔ $1${NC}"; log "成功: $1"; }
error_msg() { echo -e "${RED}✘ $1${NC}"; log "错误: $1"; }
warn_msg() { echo -e "${YELLOW}⚠ $1${NC}"; log "警告: $1"; }
info_msg() { echo -e "${CYAN}ℹ $1${NC}"; }
title_msg() { echo -e "\n${BOLD}${PURPLE}>>> $1 <<<${NC}\n"; }

check_git() {
    if ! command -v git > /dev/null 2>&1; then
        error_msg "未检测到 Git，请先安装。"
        exit 1
    fi
}

check_git_repo() {
    if [ ! -d ".git" ]; then
        return 1
    fi
    return 0
}

# ================= 核心增强功能 =================

# 1. 增强版提交 (可视化 & 自定义)
enhanced_submit() {
    title_msg "🚀 提交与推送工作流"
    if ! check_git_repo; then error_msg "当前非 Git 仓库"; return 1; fi

    local changes=$(git status --porcelain)
    if [ -z "$changes" ]; then
        warn_msg "工作区很干净，没有需要提交的文件。"
        return 0
    fi

    echo -e "${YELLOW}待提交的文件变更:${NC}"
    git status --short
    echo ""

    # 自定义提交信息
    read -p "📝 输入提交信息 (直接回车默认: Update Up): " msg
    [ -z "$msg" ] && msg="Update Up"

    info_msg "1/3 执行 git add . ..."
    git add .

    info_msg "2/3 执行 git commit ..."
    git commit -m "$msg"

    local curr=$(git branch --show-current)
    [ -z "$curr" ] && curr="main"

    info_msg "3/3 推送至 origin/$curr ..."
    if git push origin "$curr"; then
        success_msg "推送成功！"
    else
        warn_msg "推送失败！远程仓库存在本地没有的更新 (fetch first)。"
        read -p "⚠ 是否执行真正的强制推送 (将完全覆盖远程仓库数据)? (y/n): " force_push
        if [[ "$force_push" =~ ^[Yy]$ ]]; then
            info_msg "正在执行强推 (git push -f) ..."
            git push -f --set-upstream origin "$curr" && success_msg "强制推送成功！(已覆盖远程)" || error_msg "推送依然失败，请检查网络或权限"
        else
            info_msg "已取消强制推送。建议先返回主菜单执行 [2] 📥 拉取与合并。"
        fi
    fi
}

# 2. 增强版拉取 (安全检测 & 状态展示)
enhanced_pull() {
    title_msg "📥 拉取最新更新"
    if ! check_git_repo; then error_msg "当前非 Git 仓库"; return 1; fi

    local curr=$(git branch --show-current)
    [ -z "$curr" ] && curr="main"

    info_msg "1/2 正在获取远程状态 (git fetch)..."
    git fetch origin 2>/dev/null

    # 检查是否有冲突风险
    local local_changes=$(git status --porcelain)
    if [ -n "$local_changes" ]; then
        warn_msg "检测到本地有未提交的更改，直接拉取可能导致冲突！"
        read -p "是否暂存(stash)本地更改后再拉取? (y/n): " stash_choice
        if [[ "$stash_choice" =~ ^[Yy]$ ]]; then
            git stash
            info_msg "本地更改已暂存。"
        fi
    fi

    info_msg "2/2 正在拉取代码合并 (git pull origin $curr)..."
    if git pull origin "$curr" 2>&1; then
        success_msg "拉取成功，已同步到最新状态。"
    else
        error_msg "拉取失败，存在冲突或网络问题。"
        # 如果刚才暂存了，提示用户恢复
        if [[ "$stash_choice" =~ ^[Yy]$ ]]; then
            warn_msg "请注意：您的本地更改在 stash 中，请手动解决冲突后运行 'git stash pop'"
        fi
    fi
}

# 3. 分支管理 (新增功能)
manage_branches() {
    title_msg "🌿 分支管理"
    if ! check_git_repo; then error_msg "当前非 Git 仓库"; return 1; fi
    
    echo -e "${CYAN}当前本地分支:${NC}"
    git branch -a
    echo ""
    echo "1) 创建并切换新分支"
    echo "2) 切换到已有分支"
    echo "3) 返回"
    read -p "请选择: " b_choice
    case $b_choice in
        1) 
            read -p "输入新分支名称: " b_name
            [ -n "$b_name" ] && git checkout -b "$b_name" && success_msg "已切换到新分支: $b_name"
            ;;
        2) 
            read -p "输入目标分支名称: " b_name
            [ -n "$b_name" ] && git checkout "$b_name" && success_msg "已切换到分支: $b_name"
            ;;
    esac
}

# 4. 可视化日志 (新增功能)
view_logs() {
    title_msg "📜 Git 提交日志"
    if ! check_git_repo; then error_msg "当前非 Git 仓库"; return 1; fi
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n 10
    echo -e "\n"
}

# 5. 原有功能优化 (绑定仓库、初始化、切换目录、清理)
bind_remote() {
    title_msg "🔗 绑定远程仓库"
    check_git_repo || return 1
    local current_url=$(git remote get-url origin 2>/dev/null)
    
    echo -e "当前仓库地址: ${YELLOW}${current_url:-"未设置"}${NC}"
    echo -e "目标固定地址: ${GREEN}$MY_REPO_URL${NC}"
    
    read -p "确定要将 origin 设置为目标固定地址吗? (y/n): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git remote remove origin 2>/dev/null
        git remote add origin "$MY_REPO_URL" && success_msg "已绑定远程仓库" || error_msg "绑定失败"
    fi
}

init_repo() {
    title_msg "📦 初始化新仓库"
    if [ -d ".git" ]; then error_msg "当前目录已是 Git 仓库"; return 1; fi
    git init && git checkout -b main 2>/dev/null || git branch -M main
    success_msg "初始化完成，当前分支: main"
}

change_dir() {
    title_msg "📁 切换工作目录"
    echo -e "当前路径: ${YELLOW}$(pwd)${NC}"
    read -p "输入新路径 (支持相对/绝对路径): " new_path
    if [ -n "$new_path" ]; then
        mkdir -p "$new_path" 2>/dev/null
        cd "$new_path" && success_msg "已切换至: $(pwd)" || error_msg "路径切换失败"
    fi
}

deep_clean() {
    title_msg "🧹 深度清理与空间回收"
    check_git_repo || return 1
    info_msg "清理 reflog 并压缩对象..."
    git reflog expire --expire=now --all 2>/dev/null
    git gc --prune=now --aggressive 2>/dev/null
    success_msg "深度清理完成！当前 .git 体积: $(du -sh .git 2>/dev/null | cut -f1)"
}

# ================= 新增：单独推送功能 =================
push_only() {
    title_msg "📤 单独推送 (Push Only)"
    if ! check_git_repo; then error_msg "当前非 Git 仓库"; return 1; fi

    local curr=$(git branch --show-current)
    [ -z "$curr" ] && curr="main"

    info_msg "正在推送至 origin/$curr ..."
    if git push origin "$curr"; then
        success_msg "推送成功！"
    else
        warn_msg "推送失败！远程仓库存在本地没有的更新 (fetch first)。"
        read -p "⚠ 是否执行真正的强制推送 (将完全覆盖远程仓库数据)? (y/n): " force_push
        if [[ "$force_push" =~ ^[Yy]$ ]]; then
            info_msg "正在执行强推 (git push -f) ..."
            git push -f --set-upstream origin "$curr" && success_msg "强制推送成功！(已覆盖远程)" || error_msg "推送依然失败，请检查网络或权限"
        else
            info_msg "已取消强制推送。建议先返回主菜单执行 [2] 📥 拉取与合并。"
        fi
    fi
}

# ================= 可视化仪表盘 (主菜单) =================
show_dashboard() {
    clear 2>/dev/null || printf '\033[2J\033[H'
    echo -e "${BOLD}${BLUE}══════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${CYAN}          🛠️ Git Master 可视化终端工具          ${NC}"
    echo -e "${BOLD}${BLUE}══════════════════════════════════════════════${NC}"
    
    echo -e " 📍 ${BOLD}当前路径:${NC} ${YELLOW}$(pwd)${NC}"
    
    if check_git_repo; then
        local b_name=$(git branch --show-current 2>/dev/null)
        local changes=$(git status --porcelain 2>/dev/null | wc -l)
        local remote=$(git remote get-url origin 2>/dev/null || echo "未绑定")
        echo -e " 🌿 ${BOLD}当前分支:${NC} ${GREEN}${b_name:-"未命名"}${NC}"
        echo -e " 🔗 ${BOLD}远程仓库:${NC} ${CYAN}${remote}${NC}"
        if [ "$changes" -gt 0 ]; then
            echo -e " 📝 ${BOLD}文件状态:${NC} ${RED}有 $changes 个文件未提交${NC}"
        else
            echo -e " 📝 ${BOLD}文件状态:${NC} ${GREEN}工作区干净${NC}"
        fi
    else
        echo -e " ⚠️  ${BOLD}仓库状态:${NC} ${RED}当前目录不是 Git 仓库${NC}"
    fi
    echo -e "${BOLD}${BLUE}──────────────────────────────────────────────${NC}"
    
    echo -e " ${GREEN}[1] 🚀 提交与推送 (Commit & Push)${NC}"
    echo -e " ${CYAN}[2] 📥 拉取与合并 (Fetch & Pull)${NC}"
    echo -e " ${YELLOW}[3] 📜 查看日志 (Log Graph)${NC}"
    echo -e " ${PURPLE}[4] 🌿 分支管理 (Branch Mgt)${NC}"
    echo -e " ${BLUE}[5] 🔗 绑定固定仓库 (Bind Remote)${NC}"
    echo -e " ${CYAN}[6] 📦 初始化仓库 (Init)${NC}"
    echo -e " ${YELLOW}[7] 📁 切换目录 (Change Dir)${NC}"
    echo -e " ${RED}[8] 🧹 深度清理 (GC & Clean)${NC}"
    echo -e " ${PURPLE}[9] 📤 单独推送 (Push Only)${NC}"
    echo -e " ${BOLD}[0] ❌ 退出 (Exit)${NC}"
    echo -e "${BOLD}${BLUE}══════════════════════════════════════════════${NC}"
}

# Root 权限检查
if [ "$(id -u)" -ne 0 ]; then
    warn_msg "建议使用 Root 权限执行以避免权限不足..."
fi

check_git

# 主循环
while true; do
    show_dashboard
    read -p "👉 请选择操作编号: " choice
    case $choice in
        1) enhanced_submit ;;
        2) enhanced_pull ;;
        3) view_logs ;;
        4) manage_branches ;;
        5) bind_remote ;;
        6) init_repo ;;
        7) change_dir ;;
        8) deep_clean ;;
        9) push_only ;;
        0) echo "再见！"; exit 0 ;;
        *) error_msg "无效的选项，请重新输入" ;;
    esac
    echo ""
    read -p "Press Enter to continue..."
done
