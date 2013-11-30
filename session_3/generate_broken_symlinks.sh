#!/bin/bash
touch not_ver.file
i=0
while [ $i -le 10 ];do
	touch "ver$i.file"
	ln -s "ver$i.file" "ver$i.file.lnk"
	i=$(expr $i + 1)
done

rm -f ver*
