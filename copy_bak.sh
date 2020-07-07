#!/bin/bash

#################################################
#
#   File Name: copy_bak.sh
#   Author: scan
#   Created Time: 2019-08-03 10:22:30
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

cp -r $filename $new_filename
echo 'backup filename is '$new_filename
