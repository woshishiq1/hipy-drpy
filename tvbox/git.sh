#!/bin/env sh
#!/system/bin/sh

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 日志文件
LOG_FILE="/data/data/bin.mt.plus/home/tvbox/.github/git.log"

# 日志记录函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    echo "$1"
}

# 成功提示
success_msg() {
    echo -e "${GREEN}✓ $1${NC}"
    log "成功: $1"
}

# 错误提示
error_msg() {
    echo -e "${RED}✗ $1${NC}"
    log "错误: $1"
}

# 警告提示
warn_msg() {
    echo -e "${YELLOW}⚠ $1${NC}"
    log "警告: $1"
}

# 信息提示
info_msg() {
    echo -e "${CYAN}ℹ $1${NC}"
}

# 检查网络连接
check_network() {
    info_msg "检查网络连接..."
    if ping -c 1 -W 2 github.com > /dev/null 2>&1; then
        success_msg "网络连接正常"
        return 0
    else
        error_msg "网络连接失败，请检查网络设置"
        return 1
    fi
}

# 检查 Git 是否安装
check_git() {
    if ! command -v git > /dev/null 2>&1; then
        error_msg "Git 未安装，请先安装 Git"
        exit 1
    fi
}

# 检查是否为 Git 仓库
check_git_repo() {
    if [ ! -d ".git" ]; then
        error_msg "当前目录不是 Git 仓库"
        return 1
    fi
    return 0
}

# 权限检查（Android 环境）
if [ "$(id -u)" -ne 0 ]; then
    warn_msg "需要 root 权限，尝试获取..."
    exec sudo "$0" "$@" 2>/dev/null || {
        error_msg "无法获取 root 权限，某些功能可能无法使用"
    }
fi

# 初始化日志
log "========== Git 操作脚本启动 =========="

# 设置工作目录
file_pwd=$(pwd)
file="/data/data/bin.mt.plus/home/tvbox"

if [ ! -d "$file" ]; then
    warn_msg "目标目录不存在: $file"
    warn_msg "使用当前目录: $file_pwd"
    file="$file_pwd"
fi

if [ "$file_pwd" != "$file" ]; then
    info_msg "切换到工作目录: $file"
    cd "$file" || {
        error_msg "无法切换到目录: $file"
        exit 1
    }
fi

# 检查 Git
check_git

# 拉取远程分支
branch() {
    info_msg "开始拉取远程分支..."
    if ! check_network; then
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    if git pull origin main 2>&1 | tee -a "$LOG_FILE"; then
        success_msg "拉取成功"
        return 0
    else
        error_msg "拉取失败"
        return 1
    fi
}

# 查看状态
state() {
    info_msg "查看 Git 状态..."
    if ! check_git_repo; then
        return 1
    fi
    
    echo -e "\n${BLUE}=== Git 状态 ===${NC}"
    git status
    echo ""
}

# 添加远程仓库
warehouse() {
    info_msg "添加远程仓库..."
    if ! check_network; then
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    # 检查是否已存在远程仓库
    if git remote get-url origin > /dev/null 2>&1; then
        warn_msg "远程仓库已存在: $(git remote get-url origin)"
        read -p "是否要更新远程仓库地址？(y/n): " confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            git remote set-url origin https://github.com/cluntop/tvbox.git
            success_msg "远程仓库地址已更新"
        else
            info_msg "操作已取消"
        fi
    else
        if git remote add origin https://github.com/cluntop/tvbox.git 2>&1 | tee -a "$LOG_FILE"; then
            success_msg "远程仓库添加成功"
        else
            error_msg "远程仓库添加失败"
            return 1
        fi
    fi
}

# 提交更改
submit() {
    info_msg "开始提交更改..."
    if ! check_network; then
        return 1
    fi
    
    if ! check_git_repo; then
        return 1
    fi
    
    # 检查是否有更改
    if [ -z "$(git status --porcelain)" ]; then
        warn_msg "没有需要提交的更改"
        return 0
    fi
    
    info_msg "步骤 1/3: 拉取远程更新..."
    if ! git pull origin main 2>&1 | tee -a "$LOG_FILE"; then
        error_msg "拉取失败，请检查网络或解决冲突"
        return 1
    fi
    
    info_msg "步骤 2/3: 添加文件到暂存区..."
    if git add . 2>&1 | tee -a "$LOG_FILE"; then
        success_msg "文件已添加到暂存区"
    else
        error_msg "添加文件失败"
        return 1
    fi
    
    info_msg "步骤 3/3: 提交并推送..."
    if git commit -m "Update Up - $(date '+%Y-%m-%d %H:%M:%S')" 2>&1 | tee -a "$LOG_FILE"; then
        success_msg "提交成功"
    else
        error_msg "提交失败"
        return 1
    fi
    
    if git push origin HEAD:main 2>&1 | tee -a "$LOG_FILE"; then
        success_msg "推送成功"
        return 0
    else
        error_msg "推送失败"
        return 1
    fi
}

# 清理垃圾
garbage() {
    info_msg "开始清理 Git 垃圾文件..."
    if ! check_git_repo; then
        return 1
    fi
    
    warn_msg "此操作可能需要较长时间，请耐心等待..."
    
    if git reflog expire --expire=now --all 2>&1 | tee -a "$LOG_FILE" && \
       git gc --prune=now --aggressive 2>&1 | tee -a "$LOG_FILE"; then
        success_msg "清理完成"
        
        # 显示清理后的仓库大小
        repo_size=$(du -sh .git 2>/dev/null | cut -f1)
        info_msg "当前仓库大小: $repo_size"
        return 0
    else
        error_msg "清理失败"
        return 1
    fi
}

# 显示仓库信息
show_info() {
    echo -e "\n${BLUE}=== 仓库信息 ===${NC}"
    echo "工作目录: $(pwd)"
    echo "当前分支: $(git branch --show-current 2>/dev/null || echo '未知')"
    if git remote get-url origin > /dev/null 2>&1; then
        echo "远程仓库: $(git remote get-url origin)"
    else
        echo "远程仓库: 未设置"
    fi
    echo "最后提交: $(git log -1 --format='%h - %s (%ar)' 2>/dev/null || echo '无')"
    echo ""
}

# 清屏函数（适配不同终端）
clear_screen() {
    clear 2>/dev/null || printf '\033[2J\033[H'
}

# 主菜单
show_menu() {
    clear_screen
    echo -e "${CYAN}╔═════════════════╗${NC}"
    echo -e "${CYAN}║      Git 仓库管理工具 (PID: $$)    ║${NC}"
    echo -e "${CYAN}╚═════════════════╝${NC}"
    echo ""
    echo "当前时间: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "工作目录: $(pwd)"
    echo ""
    echo -e "${GREEN}请选择操作:${NC}"
    echo "  1) 提交更改 (Pull + Add + Commit + Push)"
    echo "  2) 拉取更新 (Pull from main)"
    echo "  3) 设置远程仓库 (Add remote)"
    echo "  4) 查看状态 (Git status)"
    echo "  5) 清理垃圾 (Git GC)"
    echo "  6) 查看仓库信息"
    echo "  0) 退出"
    echo ""
}

# 主循环
while true; do
    show_menu
    show_info
    read -p "请输入选项 [0-6]: " num
    
    case $num in
        1)
            echo ""
            submit
            ;;
        2)
            echo ""
            branch
            ;;
        3)
            echo ""
            warehouse
            ;;
        4)
            echo ""
            state
            ;;
        5)
            echo ""
            garbage
            ;;
        6)
            echo ""
            show_info
            ;;
        0)
            echo ""
            success_msg "感谢使用，再见！"
            log "========== Git 操作脚本退出 =========="
            exit 0
            ;;
        *)
            error_msg "无效选项，请输入 0-6"
            ;;
    esac
    
    echo ""
    read -p "按回车键返回菜单..." -r
done
