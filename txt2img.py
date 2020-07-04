#!/usr/bin/env python
#-*- coding:utf-8 -*-

#################################################
#
#   File Name: txt2img.py
#   Author: scan
#   Created Time: Wed Jul 21 16:33:10 2019
# 
#################################################

import os
from PIL import Image,ImageFont,ImageDraw
font = ImageFont.truetype("/Library/Fonts/Arial Narrow.ttf", 9) 
#设置文字字体和大小,合适的字体会缩小图片文件的大小

line_len = 1000
#设置每行的字符数

line_num = 245
#设置行数

f = open("/x/hth.txt")
#设置输入文件路径

file_str = f.read()
f.close()
file_list = file_str.split()
text = ''
count = 0
filename = 1
im = Image.new("RGB", (4000, 2300), (255, 255, 255))
dr = ImageDraw.Draw(im)
num = 0
for line in file_list:
	text = text + line + ' '
	num = num + 1
	if num == len(file_list):
		dr.text((30, 30+9*count), text, font=font, fill="#000000")
	if len(text) > line_len:
		dr.text((30, 30+9*count), text, font=font, fill="#000000")
		if count > line_num:
			im.save("xt_" + str(filename) +".jpeg")
			im = Image.new("RGB", (4000, 2300), (255, 255, 255))
			dr = ImageDraw.Draw(im)
			filename = filename + 1
			count = 0
		else:
			count = count + 1
		text = ''
im.save("xt_" + str(filename) +".jpeg") 
