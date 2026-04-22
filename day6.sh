#!/bin/bash

# Day 6: Functions - 练习解答
# 包含五个练习的解决方案，每个练习都有详细的中文注释

# 练习 1: 反转字符串函数
reverse_string() {
    local input="$1"  # 声明局部变量存储输入字符串
    local reversed=""  # 声明局部变量存储反转后的字符串
    
    # 遍历输入字符串的每个字符
    for (( i=${#input}-1; i>=0; i-- )); do
        reversed="$reversed${input:$i:1}"  # 从后向前拼接字符
    done
    
    echo "$reversed"  # 输出反转后的字符串
}

# 练习 2: 递归计算阶乘函数
factorial() {
    local n=$1  # 声明局部变量存储输入数字
    
    # 基础情况：0 和 1 的阶乘都是 1
    if [ $n -eq 0 ] || [ $n -eq 1 ]; then
        return 1
    fi
    
    # 递归调用：n! = n * (n-1)!
    local prev=$((n-1))
    factorial $prev
    local result=$((n * $?))
    return $result
}

# 练习 3: 检查质数函数
is_prime() {
    local num=$1  # 声明局部变量存储输入数字
    
    # 0 和 1 不是质数
    if [ $num -le 1 ]; then
        return 1
    fi
    
    # 2 是质数
    if [ $num -eq 2 ]; then
        return 0
    fi
    
    # 偶数不是质数
    if [ $((num % 2)) -eq 0 ]; then
        return 1
    fi
    
 # 检查从 3 到 sqrt(num) 的奇数
# 使用 bc 命令计算平方根并取整
local max=$(echo "sqrt($num)" | bc)
for (( i=3; i<=max; i+=2 )); do
    if [ $((num % i)) -eq 0 ]; then
        return 1  # 能被整除，不是质数
    fi
done
    
    return 0  # 是质数
}

# 练习 4: 分析文件函数
analyze_file() {
    local filename=$1  # 声明局部变量存储文件名
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "文件 $filename 不存在"
        return 1
    fi
    
    # 计算行数、单词数和字符数
    local lines=$(wc -l < "$filename")
    local words=$(wc -w < "$filename")
    local chars=$(wc -c < "$filename")
    
    # 输出结果
    echo "文件 $filename 分析结果："
    echo "- 行数: $lines"
    echo "- 单词数: $words"
    echo "- 字符数: $chars"
}

# 练习 5: 生成随机密码函数
generate_password() {
    local length=$1  # 声明局部变量存储密码长度
    
    # 定义字符集：大写字母、小写字母、数字、特殊字符
    local charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?"
    local password=""  # 声明局部变量存储生成的密码
    
    # 生成指定长度的密码
    for (( i=0; i<length; i++ )); do
        # 随机选择一个字符
        local random_index=$((RANDOM % ${#charset}))
        password="$password${charset:$random_index:1}"
    done
    
    echo "$password"  # 输出生成的密码
}

# 测试函数

# 测试练习 1: 反转字符串
echo "=== 测试练习 1: 反转字符串 ==="
result=$(reverse_string "Hello, World!")
echo "原始字符串: Hello, World!"
echo "反转后: $result"
echo

# 测试练习 2: 计算阶乘
echo "=== 测试练习 2: 计算阶乘 ==="
factorial 5
result=$?
echo "5 的阶乘: $result"
echo

# 测试练习 3: 查找 1-100 之间的质数
echo "=== 测试练习 3: 1-100 之间的质数 ==="
echo "1-100 之间的质数："

# 使用数组存储已找到的质数，确保不会重复
declare -a primes=()

for (( i=1; i<=100; i++ )); do
    is_prime $i
    if [ $? -eq 0 ]; then
        # 检查质数是否已经在数组中
        local found=0
        for prime in "${primes[@]}"; do
            if [ "$prime" -eq "$i" ]; then
                found=1
                break
            fi
        done
        
        # 如果质数不在数组中，则添加到数组并输出
        if [ $found -eq 0 ]; then
            primes+=("$i")
            echo -n "$i "
        fi
    fi
done
echo

echo

# 测试练习 4: 分析文件
echo "=== 测试练习 4: 分析文件 ==="
# 分析当前目录下的文件
analyze_file "day6.sh"
analyze_file "hello_world.sh"
echo

# 测试练习 5: 生成随机密码
echo "=== 测试练习 5: 生成随机密码 ==="
echo "生成 12 位随机密码: $(generate_password 12)"
echo "生成 16 位随机密码: $(generate_password 16)"
echo