#!/bin/bash

#################################################
#
#   File Name: mac_wifi.sh
#   Author: scan
#   Created Time: Wed Jul 23 17:35:32 2019
# 
#################################################

DEVICE=$(networksetup -listallhardwareports | grep -A 2 -E "AirPort|Wi-Fi" | grep -m 1 -o -e en[0-9]);

if [[ $1 == "off" ]];then
	networksetup -setairportpower $DEVICE Off
elif [[ $1 == "on" ]];then
	networksetup -setairportpower $DEVICE On
elif [[ $1 == "s" ]];then
	networksetup -getairportpower $DEVICE
elif [[ $1 == "r" ]];then
	networksetup -setairportpower $DEVICE Off
	sleep 1
	networksetup -setairportpower $DEVICE On
else
	echo "Usage: $0 {on|off|s(status)}"
fi
