#!/bin/bash

#################################################
#
#   File Name: cut_video.sh
#   Author: scan
#   Created Time: Wed Jul 31 10:39:50 2019
# 
#################################################

ffmpeg_bin=`which ffmpeg`

if [[ ! -f $ffmpeg_bin ]];then
	echo ffmpeg not installed!
	exit 
fi

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
	echo "Usage:$0 start_time seconds FileNmae"
	echo "   eg. $0  0 3600 example.mp4"
	exit
else
	start_time=$1
	vides_seconds=$2
	file_name=$3	
	echo "cuttig video..."
	file_name_pre=$(echo $file_name | cut -f 1 -d '.')
	file_type=$(echo $file_name | cut -f 2 -d '.')
	ffmpeg -ss $start_time -i $file_name -t $vides_seconds  -acodec copy -vcodec copy $file_name_pre-$start_time-$vides_seconds.$file_type
fi



