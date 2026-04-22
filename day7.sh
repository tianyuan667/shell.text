#!/bin/bash

# Day 7: 编写你的第一个 Bash 脚本
# 完成 Day07.md 中的五个练习
# 添加了详细的中文注释

# 全局变量
GREETING="Hello, World!"
MAX_COUNT=5
LOG_FILE="script.log"

# 函数：打印问候语
print_greeting() {
    local name="$1"  # 接收名字参数
    if [ -n "$name" ]; then
        echo "Hello, $name!"
    else
        echo "$GREETING"
    fi
}

# 函数：倒计时
count_down() {
    local count=$1  # 接收倒计时开始值
    
    # 错误处理：确保输入是正整数
    if ! [[ $count =~ ^[1-9][0-9]*$ ]]; then
        echo "错误：输入必须是正整数！"
        return 1
    fi
    
    while [ $count -gt 0 ]; do
        echo $count
        count=$((count - 1))
        sleep 1
    done
    echo "Blast off!"
}

# 函数：生成 1-10 之间的随机数
generate_random() {
    local random_num=$((RANDOM % 10 + 1))
    echo "生成的随机数：$random_num"
    return $random_num
}

# 函数：显示菜单
show_menu() {
    echo "===== 菜单选项 ======"
    echo "1. 打印问候语"
    echo "2. 执行倒计时"
    echo "3. 生成随机数"
    echo "4. 退出"
    echo "===================="
    echo -n "请选择一个选项 (1-4): "
    read choice
    return $choice
}

# 函数：记录日志
log_output() {
    local message="$1"
    echo "$message"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# 主脚本执行开始
log_output "脚本开始执行..."

# 处理命令行参数
if [ $# -gt 0 ]; then
    USER_NAME="$1"
    log_output "收到命令行参数：$USER_NAME"
else
    USER_NAME=""
fi

# 显示菜单并处理用户选择
while true; do
    show_menu
    choice=$?
    
    case $choice in
        1)
            log_output "执行选项 1: 打印问候语"
            print_greeting "$USER_NAME"
            ;;
        2)
            log_output "执行选项 2: 执行倒计时"
            echo -n "请输入倒计时开始值: "
            read countdown_value
            count_down "$countdown_value"
            ;;
        3)
            log_output "执行选项 3: 生成随机数"
            generate_random
            ;;
        4)
            log_output "执行选项 4: 退出"
            break
            ;;
        *)
            log_output "无效选项，请重新选择"
            ;;
    esac
    
    echo ""
    read -p "按 Enter 键继续..."
    echo ""
done

log_output "脚本执行完成."

echo "脚本输出已记录到 $LOG_FILE 文件中。"