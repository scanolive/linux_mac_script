#!/bin/bash

#################################################
#
#   File Name: arg.sh
#   Author: scan
#   Created Time: 2019-08-03 11:33:23
# 
#################################################

function check_arg()
{
	if [[ $# -eq 0 ]];then
		echo "Unknow Options or Action -> $1"
		echo "Usage:sh $0 [ -a options1 ] [ -b options2 ] [-c config_file] {start|stop|check}"
		exit 1
	fi

	while [[ $# -gt 0 ]]
	do
	case $1 in 
		-a)
		options="a"
		;;
		-b)
		options="b"
		;;
		start)
		action="start"
		;;
		stop)
		action="stop"
		;;
		check)
		action="check"
		;;
		-c)
		cfg_file=$2
		shift
		;;
		*)
		echo "Unknow Options or Action -> $1"
		echo "Usage:sh $0 [ -a options1 ] [ -b options2 ] [-c config_file] {start|stop|check}"
		exit 1
		;;
	esac
	shift
	done
	if [[ $action == "" ]];then
		echo "Usage:sh $0 [ -a options1  ] [ -b options2  ] [-c config_file] {start|stop|check}"
		exit 1
	fi
}	

check_arg $@

echo Options: $options
echo Action: $action
#if [[  $action == ""  ]];then
#	echo "Usage:sh $0 [ -g Global | -w white_list | -l gwflist default pac ]  [-c config_file] {start|stop|check}"
#fi
