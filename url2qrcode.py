#!/usr/bin/python
#encoding=utf-8

#################################################
#
#   File Name: url2qrcode.py
#   Author: scan
#   Created Time: 2019-07-30 11:53:53
# 
#################################################

import qrcode
qr = qrcode.QRCode(version=5,border=0)  
url = sys.argv[1]
img_file = sys.argv[2]
qr.add_data(url)
qr.make()
img = qr.make_image()
img.save(img_file)
