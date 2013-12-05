#!/bin/bash
: << start
Скрипт читает файл 'names', записывает его построчно в массив,
сортирует, выводит в файл, заданный в конфиге и тд по заданию...
start


. settings.conf

function generateChar() {
	if [ $# -eq 1 ];then
		for i in {1..40};do
			echo -n "$1"
			if [ $i -eq 40 ];then echo "";fi
		done
	fi
}

#Читаем файл и записываем его строки в массив
count=0
{
while read line;do
	mass[$count]=$line
	let "count += 1"
done
} < names

#Сортируем массив по алфавиту
length=${#mass[@]}
j=0
while [ $j -lt $length ];do
	i=0
	while [ $i -lt $length ];do
		if [[ ${mass[$i]} > ${mass[$j]} ]];then
			temp=${mass[$i]}
			mass[$i]=${mass[$j]}
			mass[$j]=$temp
		fi
		let "i += 1"
	done
	let "j += 1"
done

#Вывод отсортированного списка имен в файл
count=0
if [ -e "$WORKERS" -a -e "$TABLE" ];then rm $WORKERS $TABLE; fi
while [ $count -lt $length ];do
	echo -e "[`expr $count + 1`]: ""${mass[$count]}""\t[${#mass[$count]}]" >> $WORKERS
	let "count += 1"
done

#Вывод списка заданий и людей в файл
count=0
echo -e "Assigned tasks:\v" >> $TABLE
generateChar "-" >> $TABLE
{
while read line;do
	echo "${mass[$count]}=$line" >> $TABLE
	let "count += 1"
done
} < tasks
generateChar "-" >> $TABLE
echo -e "\vDate: $(date +%D)  Time: $(date +%T)" >> $TABLE

#Вывод списка заданий и завершающей фразы на экран
echo -e "Current tasks:\n"
{
while read line;do
	echo ${line// /_}
done
} < tasks
echo -e "\vAssigning:\t\tDONE"
echo -e "Worker list:\t\t$WORKERS"
echo -e "Assigned tasks table:\t$TABLE"
