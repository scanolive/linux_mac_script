#!/bin/bash

#################################################
#
#   File Name: url_filename.sh
#   Author: scan
#   Created Time: Wed Jul 31 10:39:50 2019
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
