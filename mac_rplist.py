#!/usr/bin/python
#encoding=utf-8

#################################################
#
#   File Name: mac_rplist.py
#   Author: scan
#   Created Time: 2019-07-13 11:45:36
# 
#################################################

from biplist import *  
try:  
    plist = readPlist("/r/Library/Safari/Bookmarks.plist")  
    for i in plist:
        print i
        print type(plist.get(i))
except (InvalidPlistException, NotBinaryPlistException), e:  
    print "Not a plist:", e 
