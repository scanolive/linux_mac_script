#!/usr/bin/python
#encoding=utf-8

#################################################
#
#   File Name: mac_rplist.py
#   Author: scan
#   Created Time: Wed Jul 07 14:18:27 2019
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
