#!/bin/bash

#################################################
#
#   File Name: mac_sleep_status.sh
#   Author: scan
#   Created Time: 2019-08-07 15:02:36
# 
#################################################

if [[ `pmset -g |grep "standby "|awk '{print $2}'` -eq 1 ]];then
	echo "cansleep"
else
	echo "nosleep"
fi	  

