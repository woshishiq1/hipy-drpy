#!/bin/env sh
#!/system/bin/sh

if [ "$(id -u)" -ne 0 ]; then
 exec sudo "$0" "$@"
 exit 1
fi

file_pwd=$(pwd)
file="/data/data/bin.mt.plus/home/tvbox"

if [ "$file_pwd" != "$file" ]; then
    cd "$file"
fi

branch() {
   git pull origin main
}

state(){
    git status
}

warehouse() {
    git remote add origin https://github.com/cluntop/tvbox.git
}

submit() {
    git pull origin main && git add .
    git commit -m "Update Up"
    git push origin HEAD:main
}

garbage() {
    git reflog expire --expire=now --all
    git gc --prune=now --aggressive --prune
}

while true; do
echo "当前时间：$(date)"
echo "脚本路径：$(pwd)"
echo -e "\n请选择要执行的操作"
echo "1. 提交更改"
echo "2. 远程分支"
echo "3. 远程仓库"
echo "4. 查看状态"
echo "5. 清理垃圾"
echo "0. 退出菜单"
read -p "您的选项：" num
case $num in
    1) submit ;;
    2) branch ;;
    3) warehouse ;;
    4) state ;;
    5) garbage ;;
    0) echo -e "\n退出选项" ; exit 0 ;;
    *) echo -e "\n无效选项" ;;
    esac ; read -p $'\n返回菜单' -n 1 -r
    clear ; echo
done
