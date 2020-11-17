#!/bin/bash

#################################################
#
#   File Name: test.sh
#   Author: scan
#   Created Time: 2020-10-20 09:02:40
# 
#################################################

{ time -p echo "scale=10000; 4*a(1)" | bc -l -q|grep real;  } 2> /tmp/time.txt

cpu_num=`cat /proc/cpuinfo |grep processor|wc -l`
use_time=`cat  /tmp/time.txt |grep real |awk '{print $2}'`

echo "scale=3;$use_time/$cpu_num" |bc -l
