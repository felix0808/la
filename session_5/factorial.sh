#!/bin/bash
number=$1
rez=1
while [ $number -gt 1 ];do
	let rez*=$number
	let "number -= 1"
done
echo $rez
