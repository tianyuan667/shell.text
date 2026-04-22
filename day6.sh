#!/bin/bash

# Day 6: Functions - 练习解答
# 实现 Day06.md 中的五个练习，每行代码都有详细的中文注释

# 练习 1: 反转字符串函数
# 功能：接收一个字符串作为输入，返回该字符串的反转
reverse_string() {
    # 声明局部变量存储输入字符串
    local input="$1"
    # 声明局部变量存储反转后的字符串
    local reversed=""
    
    # 遍历输入字符串的每个字符，从后向前
    for (( i=${#input}-1; i>=0; i-- )); do
        # 从后向前拼接字符到结果变量
        reversed="$reversed${input:$i:1}"
    done
    
    # 输出反转后的字符串
    echo "$reversed"
}

# 练习 2: 递归计算阶乘函数
# 功能：接收一个数字作为输入，使用递归方式计算其阶乘
factorial() {
    # 声明局部变量存储输入数字
    local n=$1
    
    # 基础情况：0 和 1 的阶乘都是 1
    if [ $n -eq 0 ] || [ $n -eq 1 ]; then
        # 返回 1
        return 1
    fi
    
    # 递归调用：n! = n * (n-1)!
    local prev=$((n-1))
    # 递归调用 factorial 函数计算 (n-1)!
    factorial $prev
    # 获取递归调用的返回值，并计算 n * (n-1)!
    local result=$((n * $?))
    # 返回计算结果
    return $result
}

# 练习 3: 检查质数函数
# 功能：接收一个数字作为输入，检查它是否为质数
is_prime() {
    # 声明局部变量存储输入数字
    local num=$1
    
    # 0 和 1 不是质数
    if [ $num -le 1 ]; then
        # 返回 1 表示不是质数
        return 1
    fi
    
    # 2 是质数
    if [ $num -eq 2 ]; then
        # 返回 0 表示是质数
        return 0
    fi
    
    # 偶数不是质数
    if [ $((num % 2)) -eq 0 ]; then
        # 返回 1 表示不是质数
        return 1
    fi
    
    # 检查从 3 到 sqrt(num) 的奇数
    # 使用 bc 命令计算平方根并取整
    local max=$(echo "sqrt($num)" | bc)
    # 从 3 开始，每次增加 2，检查每个奇数
    for (( i=3; i<=max; i+=2 )); do
        # 如果能被整除，不是质数
        if [ $((num % i)) -eq 0 ]; then
            # 返回 1 表示不是质数
            return 1
        fi
    done
    
    # 经过所有检查，是质数
    # 返回 0 表示是质数
    return 0
}

# 练习 4: 分析文件函数
# 功能：接收一个文件名作为输入，输出该文件的行数、单词数和字符数
analyze_file() {
    # 声明局部变量存储文件名
    local filename=$1
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        # 文件不存在，输出错误信息
        echo "文件 $filename 不存在"
        # 返回 1 表示错误
        return 1
    fi
    
    # 计算文件的行数
    local lines=$(wc -l < "$filename")
    # 计算文件的单词数
    local words=$(wc -w < "$filename")
    # 计算文件的字符数
    local chars=$(wc -c < "$filename")
    
    # 输出分析结果
    echo "文件 $filename 分析结果："
    echo "- 行数: $lines"
    echo "- 单词数: $words"
    echo "- 字符数: $chars"
}

# 练习 5: 生成随机密码函数
# 功能：接收一个数字作为密码长度，生成指定长度的随机密码
# 密码包含大写字母、小写字母、数字和特殊字符
generate_password() {
    # 声明局部变量存储密码长度
    local length=$1
    
    # 定义字符集：大写字母、小写字母、数字、特殊字符
    local charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?"
    # 声明局部变量存储生成的密码
    local password=""
    
    # 生成指定长度的密码
    for (( i=0; i<length; i++ )); do
        # 生成随机索引，范围为 0 到字符集长度减 1
        local random_index=$((RANDOM % ${#charset}))
        # 从字符集中选择对应索引的字符，添加到密码中
        password="$password${charset:$random_index:1}"
    done
    
    # 输出生成的密码
    echo "$password"
}

# 测试函数

# 测试练习 1: 反转字符串
echo "=== 测试练习 1: 反转字符串 ==="
# 调用 reverse_string 函数反转字符串 "Hello, World!"
result=$(reverse_string "Hello, World!")
# 输出原始字符串
echo "原始字符串: Hello, World!"
# 输出反转后的字符串
echo "反转后: $result"
echo

# 测试练习 2: 计算阶乘
echo "=== 测试练习 2: 计算阶乘 ==="
# 调用 factorial 函数计算 5 的阶乘
factorial 5
# 获取函数返回值
result=$?
# 输出计算结果
echo "5 的阶乘: $result"
echo

# 测试练习 3: 查找 1-100 之间的质数
echo "=== 测试练习 3: 1-100 之间的质数 ==="
# 输出提示信息
echo "1-100 之间的质数："

# 遍历 1 到 100 的每个数字
for (( i=1; i<=100; i++ )); do
    # 调用 is_prime 函数检查当前数字是否为质数
    is_prime $i
    # 检查函数返回值，如果是 0 表示是质数
    if [ $? -eq 0 ]; then
        # 输出质数，不换行
        echo -n "$i "
    fi
done
# 输出换行
echo

echo

# 测试练习 4: 分析文件
echo "=== 测试练习 4: 分析文件 ==="
# 输出提示信息
echo "分析当前目录下的文件："
# 调用 analyze_file 函数分析 day6_exercises.sh 文件
analyze_file "day6_exercises.sh"
# 调用 analyze_file 函数分析 hello_world.sh 文件
analyze_file "hello_world.sh"
echo

# 测试练习 5: 生成随机密码
echo "=== 测试练习 5: 生成随机密码 ==="
# 调用 generate_password 函数生成 12 位随机密码
echo "生成 12 位随机密码: $(generate_password 12)"
# 调用 generate_password 函数生成 16 位随机密码
echo "生成 16 位随机密码: $(generate_password 16)"
echo