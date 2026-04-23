#!/bin/bash

# Day 10: String Manipulation - 练习解答
# 实现 Day10.md 中的五个练习，每行代码都有详细的中文注释

# 练习 1: 反转句子中的每个单词
# 功能：接收一个句子作为输入，反转句子中的每个单词
reverse_words() {
    echo "=== 练习 1: 反转句子中的每个单词 ==="
    
    # 提示用户输入句子
    echo "请输入一个句子:"
    read -r sentence
    
    # 初始化结果变量
    local result=""
    
    # 遍历句子中的每个单词
    for word in $sentence; do
        # 反转当前单词
        local reversed_word=""
        for (( i=${#word}-1; i>=0; i-- )); do
            reversed_word="$reversed_word${word:$i:1}"
        done
        # 将反转后的单词添加到结果中
        result="$result $reversed_word"
    done
    
    # 输出结果
    echo "原始句子: $sentence"
    echo "反转每个单词后:${result}"
    
    echo
}

# 练习 2: 计算字符串中的元音字母数量
# 功能：接收一个字符串作为输入，计算其中的元音字母数量
count_vowels() {
    echo "=== 练习 2: 计算字符串中的元音字母数量 ==="
    
    # 提示用户输入字符串
    echo "请输入一个字符串:"
    read -r string
    
    # 定义元音字母
    local vowels="aeiouAEIOU"
    # 初始化计数器
    local count=0
    
    # 遍历字符串中的每个字符
    for (( i=0; i<${#string}; i++ )); do
        # 获取当前字符
        local char="${string:$i:1}"
        # 检查字符是否是元音
        if [[ $vowels == *"$char"* ]]; then
            count=$((count + 1))
        fi
    done
    
    # 输出结果
    echo "输入字符串: $string"
    echo "元音字母数量: $count"
    
    echo
}

# 练习 3: 为文件名添加前缀
# 功能：接收一个文件名作为输入，为其添加指定前缀
add_prefix() {
    echo "=== 练习 3: 为文件名添加前缀 ==="
    
    # 提示用户输入文件名
    echo "请输入文件名:"
    read -r filename
    
    # 提示用户输入前缀
    echo "请输入要添加的前缀:"
    read -r prefix
    
    # 生成新文件名
    local new_filename="${prefix}${filename}"
    
    # 输出结果
    echo "原始文件名: $filename"
    echo "添加前缀后: $new_filename"
    
    echo
}

# 练习 4: 生成安全的随机密码
# 功能：生成指定长度的随机密码，确保包含至少一个大写字母、一个小写字母、一个数字和一个特殊字符
generate_secure_password() {
    echo "=== 练习 4: 生成安全的随机密码 ==="
    
    # 提示用户输入密码长度
    echo "请输入密码长度 (至少 4):"
    read -r length
    
    # 验证密码长度
    if [ $length -lt 4 ]; then
        echo "错误：密码长度至少为 4"
        echo
        return 1
    fi
    
    # 定义字符集
    local uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local lowercase="abcdefghijklmnopqrstuvwxyz"
    local numbers="0123456789"
    local special="!@#$%^&*()_+-=[]{}|;:,.<>?"
    
    # 确保至少包含每种类型的字符
    local password=""
    # 随机选择一个大写字母
    password="$password${uppercase:$((RANDOM % ${#uppercase})):1}"
    # 随机选择一个小写字母
    password="$password${lowercase:$((RANDOM % ${#lowercase})):1}"
    # 随机选择一个数字
    password="$password${numbers:$((RANDOM % ${#numbers})):1}"
    # 随机选择一个特殊字符
    password="$password${special:$((RANDOM % ${#special})):1}"
    
    # 生成剩余的字符
    local all_chars="$uppercase$lowercase$numbers$special"
    for (( i=4; i<length; i++ )); do
        password="$password${all_chars:$((RANDOM % ${#all_chars})):1}"
    done
    
    # 打乱密码顺序
    password=$(echo "$password" | fold -w1 | shuf | tr -d '\n')
    
    # 输出结果
    echo "生成的安全密码: $password"
    
    echo
}

# 练习 5: 检查字符串是否为回文
# 功能：接收一个字符串作为输入，检查它是否为回文（正读和反读都一样）
is_palindrome() {
    echo "=== 练习 5: 检查字符串是否为回文 ==="
    
    # 提示用户输入字符串
    echo "请输入一个字符串:"
    read -r string
    
    # 移除字符串中的空格和标点，并转换为小写
    local clean_string=$(echo "$string" | tr -d '[:space:][:punct:]' | tr '[:upper:]' '[:lower:]')
    
    # 反转清理后的字符串
    local reversed_string=""
    for (( i=${#clean_string}-1; i>=0; i-- )); do
        reversed_string="$reversed_string${clean_string:$i:1}"
    done
    
    # 检查是否为回文
    if [ "$clean_string" == "$reversed_string" ]; then
        echo ""$string" 是回文"
    else
        echo ""$string" 不是回文"
    fi
    
    echo
}

# 主菜单函数
show_menu() {
    echo "===== Day 10: String Manipulation 练习 ====="
    echo "1. 练习 1: 反转句子中的每个单词"
    echo "2. 练习 2: 计算字符串中的元音字母数量"
    echo "3. 练习 3: 为文件名添加前缀"
    echo "4. 练习 4: 生成安全的随机密码"
    echo "5. 练习 5: 检查字符串是否为回文"
    echo "6. 退出"
    echo "============================================"
    echo -n "请选择一个选项 (1-6): "
    read -r choice
    return $choice
}

# 主脚本执行
while true; do
    show_menu
    choice=$?
    
    case $choice in
        1)
            reverse_words
            ;;
        2)
            count_vowels
            ;;
        3)
            add_prefix
            ;;
        4)
            generate_secure_password
            ;;
        5)
            is_palindrome
            ;;
        6)
            echo "退出脚本"
            break
            ;;
        *)
            echo "无效选项，请重新选择"
            ;;
    esac
    
    echo "按 Enter 键继续..."
    read -r
    echo

done

# 脚本结束
echo "脚本执行完成"