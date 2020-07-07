#!/usr/bin/env python
#encoding=utf-8
#中文显示测试

#################################################
#
#   File Name: random_num.py
#   Author: scan
#   Created Time: 2019-07-09 17:19:15
# 
#################################################

import sys
if sys.version_info.major == 2:
	reload(sys)
	sys.setdefaultencoding('utf-8')

import random

help_str = "Usage:"+sys.argv[0]+" start_number end_number"

if len(sys.argv) == 3:
    s_num = int(sys.argv[1])
    e_num = int(sys.argv[2])
    if s_num >= e_num:
        print(help_str)
    else:
        print(random.randint(s_num,e_num))
else:
    print(help_str)


