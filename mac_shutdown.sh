#!/bin/bash

#################################################
#
#   File Name: mac_shutdown.sh
#   Author: scan
#   Created Time: 2019-08-02 16:30:03
# 
#################################################

if [[ -x /Library/Scripts/sound-off.sh ]];then
	/Library/Scripts/sound-off.sh 
fi
exec /sbin/shutdown.orig "$@"
