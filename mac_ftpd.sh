#!/bin/bash

#################################################
#
#   File Name: mac_ftpd.sh
#   Author: scan
#   Created Time: Wed Jul 28 12:12:43 2019
# 
#################################################


ftpd_cmd='/usr/libexec/ftpd'
ftpd_plist='/System/Library/LaunchDaemons/ftp.plist'
ftpd_pam_file='/etc/pam.d/ftpd'
netstat_cmd=`which netstat`

function check()
{
	if [[ ! -f "$ftpd_cmd" ]] || [[ ! -f "$ftpd_plist" ]] || [[ ! -f "$ftpd_pam_file" ]];then
		echo "ftpd or ftp.plist or ftpd_pam_file not found !"
		exit 1
	fi
}

function start()
{
	if [[ `$netstat_cmd -anltp tcp|grep LISTEN |grep ^tcp4|awk '{print $4}'|awk -F '.' '{if ($2==21) print $2}'|wc -l` -eq 0 ]];then
		sudo launchctl load -w /System/Library/LaunchDaemons/ftp.plist
	else
		if [[ `sudo launchctl list |grep 'com.apple.ftpd'|wc -l` -eq 1 ]];then
			echo "ftpd have running !"
		fi
		if [[ `ps -ef|grep "/usr/local/Cellar/vsftpd/3.0.3/sbin/vsftpd /etc/vsftpd.conf"|grep -v "grep"|wc -l` -eq 1 ]];then
			echo "vsftpd have running, please close vsftpd try again !"
		fi
	fi
}
function stop()
{
	if [[ `sudo launchctl list |grep 'com.apple.ftpd'|wc -l` -eq 1 ]];then
		sudo launchctl unload -w /System/Library/LaunchDaemons/ftp.plist
	else
		echo "ftpd not have running !"
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
