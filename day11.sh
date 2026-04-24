#!/bin/bash

# Day 11: sed Command - 练习解答
# 实现 Day11.md 中的五个练习，每行代码都有详细的中文注释

# 练习 1: 替换完整单词 "color" 为 "colour"
# 功能：将文件中所有的 "color" 替换为 "colour"，但只替换完整的单词
replace_color() {
    echo "=== 练习 1: 替换完整单词 'color' 为 'colour' ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 备份原始文件
    cp "$filename" "${filename}.bak"
    
    # 使用 sed 命令替换完整单词
    # \b 表示单词边界，确保只匹配完整的单词
    sed -i 's/\bcolor\b/colour/g' "$filename"
    
    # 输出结果
    echo "已将文件中所有完整的 'color' 替换为 'colour'"
    echo "原始文件已备份为 ${filename}.bak"
    echo "替换后的文件内容:"
    cat "$filename"
    
    echo
}

# 练习 2: 移除所有 HTML 标签
# 功能：使用 sed 从文件中删除所有 HTML 标签
remove_html_tags() {
    echo "=== 练习 2: 移除所有 HTML 标签 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 备份原始文件
    cp "$filename" "${filename}.bak"
    
    # 使用 sed 命令移除 HTML 标签
    # <[^>]*> 匹配任何以 < 开头，以 > 结尾的内容（HTML 标签）
    sed -i 's/<[^>]*>//g' "$filename"
    
    # 输出结果
    echo "已移除文件中的所有 HTML 标签"
    echo "原始文件已备份为 ${filename}.bak"
    echo "处理后的文件内容:"
    cat "$filename"
    
    echo
}

# 练习 3: 交换每行的第一个和第二个单词
# 功能：使用 sed 交换文件中每行的第一个和第二个单词
swap_first_two_words() {
    echo "=== 练习 3: 交换每行的第一个和第二个单词 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 备份原始文件
    cp "$filename" "${filename}.bak"
    
    # 使用 sed 命令交换第一个和第二个单词
    # \(\w+\) 捕获第一个单词，\(\w+\) 捕获第二个单词
    # \2 \1 交换它们的位置
    sed -i 's/^\(\w\+\)\s\+\(\w\+\)/\2 \1/' "$filename"
    
    # 输出结果
    echo "已交换文件中每行的第一个和第二个单词"
    echo "原始文件已备份为 ${filename}.bak"
    echo "处理后的文件内容:"
    cat "$filename"
    
    echo
}

# 练习 4: 提取电话号码
# 功能：使用 sed 从文件中提取所有格式为 (xxxx) xxx-xxxx 的电话号码
extract_phone_numbers() {
    echo "=== 练习 4: 提取电话号码 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 使用 sed 命令提取电话号码
    # \([0-9]\{4\}\) 匹配四位数字，放在括号中
    # \s* 匹配零个或多个空格
    # \([0-9]\{3\}\) 匹配三位数字
    # - 匹配连字符
    # \([0-9]\{4\}\) 匹配四位数字
    # p 命令打印匹配的行
    echo "提取的电话号码:"
    sed -n '/([0-9]\{4\})\s*[0-9]\{3\}-[0-9]\{4\}/p' "$filename"
    
    echo
}

# 练习 5: 注释掉以特定单词开头的行
# 功能：使用 sed 注释掉配置文件中以特定单词（例如 "DEBUG"）开头的所有行
comment_out_lines() {
    echo "=== 练习 5: 注释掉以特定单词开头的行 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 提示用户输入要匹配的开头单词
    echo "请输入要注释掉的行的开头单词:"
    read -r keyword
    
    # 备份原始文件
    cp "$filename" "${filename}.bak"
    
    # 使用 sed 命令注释掉以特定单词开头的行
    # ^ 匹配行首
    # $keyword 匹配用户输入的单词
    # \s* 匹配零个或多个空格
    # s/^\($keyword\s*\)/# \1/ 在前缀添加 # 符号
    sed -i "s/^\($keyword\s*\)/# \1/" "$filename"
    
    # 输出结果
    echo "已注释掉所有以 '$keyword' 开头的行"
    echo "原始文件已备份为 ${filename}.bak"
    echo "处理后的文件内容:"
    cat "$filename"
    
    echo
}

# 主菜单函数
show_menu() {
    echo "===== Day 11: sed Command 练习 ====="
    echo "1. 练习 1: 替换完整单词 'color' 为 'colour'"
    echo "2. 练习 2: 移除所有 HTML 标签"
    echo "3. 练习 3: 交换每行的第一个和第二个单词"
    echo "4. 练习 4: 提取电话号码"
    echo "5. 练习 5: 注释掉以特定单词开头的行"
    echo "6. 退出"
    echo "====================================="
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
            replace_color
            ;;
        2)
            remove_html_tags
            ;;
        3)
            swap_first_two_words
            ;;
        4)
            extract_phone_numbers
            ;;
        5)
            comment_out_lines
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