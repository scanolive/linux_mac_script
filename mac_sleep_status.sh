#!/bin/bash
#by scan
if [[ `pmset -g |grep "standby "|awk '{print $2}'` -eq 1 ]];then
	echo "cansleep"
else
	echo "nosleep"
fi	  

