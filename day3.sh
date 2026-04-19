#!bin/bash 
:<<!
read -p "输入一个用户名:" Username
read -p "输入一个年龄:" Userage
echo "Username=$Username" 
echo "Userage=$Userage" 
!
#2. 编写一个脚本，将两个数字作为命令行参数，将它们存储在变量中，然后执行并显示这些数字的加减乘除结果
read -p "输入Null1：" Null1
read -p "输入Null2：" Null2
count=$((Null1 + Null2))
jian=$((Null1 - Null2))
cheng=$((Null1 * Null2))
chu=$((Null1 / Null2))
echo "相加结果为:$count"
echo "相减结果为:$jian"
echo "相乘结果为:$cheng"
echo "相除结果为:$chu"
# 3. 创建一系列您最喜欢的书籍。编写一个脚本，在新行上打印每本书，前面是它在数组中的索引。
# 定义书籍数组（你可以随便改名字）
books=("三体" "红楼梦" "老人与海" "盗墓笔记" "哈利波特")
length=${#books[@]}

echo "我最喜欢的书籍列表："
for ((i=0; i<length; i++))
do
    echo "index $i：${books[$i]}"
done
#编写一个脚本，使用命令替换来获取当前用户、当前目录和当前日期/时间，并以格式化方式打印这些信息。
usr=$(whoami)
dir=$(pwd)
nowtime=$(date)
echo "当前用户：$usr"
echo "当前目录$dir"
echo "当前时间$nowtime"
 #5. 创建一个脚本来演示至少三个特殊变量的使用。例如，它可以打印脚本名称、传递给它的参数数量以及所有参数。
 echo "脚本命令$0,第一个信息$1"
 echo "获取参数的个数$#"
 echo "获取参数的字符合并输出$*"
 echo "获取参数的字符分开输出$@"