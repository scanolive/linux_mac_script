#!/bin/bash

#################################################
#
#   File Name: shutdown.sh
#   Author: scan
#   Created Time: Wed Jul 31 10:39:50 2019
# 
#################################################

/Library/Scripts/sound-off.sh 
exec /sbin/shutdown.orig "$@"
