#!/bin/bash
function main() {
	j=0
	while [ $j -le $LIMIT ];do
		array[$j]=$j
		let "j += 1"
	done
	array[1]=0
	i=2
	while [ $i -le $LIMIT ];do
		if [ ${array[$i]} -ne 0 ];then
			simple=( "${simple[@]}" ${array[$i]} )
			#--verbose start
			if $v;then
				if ! $f;then
					echo "${simple[$(expr ${#simple[@]} - 1)]} prime"
				else
					all=( "${all[@]}" "${simple[$(expr ${#simple[@]} - 1)]} prime" )
				fi
			fi
			#--verbose end
		fi
		let "inner = $i * $i"
		while [ $inner -le $LIMIT ];do
			#--verbose start--
			if $v;then
				if ! $f; then
					echo "$inner not prime: divides by $i";
				else
					all=( "${all[@]}" "$inner not prime: divides by $i" )
				fi
			fi
			#--verbose end--
			array[$inner]=0
			let "inner += $i"
		done
		let "i += 1"
	done
}

function is_prime(){
	i=2
	while [ $i -lt $1 ];do
		if [ $(expr $1 % $i) -ne 0 ];then
			let "i += 1"
			continue
		else 
			return 1
			exit
		fi
	done
	return 0
}

function usage(){
	echo "This script calculate prime numbers
	Possible options:
	-f filename : save result in filename
	-h          : print help
	-v          : Output on stdout all numbers - prime and not prime
	-n number   : The number to which calculate prime numbers
	-N number   : Same as -n number"
	exit
}

function checkWrite(){
	if [ ! -w $(dirname $1) ];then
		echo "No access to write in directory $(dirname $1)"
		exit
	elif [ -f "$1" -a ! -w "$1" ];then
		echo "No access to write in file $1"
		exit
	fi
}


if [ $# -eq 0 ];then
	usage
fi
f=false;v=false;n=false
while getopts ":f:hvn:N:" Option;do
	case $Option in
		f	) f=true; filename=$OPTARG;;
		h	) usage;;
		v	) v=true;;
		n | N	) n=true;LIMIT=$OPTARG;;
		*	) echo -e "Not supported arguments :(\n\n";usage;;
	esac
done


if ! $n;then echo "Option '-n number' must be set ";exit;fi
main

if [ "$v" = false -a "$f" = true ];then
	checkWrite $filename
	echo ${simple[@]} > $filename
elif [ "$v" = false -a "$f" = false ];then
	echo ${simple[@]}
elif [ "$v" = true -a "$f" = false ];then
	:
elif [ "$v" -a "$f" ];then
	echo "Please enter file name again"
	read filename2
	checkWrite $filename2
	i=0
	while [ $i -lt ${#all[@]} ];do
		echo ${all[$i]} >> $filename2
		let "i += 1"
	done
fi
