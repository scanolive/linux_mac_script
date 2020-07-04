#!/bin/bash

#################################################
#
#   File Name: mac_tftpd.sh
#   Author: scan
#   Created Time: Wed Jul 28 18:43:15 2019
# 
#################################################

tftpd_cmd='/usr/libexec/tftpd'
tftpd_plist='/System/Library/LaunchDaemons/tftp.plist'
netstat_cmd=`which netstat`

function check()
{
	if [[ ! -f "$tftpd_cmd" ]] || [[ ! -f "$tftpd_plist" ]];then
		echo "tftpd or tftp.plist  not found !"
		exit 1
	fi
}

function start()
{
	if [[ `$netstat_cmd -anltp udp|grep LISTEN |grep ^udp4|awk '{print $4}'|awk -F '.' '{if ($2==69) print $2}'|wc -l` -eq 0 ]];then
		sudo launchctl load -w /System/Library/LaunchDaemons/tftp.plist
	else
		if [[ `sudo launchctl list |grep 'com.apple.tftpd'|wc -l` -eq 1 ]];then
			echo "tftpd have running !"
		fi
	fi
}
function stop()
{
	if [[ `sudo launchctl list |grep 'com.apple.tftpd'|wc -l` -eq 1 ]];then
		sudo launchctl unload -w /System/Library/LaunchDaemons/tftp.plist
	else
		echo "tftpd not have running !"
	fi 
}

case "$1" in
start)
	check
	start
	;;
stop)
	check
	stop
	;;
*)
	echo "Usage: $0 {start|stop}"
	exit 1
	;;
esac
