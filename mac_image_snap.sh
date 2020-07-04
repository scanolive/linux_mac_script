#!/bin/bash

#################################################
#
#   File Name: mac_image_snap.sh
#   Author: scan
#   Created Time: Wed Jul 23 17:19:30 2019
# 
#################################################


date_str=$(/bin/date '+%Y%m%d_%H%M%S')
#imagesnap_cmd=$(which imagesnap)
/usr/local/bin/imagesnap -w 2 $HOME/Pictures/ims_"$date_str".png
