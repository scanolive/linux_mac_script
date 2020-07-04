#!/bin/bash

#################################################
#
#   File Name: mac_sleep_status.sh
#   Author: scan
#   Created Time: Wed Jul 31 10:39:50 2019
# 
#################################################

if [[ `pmset -g |grep "standby "|awk '{print $2}'` -eq 1 ]];then
	echo "cansleep"
else
	echo "nosleep"
fi	  

