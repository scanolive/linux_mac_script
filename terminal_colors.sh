#!/bin/bash

#################################################
#
#   File Name: terminal_colors.sh
#   Author: scan
#   Created Time: Wed Jul 26 11:29:15 2019
# 
#################################################

for i in `seq 16 255`; do printf "\e[38;5;%sm %s\t" $i $i;done;echo ""  
echo ''
#echo "\e[38;05;xxxm"
