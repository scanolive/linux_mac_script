#!/bin/bash

#################################################
#
#   File Name: mac_screen_capture.sh
#   Author: scan
#   Created Time: 2019-07-27 16:37:03
# 
#################################################


function check_lock()
{
    /usr/bin/python -c 'import Quartz;d=Quartz.CGSessionCopyCurrentDictionary();print d'|grep CGSSessionScreenIsLocked|wc -l
}
ISLOCK=$(check_lock)
if [[ $ISLOCK -eq 0 ]];then
	date_str=$(/bin/date '+%Y%m%d_%H%M%S')
	/usr/sbin/screencapture -x "$HOME"/Pictures/jietu/jt_"$date_str".jpg
fi
