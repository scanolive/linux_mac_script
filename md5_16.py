#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sys
if sys.version_info.major == 2:
    reload(sys)
    sys.setdefaultencoding('utf-8')
#设置编码
import hashlib
if len(sys.argv) == 2:
	content = sys.argv[1].encode('utf-8')
	signature = hashlib.md5(content).hexdigest()[8:-8]

	print(signature)
else:
	print ("Usage: %s %s" % (sys.argv[0],'str'))
