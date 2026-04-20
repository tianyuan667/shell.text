 #!bin/bash 
 #1.编写一个脚本，使用for循环打印给定数字的乘法表（由用户输入）。
read -p "输入第一个数" Null1
for ((i=1;i<=10;i++))
	do
	count=$((i*Null1))
	echo "$Null1*$i=$count"
	done

#2.创建一个脚本，使用while循环来模拟一个简单的猜谜游戏。生成一个介于1和10之间的随机数，让用户猜测，直到他们猜对为止。 
echo "=== 练习2: 猜数字游戏 ==="

# 生成1到10之间的随机数
target=$((RANDOM % 10 + 1))

# 初始化猜测次数
attempts=0

echo "我已经想好了一个1到10之间的数字，来猜一猜吧！"

# 使用while循环，直到用户猜对
while true
 do
    # 提示用户输入猜测
    read -p "请输入你的猜测: " guess
    # 增加猜测次数
    ((attempts++))
    
    # 检查猜测是否正确
    if [ $guess -eq $target ]
    then
        # 猜对了，退出循环
        echo "恭喜你猜对了！数字是 $target"
        echo "你用了 $attempts 次尝试"
        break
    elif [ $guess -lt $target ]
    then
        # 猜小了
        echo "太小了，再试试！"
    else
        # 猜大了
        echo "太大了，再试试！"
    fi
done

echo ""
 #3.编写一个脚本，使用for循环迭代当前目录中的所有文件，并打印它们的名称和大小。
echo "=== 练习3: 列出文件和大小 ==="

# 输出标题
echo "文件名称 和 大小（字节）:"
echo "-----------------------------"

# 使用for循环遍历所有文件
for file in *
do
    # 检查是否是文件（不是目录）
    if [ -f "$file" ]
    then
        # 获取文件大小
        size=$(ls -l "$file" | awk '{print $5}')
        # 打印文件名称和大小
        echo "文件名$file: 大小$size 字节"
    fi
done

echo "" 
 #4.创建一个脚本，使用while循环计算用户输入的数字的阶乘。 
 echo "=== 练习4: 计算阶乘 ==="

# 提示用户输入一个数字
read -p "请输入一个正整数: " num

# 初始化阶乘结果为1
factorial=1
# 初始化计数器
i=1

# 使用while循环计算阶乘
while [ $i -le $num ]
do
    # 计算阶乘
    factorial=$((factorial * i))
    # 增加计数器
    ((i++))
done
# 打印结果
echo "$num 的阶乘是: $factorial"

echo ""
 #5.编写一个使用嵌套for循环的脚本，为数字1到5创建一个简单的乘法表
echo "=== 练习5: 创建1-5乘法表 ==="

# 输出表头
echo "   1  2  3  4  5"
echo "-------------------"

# 外层循环，控制行（1到5）
for i in {1..5}
do
    # 打印行号
    printf "%d | " $i
    
    # 内层循环，控制列（1到5）
    for j in {1..5}
    do
        # 计算乘积
        result=$((i * j))
        # 打印结果，使用printf保持对齐
        printf "%2d " $result
    done
    # 换行
    echo
done

echo ""
echo "所有练习已完成!"