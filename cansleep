#!/bin/bash
#by scan
if [[ `ps -ef|grep caffeinate|wc -l` -gt 1 ]];then
	  killall caffeinate
fi	  

sudo pmset -a  standbydelay 10800
sudo pmset -a  standby 1
sudo pmset -a  networkoversleep 0
sudo pmset -a  sleep 1
sudo pmset -a  hibernatemode 0
sudo pmset -a  autopoweroff 1
sudo pmset -a  acwake 0
