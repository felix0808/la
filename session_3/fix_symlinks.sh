#!/bin/bash
if [ $# -eq 1 ];then
	directory=$1
else directory="$(pwd)/"
fi
for file in "$directory"*;do
	if [ -h "$file" ];then
		if [ ! -e "$file" ];then
			rm $file
		elif [ ! -s "$file" ];then
			echo "Warning: $file - link to empty file"
		fi
	fi
done
