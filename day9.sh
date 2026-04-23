#!/bin/bash

# Day 9: Arrays - 练习解答
# 实现 Day09.md 中的五个练习，每行代码都有详细的中文注释

# 练习 1: 创建食物数组并打印
# 功能：创建一个包含最喜欢的食物的数组，然后在新行上打印每个项目
print_favorite_foods() {
    echo "=== 练习 1: 创建食物数组并打印 ==="
    
    # 创建包含最喜欢的食物的数组
    local foods=('pizza' 'sushi' 'chocolate' 'ice cream' 'pasta')
    
    # 打印数组中的每个项目
    echo "我最喜欢的食物："
    for food in "${foods[@]}"; do
        echo "- $food"
    done
    
    echo
}

# 练习 2: 处理命令行参数
# 功能：接受命令行参数并将它们存储在数组中，然后打印参数的数量和每个参数的值
process_command_line_args() {
    echo "=== 练习 2: 处理命令行参数 ==="
    
    # 提示用户输入参数
    echo "请输入要处理的参数，用空格分隔:"
    read -r -a args
    
    # 打印参数的数量
    #在数组变量前使用，用于获取数组的长度
    echo "参数数量: ${#args[@]}"
    
    # 打印每个参数的值
    echo "参数值:"
    for i in "${!args[@]}"; do
        echo "参数 $i: ${args[$i]}"
    done
    
    echo
}

# 练习 3: 提取唯一元素
# 功能：接受一个数组作为输入并返回一个只包含唯一元素的新数组
extract_unique_elements() {
    echo "=== 练习 3: 提取唯一元素 ==="
    
    # 提示用户输入数组元素
    echo "请输入数组元素，用空格分隔:"
    read -r -a input_array
    
    # 打印原始数组
    echo "原始数组: ${input_array[@]}"
    
    # 创建关联数组来存储唯一元素
    #  声明一个关联数组，用于跟踪已见过的元素
    declare -A seen
    local unique_array=()
    
    # 遍历输入数组，只添加未见过的元素
    for item in "${input_array[@]}"; do
        if [[ -z ${seen[$item]} ]]; then
            seen[$item]=1
            #+=($item)：向数组添加元素的语法，将 item 添加到数组末尾
            unique_array+=($item)
        fi
    done
    
    # 打印唯一元素数组
    echo "唯一元素数组: ${unique_array[@]}"
    
    echo
}

# 练习 4: 读取文件到数组并处理
# 功能：逐行读取文件到数组中，然后对每行执行一些操作（例如，转换为大写）
process_file_lines() {
    echo "=== 练习 4: 读取文件到数组并处理 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 逐行读取文件到数组
    local lines=()
    while IFS= read -r line; do
        lines+=($line)
    done < "$filename"
    
    # 打印原始行
    echo "原始行:"
    for line in "${lines[@]}"; do
        echo "- $line"
    done
    
    # 处理每行（转换为大写）
    echo "处理后（大写）:"
    for line in "${lines[@]}"; do
    #tr '[:lower:]' '[:upper:]' 命令将所有小写字母转换为大写字母
        echo "- $(echo $line | tr '[:lower:]' '[:upper:]')"
    done
    
    echo
}

# 练习 5: 使用关联数组存储键值对
# 功能：使用关联数组来存储和检索键值对（例如，国家名称及其首都）
use_associative_array() {
    echo "=== 练习 5: 使用关联数组存储键值对 ==="
    
    # 创建关联数组，存储国家和首都
    declare -A capitals
    
    # 提示用户输入几个国家和首都
    echo "请输入 3 个国家及其首都，格式为 '国家:首都'，每行一个:"
    for i in {1..3}; do
        echo -n "请输入第 $i 个国家和首都: "
        read -r entry
        # 分割输入为国家和首都
        #国家${entry%%:*}
        #首都${entry##*:}
        local country=${entry%%:*}
        local capital=${entry##*:}
        capitals["$country"]="$capital"
    done
    
    # 打印所有国家和首都
    echo "\n国家及其首都:"
    for country in "${!capitals[@]}"; do
        echo "$country: ${capitals[$country]}"
    done
    
    # 提示用户输入要查询的国家
    echo "\n请输入要查询首都的国家:"
    read -r country
    
    # 检查国家是否存在
    if [[ -n ${capitals[$country]} ]]; then
        echo "$country 的首都是: ${capitals[$country]}"
    else
        echo "错误：未找到 $country 的首都信息"
    fi
    
    echo
}

# 主菜单函数
show_menu() {
    echo "===== Day 9: Arrays 练习 ====="
    echo "1. 练习 1: 创建食物数组并打印"
    echo "2. 练习 2: 处理命令行参数"
    echo "3. 练习 3: 提取唯一元素"
    echo "4. 练习 4: 读取文件到数组并处理"
    echo "5. 练习 5: 使用关联数组存储键值对"
    echo "6. 退出"
    echo "=============================="
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
            print_favorite_foods
            ;;
        2)
            process_command_line_args
            ;;
        3)
            extract_unique_elements
            ;;
        4)
            process_file_lines
            ;;
        5)
            use_associative_array
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