#!/bin/bash

#################################################
#
#   File Name: mv_back.sh
#   Author: scan
#   Created Time: Wed Jul 26 21:19:35 2019
# 
#################################################

if [[ $# -ne 1 ]]
then
	echo "use arg: $0 filename"
	exit
else
	if [[ -e $1 ]]
	then
		filename=$1
	else
		echo "$1 is not exist" 
		exit
	fi
fi

if [[ $filename =~ /$ ]]
then
	filename=${filename%?}
fi

new_filename=$filename`date +_%Y%m%d`
if [[ -e "${new_filename}" ]]
then
	new_filename=$filename`date +_%Y%m%d%H`
	if [[ -e "${new_filename}" ]]
	then 
		new_filename=$filename`date +_%Y%m%d%H%M`
		if [[ -e "${new_filename}" ]]
		then 
			new_filename=${filename}`date +_%Y%m%d%H%M%S`
		fi
	fi
fi

mv $filename $new_filename
echo "backup $filename mv to "$new_filename
