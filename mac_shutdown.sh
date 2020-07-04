#!/bin/bash

#################################################
#
#   File Name: mac_shutdown.sh
#   Author: scan
#   Created Time: Wed Jul 12 17:32:53 2019
# 
#################################################

if [[ -x /Library/Scripts/sound-off.sh ]];then
	/Library/Scripts/sound-off.sh 
fi
exec /sbin/shutdown.orig "$@"
