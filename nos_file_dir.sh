#!/bin/bash

#################################################
#
#   File Name: nos_file_dir.sh
#   Author: scan
#   Created Time: Wed Jul 31 10:39:50 2019
# 
#################################################

dir=$1

if [[ ! -z "$dir" ]];then
	cd $dir
fi

for loop in `/bin/ls -1 | sed 's/ /%%%/g;s/(/###/g;s/)/===/g'`
do  
	old_name=`echo $loop | sed 's/%%%/ /g;s/###/(/g;s/===/)/g'`
	new_name=`echo $loop | sed 's/###/_/g;s/===/_/g;s/%%%/_/g'`
	if [[ "$old_name" != "$new_name" ]];then
		mv "$old_name" "$new_name"
	fi
	#mv  "`echo $loop | sed 's/_/ /g' `"  "`echo $loop |sed 's/ /_/g' `"  2> /dev/null 
done
