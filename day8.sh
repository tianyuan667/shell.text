#!/bin/bash

# Day 8: Input/Output Redirection - 练习解答
# 实现 Day08.md 中的五个练习，每行代码都有详细的中文注释

# 练习 1: 接受用户输入并追加到文件
# 功能：接收用户输入并将其追加到文件中，如果文件不存在则创建它
append_to_file() {
    # 提示用户输入文件名
    echo "请输入要追加内容的文件名:"
    read -r filename
    
    # 提示用户输入要追加的内容
    echo "请输入要追加的内容 (按 Ctrl+D 结束输入):"
    
    # 读取用户输入并追加到文件中
    # 如果文件不存在，>> 操作符会自动创建文件
    cat >> "$filename"
    
    # 输出操作结果
    echo "内容已成功追加到文件 $filename"
}

# 练习 2: 读取数字列表并排序
# 功能：从文件中读取数字列表，对它们进行排序，并将排序后的列表写入新文件
sort_numbers() {
    # 提示用户输入包含数字的文件名
    echo "请输入包含数字的文件名:"
    read -r input_file
    
    # 检查文件是否存在
    if [ ! -f "$input_file" ]; then
        echo "错误：文件 $input_file 不存在"
        return 1
    fi
    
    # 提示用户输入输出文件名
    echo "请输入排序后数字的输出文件名:"
    read -r output_file
    
    # 从输入文件读取数字，排序后写入输出文件
    sort -n "$input_file" > "$output_file"
    
    # 输出操作结果
    echo "数字已排序并写入文件 $output_file"
    echo "排序后的数字:"
    cat "$output_file"
}

# 练习 3: 执行命令并同时输出到文件和屏幕
# 功能：执行命令，将其输出重定向到文件，同时在屏幕上显示输出
execute_and_log() {
    # 提示用户输入要执行的命令
    echo "请输入要执行的命令:"
    read -r command
    
    # 提示用户输入日志文件名
    echo "请输入日志文件名:"
    read -r log_file
    
    # 使用 tee 命令执行命令，同时输出到文件和屏幕
    # tee 命令会将标准输入复制到标准输出和指定文件
    eval "$command" | tee "$log_file"
    
    # 输出操作结果
    echo "命令执行结果已保存到文件 $log_file"
}

# 练习 4: 使用 here document 生成 HTML 文件
# 功能：使用 here document 生成一个简单的 HTML 文件
generate_html() {
    # 提示用户输入 HTML 文件名
    echo "请输入要生成的 HTML 文件名:"
    read -r html_file
    
    # 使用 here document 生成 HTML 内容并写入文件
    cat << EOF > "$html_file"
<!DOCTYPE html>
<html>
<head>
    <title>生成的 HTML 页面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f0f0f0;
        }
        h1 {
            color: #333;
        }
        p {
            color: #666;
        }
    </style>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>这是一个使用 Bash 脚本生成的 HTML 页面。</p>
    <p>生成时间: $(date)</p>
</body>
</html>
EOF
    
    # 输出操作结果
    echo "HTML 文件已生成: $html_file"
    echo "文件内容:"
    cat "$html_file"
}

# 练习 5: 将错误重定向到日志文件
# 功能：将错误重定向到日志文件，但仍在屏幕上显示正常输出
redirect_errors() {
    # 提示用户输入要执行的命令
    echo "请输入要执行的命令:"
    read -r command
    
    # 提示用户输入错误日志文件名
    echo "请输入错误日志文件名:"
    read -r error_log
    
    # 执行命令，将错误重定向到日志文件，正常输出仍然显示在屏幕上
    # 2> 表示将标准错误重定向到指定文件
    eval "$command" 2> "$error_log"
    
    # 检查是否有错误输出
    if [ -s "$error_log" ]; then
        echo "命令执行过程中产生了错误，已记录到文件 $error_log"
        echo "错误内容:"
        cat "$error_log"
    else
        echo "命令执行成功，没有错误"
    fi
}

# 主菜单函数
show_menu() {
    echo "===== Day 8: Input/Output Redirection 练习 ====="
    echo "1. 练习 1: 接受用户输入并追加到文件"
    echo "2. 练习 2: 读取数字列表并排序"
    echo "3. 练习 3: 执行命令并同时输出到文件和屏幕"
    echo "4. 练习 4: 使用 here document 生成 HTML 文件"
    echo "5. 练习 5: 将错误重定向到日志文件"
    echo "6. 退出"
    echo "=============================================="
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
            echo "\n=== 执行练习 1: 接受用户输入并追加到文件 ==="
            append_to_file
            ;;
        2)
            echo "\n=== 执行练习 2: 读取数字列表并排序 ==="
            sort_numbers
            ;;
        3)
            echo "\n=== 执行练习 3: 执行命令并同时输出到文件和屏幕 ==="
            execute_and_log
            ;;
        4)
            echo "\n=== 执行练习 4: 使用 here document 生成 HTML 文件 ==="
            generate_html
            ;;
        5)
            echo "\n=== 执行练习 5: 将错误重定向到日志文件 ==="
            redirect_errors
            ;;
        6)
            echo "退出脚本"
            break
            ;;
        *)
            echo "无效选项，请重新选择"
            ;;
    esac
    
    echo "\n按 Enter 键继续..."
    read -r
    echo

done

# 脚本结束
echo "脚本执行完成"