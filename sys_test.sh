#!/bin/bash

#################################################
#
#   File Name: sys_test.sh
#   Author: scan
#   Created Time: 2020-10-20 09:02:40
# 
#################################################

{ time -p echo "scale=5000; 4*a(1)" | bc -l -q|grep real;  } 2> /tmp/time.txt

cpu_num=`cat /proc/cpuinfo |grep processor|wc -l`
use_time=`cat  /tmp/time.txt |grep real |awk '{print $2}'`

cpu_test=$(printf "%.3f" `echo "scale=3;$use_time/$cpu_num" |bc -l`)
IP=`hostname -I`
if [[ -d "/home/xinke/disk_md0/" ]];then
	{ dd if=/dev/zero of=/home/xinke/disk_md0/testfile.tmp bs=8k count=400000 conv=fdatasync; } 2> /tmp/test_disk.tmp
	if [[ -f /home/xinke/disk_md0/testfile.tmp ]];then
		rm /home/xinke/disk_md0/testfile.tmp
	fi
else
	echo "err" > /tmp/test_disk.tmp
fi

disk_test=`cat /tmp/test_disk.tmp |grep copied|awk -F ',' '{print $NF}'`

echo  $IP"|"$cpu_test"|"$disk_test
