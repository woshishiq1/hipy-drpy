#!/bin/env sh
#!/system/bin/sh

# 远程仓库地址
MY_REPO_URL="https://github.com/cluntop/tvbox.git"

# 日志文件路径
LOG_FILE="/data/data/bin.mt.plus/home/tvbox/.github/git.log"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 确保日志目录存在
mkdir -p "$(dirname "$LOG_FILE")" 2>/dev/null

# 日志记录函数
log() {
    if [ -w "$(dirname "$LOG_FILE")" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    fi
}

# 提示函数
success_msg() { echo -e "${GREEN}✓ $1${NC}"; log "成功: $1"; }
error_msg() { echo -e "${RED}✗ $1${NC}"; log "错误: $1"; }
warn_msg() { echo -e "${YELLOW}⚠ $1${NC}"; log "警告: $1"; }
info_msg() { echo -e "${CYAN}ℹ $1${NC}"; }

# 检查网络
check_network() {
    info_msg "检查网络连接..."
    if ping -c 1 -W 2 github.com > /dev/null 2>&1 || ping -c 1 -W 2 baidu.com > /dev/null 2>&1; then
        return 0
    else
        error_msg "网络连接失败"
        return 1
    fi
}

# 检查 Git
check_git() {
    if ! command -v git > /dev/null 2>&1; then
        error_msg "Git 未安装"
        exit 1
    fi
}

# 检查仓库状态
check_git_repo() {
    if [ ! -d ".git" ]; then
        warn_msg "当前目录不是 Git 仓库"
        return 1
    fi
    return 0
}

# Root 权限检查
if [ "$(id -u)" -ne 0 ]; then
    warn_msg "尝试获取 Root 权限..."
    exec sudo "$0" "$@" 2>/dev/null
fi

# 初始化
check_git

# ================= 核心功能 =================

# 1. 初始化仓库
init_repo() {
    if [ -d ".git" ]; then
        error_msg "这里已经是 Git 仓库了"
        return 1
    fi
    
    echo -e "准备在 ${YELLOW}$(pwd)${NC} 初始化..."
    read -p "确认? (y/n): " confirm
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        git init && git checkout -b main 2>/dev/null || git branch -M main
        success_msg "初始化完成"
        
        # 初始化后自动询问是否添加远程仓库
        read -p "是否立即关联远程仓库? (y/n): " add_remote
        if [ "$add_remote" = "y" ] || [ "$add_remote" = "Y" ]; then
            warehouse
        fi
    fi
}

# 2. 切换目录
change_work_dir() {
    echo -e "\n${BLUE}=== 切换工作目录 ===${NC}"
    echo "当前: $(pwd)"
    read -p "输入新路径: " new_path
    
    [ -z "$new_path" ] && return
    
    if [ ! -d "$new_path" ]; then
        read -p "目录不存在，创建? (y/n): " create
        if [ "$create" = "y" ] || [ "$create" = "Y" ]; then
            mkdir -p "$new_path" || { error_msg "创建失败"; return; }
        else
            return
        fi
    fi
    cd "$new_path" || return
    success_msg "已切换至: $(pwd)"
}

# 3. 设置固定远程仓库
warehouse() {
    info_msg "设置远程仓库..."
    if ! check_git_repo; then return 1; fi

    target_url="$MY_REPO_URL"
    
    # 检查当前配置
    if git remote get-url origin > /dev/null 2>&1; then
        current_url=$(git remote get-url origin)
        if [ "$current_url" == "$target_url" ]; then
            success_msg "远程仓库已正确配置: $target_url"
            return 0
        else
            warn_msg "当前远程仓库: $current_url"
            warn_msg "目标固定仓库: $target_url"
            read -p "是否覆盖为固定仓库地址? (y/n): " confirm
            if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
                return 0
            fi
            git remote remove origin
        fi
    fi

    if git remote add origin "$target_url" 2>&1; then
        success_msg "已绑定远程仓库: $target_url"
    else
        # 如果 add 失败，尝试 set-url
        git remote set-url origin "$target_url" && success_msg "已更新远程仓库: $target_url"
    fi
}

# 4. 拉取
branch() {
    if ! check_git_repo; then return 1; fi
    curr=$(git branch --show-current)
    [ -z "$curr" ] && curr="main"
    
    info_msg "拉取 origin/$curr ..."
    if git pull origin "$curr" 2>&1; then
        success_msg "拉取成功"
    else
        error_msg "拉取失败"
        # 尝试自动关联
        git branch --set-upstream-to=origin/"$curr" "$curr" 2>/dev/null
    fi
}

# 5. 提交
submit() {
    if ! check_git_repo; then return 1; fi
    
    if [ -z "$(git status --porcelain)" ]; then
        warn_msg "没有文件变动"
        return 0
    fi

    curr=$(git branch --show-current)
    [ -z "$curr" ] && curr="main"

    info_msg "1. 拉取更新..."
    git pull origin "$curr" > /dev/null 2>&1

    info_msg "2. 添加文件..."
    git add .

    info_msg "3. 提交推送..."
    msg="Update Up"
    git commit -m "$msg"
    
    if git push origin "$curr"; then
        success_msg "推送成功"
    else
        warn_msg "推送失败，尝试强制关联..."
        git push --set-upstream origin "$curr"
    fi
}

# 6. 状态
state() {
    [ -d ".git" ] && git status
}

# 7. 深度清理 (双重指令)
garbage() {
    if ! check_git_repo; then return 1; fi
    
    warn_msg "正在进行深度清理，请稍候..."
    
    # 步骤1: 清理过期引用记录
    echo "1/2: 清理 reflog..."
    git reflog expire --expire=now --all 2>/dev/null
    
    # 步骤2: 强力回收空间
    echo "2/2: 压缩并修剪对象..."
    if git gc --prune=now --aggressive 2>&1; then
        success_msg "深度清理完成！"
        # 显示大小
        size=$(du -sh .git 2>/dev/null | cut -f1)
        info_msg "当前仓库体积: $size"
    else
        error_msg "清理过程中出现问题"
    fi
}

# 菜单
show_menu() {
    clear 2>/dev/null || printf '\033[2J\033[H'
    echo -e "${CYAN}=== Git 管理工具 ===${NC}"
    echo -e "位置: ${YELLOW}$(pwd)${NC}"
    echo -e "固定仓库: ${GREEN}$MY_REPO_URL${NC}"
    echo ""
    echo "  1) 提交 (一键三连)"
    echo "  2) 拉取 (Pull)"
    echo "  3) 绑定远程仓库 (Fix Remote)"
    echo "  4) 查看状态"
    echo "  5) 深度清理 (Reflog + GC)"
    echo "  6) 初始化新仓库 (Init)"
    echo "  7) 切换工作目录 (Cd)"
    echo "  0) 退出"
    echo ""
}

while true; do
    show_menu
    read -p "选项: " num
    case $num in
        1) submit ;;
        2) branch ;;
        3) warehouse ;;
        4) state ;;
        5) garbage ;;
        6) init_repo ;;
        7) change_work_dir ;;
        0) exit 0 ;;
        *) error_msg "无效选项" ;;
    esac
    echo ""
    read -p "按回车继续..."
done
