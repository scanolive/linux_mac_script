#!/bin/bash

date '+%Y年%m月%d日'
lunar -h `date '+%Y %m %d'` | iconv -f gb18030|awk -F '子' 'NR==4 {print $1}'|sed 's/阴历：　//g'|sed 's/ //g'
