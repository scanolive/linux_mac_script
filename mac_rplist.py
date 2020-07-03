#!/usr/bin/python
#encoding=utf-8

from biplist import *  
try:  
    plist = readPlist("/r/Library/Safari/Bookmarks.plist")  
    for i in plist:
        print i
        print type(plist.get(i))
except (InvalidPlistException, NotBinaryPlistException), e:  
    print "Not a plist:", e 
