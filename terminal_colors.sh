#!/bin/bash

#################################################
#
#   File Name: terminal_colors.sh
#   Author: scan
#   Created Time: 2019-07-17 17:18:36
# 
#################################################

for i in `seq 16 255`; do printf "\e[38;5;%sm %s\t" $i $i;done;echo ""  
echo ''
#echo "\e[38;05;xxxm"
