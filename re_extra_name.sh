#!/bin/bash

#################################################
#
#   File Name: re_extra_name.sh
#   Author: scan
#   Created Time: 2019-07-14 12:17:53
# 
#################################################

function re_extra_name()
{
	IFS_OLD=$IFS
	IFS=$'\n'
	oldext="$1"
	newext="$2"
	if [[ -d "$3" ]];then
		dir="$3"	
	else
		dir=$(eval pwd)
	fi
	if [[ -d "$dir" ]];then
		cd "$dir"
		if [[ $oldext == "@"  ]];then
			oldext=""
			for file in $( ls -l | awk '/^-.*/{print $9}'| grep -v '\.')
			do
				name=$(ls "$file" | cut -d. -f1)
				mv "$file" "${name}".$newext
			done
		else
			for file in $(ls -l *.$oldext|awk '{print $9}')
			do
		        name=$(ls "$file" | cut -d. -f1)
	       		mv "$file" "${name}".$newext
		 	done
		fi
		echo "change $oldext=====>$newext done!"
	else
		echo "dir err"
	fi
	IFS=$IFS_OLD
}

re_extra_name $1 $2
