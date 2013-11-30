#!/bin/bash
touch not_ver.file

if [ $# -eq 0 ];then
	for i in {0..10};do
		touch "ver$i.file"
		ln -s "ver$i.file" "ver$i.file.lnk"
	done
	rm -f ver*
elif [ $# -eq 1 ];then
	directory="$1"
	mkdir -p $directory 2> /dev/null
	if [ $? -ne 0 ];then
		echo "Cant create folder :("
		exit
	fi
	for i in {0..10};do
		touch "$directory""ver$i.file"
		ln -s "$directory""ver$i.file" "$directory""ver$i.file.lnk"
	done
	rm -f "$directory"ver*
else echo "Sorry, but this script not support 2 or more arguments"
fi
