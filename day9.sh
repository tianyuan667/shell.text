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
    
    # 将命令行参数存储在数组中
    local args=($@)
    
    # 打印参数的数量
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
    
    # 示例输入数组，包含重复元素
    local input_array=('apple' 'banana' 'apple' 'orange' 'banana' 'grape')
    
    # 打印原始数组
    echo "原始数组: ${input_array[@]}"
    
    # 创建关联数组来存储唯一元素
    declare -A seen
    local unique_array=()
    
    # 遍历输入数组，只添加未见过的元素
    for item in "${input_array[@]}"; do
        if [[ -z ${seen[$item]} ]]; then
            seen[$item]=1
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
    
    # 检查文件是否存在
    if [ ! -f "$1" ]; then
        echo "错误：文件 $1 不存在"
        echo
        return 1
    fi
    
    # 逐行读取文件到数组
    local lines=()
    while IFS= read -r line; do
        lines+=($line)
    done < "$1"
    
    # 打印原始行
    echo "原始行:"
    for line in "${lines[@]}"; do
        echo "- $line"
    done
    
    # 处理每行（转换为大写）
    echo "处理后（大写）:"
    for line in "${lines[@]}"; do
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
    capitals["China"]="Beijing"
    capitals["USA"]="Washington, D.C."
    capitals["Japan"]="Tokyo"
    capitals["France"]="Paris"
    capitals["Germany"]="Berlin"
    
    # 打印所有国家和首都
    echo "国家及其首都:"
    for country in "${!capitals[@]}"; do
        echo "$country: ${capitals[$country]}"
    done
    
    # 示例：根据国家名称检索首都
    local country="China"
    echo "\n$country 的首都是: ${capitals[$country]}"
    
    echo
}

# 主脚本执行

# 执行练习 1
print_favorite_foods

# 执行练习 2，传入一些示例参数
process_command_line_args "apple" "banana" "cherry" "date"

# 执行练习 3
extract_unique_elements

# 执行练习 4，使用 day9.sh 文件本身作为示例
process_file_lines "day9.sh"

# 执行练习 5
use_associative_array

# 脚本结束
echo "所有练习执行完成"