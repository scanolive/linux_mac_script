#!/bin/bash

#################################################
#
#   File Name: mac_now_status.sh
#   Author: scan
#   Created Time: Wed Jul 31 10:39:50 2019
# 
#################################################

function check_lock()
{
    /usr/bin/python -c 'import Quartz;d=Quartz.CGSessionCopyCurrentDictionary();print d'|grep CGSSessionScreenIsLocked|wc -l
}
function check_lid()
{
	/usr/sbin/ioreg -r -k AppleClamshellState -d 4 | grep AppleClamshellState  | grep Yes|wc -l
}

function main()
{
	ISLOCK=$(check_lock)
	LID_STATUS=$(/usr/sbin/ioreg -r -k AppleClamshellState -d 4 | grep "AppleClamshellState"  | grep "Yes"|wc -l)
	if [[ $ISLOCK -eq 1 ]];then
		echo Mac is locked
	else
		echo Mac is not locked
	fi
	if [[ $LID_STATUS -eq 1 ]];then
		echo Mac is lid 
	else
		echo Mac is not lid 
	fi
}
main
