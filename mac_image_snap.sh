#!/bin/bash
date_str=$(/bin/date '+%Y%m%d_%H%M%S')
#imagesnap_cmd=$(which imagesnap)
/usr/local/bin/imagesnap -w 2 $HOME/Pictures/ims_"$date_str".png
