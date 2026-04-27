#!/bin/bash

# Day 12: awk Command - 练习解答
# 实现 Day12.md 中的五个练习，每行代码都有详细的中文注释

# 练习 1: 打印第二个字段大于 50 的所有行
# 功能：使用 awk 命令打印文件中第二个字段大于 50 的所有行
print_second_field_greater_than_50() {
    echo "=== 练习 1: 打印第二个字段大于 50 的所有行 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 使用 awk 命令打印第二个字段大于 50 的所有行
    # $2 表示第二个字段
    # >50 表示大于 50 的条件
    # {print} 表示打印匹配的行
    echo "第二个字段大于 50 的行:"
    awk '$2 > 50 {print}' "$filename"
    
    echo
}

# 练习 2: 计算 CSV 文件中一列数字的总和和平均值
# 功能：使用 awk 计算 CSV 文件中一列数字的总和和平均值
calculate_sum_average() {
    echo "=== 练习 2: 计算 CSV 文件中一列数字的总和和平均值 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的 CSV 文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 提示用户输入要计算的列号（从 1 开始）
    echo "请输入要计算的列号 (从 1 开始):"
    read -r column
    
    # 使用 awk 命令计算总和和平均值
    # -F"," 设置字段分隔符为逗号
    # 初始化 sum 和 count 变量
    # 对每一行，将指定列的值加到 sum 中，count 加 1
    # 最后打印总和和平均值
    echo "计算结果:"
    awk -F"," '{
        sum += $'"$column"'
        count += 1
    } END {
        print "总和: " sum
        print "平均值: " sum/count
    }' "$filename"
    
    echo
}

# 练习 3: 提取所有电子邮件地址
# 功能：使用 awk 从文本文件中提取所有电子邮件地址
Extract_email_addresses() {
    echo "=== 练习 3: 提取所有电子邮件地址 ==="
    
    # 提示用户输入文件名
    echo "请输入要处理的文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 使用 awk 命令提取电子邮件地址
    # 使用正则表达式匹配电子邮件地址格式
    # [a-zA-Z0-9._%+-]+ 匹配用户名部分
    # @ 匹配 @ 符号
    # [a-zA-Z0-9.-]+ 匹配域名部分
    # \. 匹配 . 符号
    # [a-zA-Z]{2,} 匹配顶级域名
    echo "提取的电子邮件地址:"
    awk '{
        for (i=1; i<=NF; i++) {
            if ($i ~ /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/) {
                print $i
            }
        }
    }' "$filename"
    
    echo
}

# 练习 4: 统计日志文件中每个唯一 IP 地址的出现次数
# 功能：使用 awk 读取日志文件并报告每个唯一 IP 地址的出现次数
count_ip_occurrences() {
    echo "=== 练习 4: 统计日志文件中每个唯一 IP 地址的出现次数 ==="
    
    # 提示用户输入日志文件名
    echo "请输入要处理的日志文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 使用 awk 命令统计 IP 地址出现次数
    # 假设 IP 地址在每行的第一个字段
    # 使用关联数组 ip_count 存储每个 IP 地址的出现次数
    # 最后按出现次数降序排序并打印
    echo "IP 地址出现次数统计:"
    awk '{
        ip_count[$1]++
    } END {
        for (ip in ip_count) {
            print ip ": " ip_count[ip]
        }
    }' "$filename" | sort -nr -k2
    
    echo
}

# 练习 5: 查找分数最高的学生
# 功能：使用 awk 读取学生成绩的 CSV 文件并打印分数最高的学生的姓名和成绩
find_highest_score() {
    echo "=== 练习 5: 查找分数最高的学生 ==="
    
    # 提示用户输入 CSV 文件名
    echo "请输入包含学生成绩的 CSV 文件名:"
    read -r filename
    
    # 检查文件是否存在
    if [ ! -f "$filename" ]; then
        echo "错误：文件 $filename 不存在"
        echo
        return 1
    fi
    
    # 提示用户输入姓名所在的列号和分数所在的列号
    echo "请输入姓名所在的列号 (从 1 开始):"
    read -r name_column
    echo "请输入分数所在的列号 (从 1 开始):"
    read -r score_column
    
    # 使用 awk 命令查找分数最高的学生
    # -F"," 设置字段分隔符为逗号
    # 初始化 max_score 和 max_name 变量
    # 对每一行，比较分数，如果大于当前最大值，则更新最大值和对应的姓名
    # 最后打印分数最高的学生的姓名和分数
    echo "分数最高的学生:"
    awk -F"," '{
        if (NR == 1) next; # 跳过标题行
        if ($'"$score_column"' > max_score) {
            max_score = $'"$score_column"'
            max_name = $'"$name_column"'
        }
    } END {
        print "姓名: " max_name
        print "分数: " max_score
    }' "$filename"
    
    echo
}

# 主菜单函数
show_menu() {
    echo "===== Day 12: awk Command 练习 ====="
    echo "1. 练习 1: 打印第二个字段大于 50 的所有行"
    echo "2. 练习 2: 计算 CSV 文件中一列数字的总和和平均值"
    echo "3. 练习 3: 提取所有电子邮件地址"
    echo "4. 练习 4: 统计日志文件中每个唯一 IP 地址的出现次数"
    echo "5. 练习 5: 查找分数最高的学生"
    echo "6. 退出"
    echo "===================================="
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
            print_second_field_greater_than_50
            ;;
        2)
            calculate_sum_average
            ;;
        3)
            Extract_email_addresses
            ;;
        4)
            count_ip_occurrences
            ;;
        5)
            find_highest_score
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