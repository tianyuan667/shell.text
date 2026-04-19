#1.编写一个以数字为输入的脚本，并告诉它是正、负还是零。
#!bin/bash 
read -p "输入一个数字Null" Null
if [ $Null -gt 0  ] 
	then 
		echo "正数"
		
elif [ $Null -eq 0  ] 
	then 
		echo "为0"
elif [ $Null -lt 0  ] 
	then 
		echo "负数"
fi
# 2.创建一个脚本来检查文件是否存在。如果是，请打印其内容；如果没有，请使用一些默认文本创建它
if [ -e ./text.sh   ] 
	then 
		echo "存在text.sh文件"
	else
	echo "创建.sh文件"
	echo "#!bin/bash ">./text.sh
	echo "创建成功"
fi
#3.编写一个脚本，比较作为命令行参数提供的两个数字，并打印第一个数字是大于、小于还是等于第二个数字
Null1=$1
Null2=$2
if [ $Null1 -gt $Null2  ] 
	then 
		echo "输入的第一个数大"
		
elif [ $Null2 -eq $Null1  ] 
	then 
		echo "两个数相同"
elif [ $Null1 -lt $Null2  ] 
	then 
		echo "输入的第一个数小"
fi
# 4.创建一个脚本，检查运行它的用户是否对指定文件具有写权限。根据结果打印相应的消息
if [ -w ./text.sh ] 
	then 
		echo "当前用户text.sh拥有写权限"
else 
	echo "当前用户text.sh没有写权限"
fi
