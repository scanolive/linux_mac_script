#!/bin/bash

#################################################
#
#   File Name: url_filename.sh
#   Author: scan
#   Created Time: 2019-08-03 14:14:35
# 
#################################################

if [[ $# -eq 1 ]];then
	filename=$1
	new_file=`python -c 'import urllib;import sys;rawurl = sys.argv[1]; print urllib.unquote(rawurl)' ${filename}`
	mv $filename $new_file
else
	echo "Usage: $0 filename"
	exit 1
fi
