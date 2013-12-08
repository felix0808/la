#!/bin/bash
i=0
for arg in $@;do
	array[$i]=$arg
	let "i += 1"
done
first=${array[0]}
second=${array[1]}
result=0
for i in ${array[@]};do
	if [ $first -lt $second ] && [ $i -gt $first ] && [ $i -lt $second ];then
		let "result += $i"
	fi
	if [ $first -gt $second ] && [ $i -lt $first ] && [ $i -gt $second ];then
		let "result += $i"
	fi
done
echo "Result = $result"
