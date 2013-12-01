#!/bin/bash
if [ $# -eq 1 ];then
	directory=$1
else directory="$(pwd)/"
fi
for file in "$directory"*;do
	if [ -h "$file" ];then
		cat $file &> /dev/null
		errCode=$?
		content="$(cat $file 2> /dev/null)"
		if [ $errCode -ne 0 ];then
			rm $file
		elif [ "$content" = "" ];then 			
			echo "Warning: $file - Empty symbolic link"
		fi
	fi
done
