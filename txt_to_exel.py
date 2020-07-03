#!/usr/bin/env python
# -*- encoding: utf-8 -*-
#-------------------------------------------------------------------------------
import datetime
import time
import os
import sys
import xlsxwriter #需要的模块
import xlwt #需要的模块
if sys.version_info.major == 2:
    reload(sys)
    sys.setdefaultencoding('utf-8')

def txt2xlsx_number(filename,sep_str):	#文本转换成xlsx的函数，filename 表示一个要被转换的txt文本，xlsxname 表示转换后的文件名
	def isnum(s):
		if (s[0] == '0' and len(s) > 1 and s[1] != '.') or len(s.split('.')) > 1:
			return False
		return all(c in "0123456789." for c in s)
	print('converting xlsx ... ')
	f = open(filename)	 #打开txt文本进行读取
	x = 0				 #在excel开始写的位置（y）
	y = 0				 #在excel开始写的位置（x）
	xlsx=xlsxwriter.Workbook(filename+'.xlsx')
	sheet = xlsx.add_worksheet('sheet1') #生成excel的方法，声明excel
	number1 = xlsx.add_format()
	number1.set_num_format('0')
	while True:  #循环，读取文本里面的所有内容
		line = f.readline() #一行一行读取
		if not line:  #如果没有内容，则退出循环
			break
		for i in line.split(sep_str):#读取出相应的内容写到x
			#item=i.strip().decode('utf8')
			item=i.strip()
			if item and isnum(item):
				if '.' in item:
					item = float(item)
					sheet.write(x,y,item)
				else:
					item = float(item)
					sheet.write(x,y,item,number1)
			else:
				sheet.write(x,y,item)
			y += 1 #另起一列
		x += 1 #另起一行
		y = 0  #初始成第一列
	f.close()
	xlsx.close()
	#xls.save(filename+'.xls') #保存

def txt2xlsx(filename,sep_str):	#文本转换成xlsx的函数，filename 表示一个要被转换的txt文本，xlsname 表示转换后的文件名
	print('converting xlsx ... ')
	f = open(filename)	 #打开txt文本进行读取
	x = 0				 #在excel开始写的位置（y）
	y = 0				 #在excel开始写的位置（x）
	xlsx=xlsxwriter.Workbook(filename+'.xlsx')
	sheet = xlsx.add_worksheet('sheet1') #生成excel的方法，声明excel
	number1 = xlsx.add_format()
	number1.set_num_format('0')
	while True:  #循环，读取文本里面的所有内容
		line = f.readline() #一行一行读取
		if not line:  #如果没有内容，则退出循环
			break
		for i in line.split(sep_str):#读取出相应的内容写到x
			item=i.strip().decode('utf8')
			sheet.write(x,y,item)
			y += 1 #另起一列
		x += 1 #另起一行
		y = 0  #初始成第一列
	f.close()
	xlsx.close()
	#xls.save(filename+'.xls') #保存

def txt2xls_number(filename,sep_str):	#文本转换成xls的函数，filename 表示一个要被转换的txt文本，xlsname 表示转换后的文件名
	def isnum(s):
		return all(c in "0123456789." for c in s)
	print('converting xls ... ')
	f = open(filename)	 #打开txt文本进行读取
	x = 0				 #在excel开始写的位置（y）
	y = 0				 #在excel开始写的位置（x）
	xls=xlwt.Workbook()
	sheet = xls.add_sheet('sheet1',cell_overwrite_ok=True) #生成excel的方法，声明excel
	while True:  #循环，读取文本里面的所有内容
		line = f.readline() #一行一行读取
		if not line:  #如果没有内容，则退出循环
			break
		for i in line.split(sep_str):#读取出相应的内容写到x
			item=i.strip().decode('utf8')
			if item and isnum(item):
				item = float(item)
			sheet.write(x,y,item)
			y += 1 #另起一列
		x += 1 #另起一行
		y = 0  #初始成第一列
	f.close()
	xls.save(filename+'.xls') #保存


def txt2xls(filename,sep_str):	#文本转换成xls的函数，filename 表示一个要被转换的txt文本，xlsname 表示转换后的文件名
	print('converting xls ... ')
	f = open(filename)	 #打开txt文本进行读取
	x = 0				 #在excel开始写的位置（y）
	y = 0				 #在excel开始写的位置（x）
	xls=xlwt.Workbook()
	sheet = xls.add_sheet('sheet1',cell_overwrite_ok=True) #生成excel的方法，声明excel
	while True:  #循环，读取文本里面的所有内容
		line = f.readline() #一行一行读取
		if not line:  #如果没有内容，则退出循环
			break
		for i in line.split(sep_str):#读取出相应的内容写到x
			item=i.strip().decode('utf8')
			sheet.write(x,y,item)
			y += 1 #另起一列
		x += 1 #另起一行
		y = 0  #初始成第一列
	f.close()
	xls.save(filename+'.xls') #保存



if __name__ == "__main__":
        opt_rs = []
        argv_rs = []
        for i in sys.argv:
            if i[0] == '-':
                opt_rs.append(i)
            else:
                argv_rs.append(i)
        #print argv_rs,opt_rs
        if len(argv_rs) == 2:
            filename = argv_rs[1]
            sep_str = ' '
        elif len(argv_rs) == 3:
            filename = argv_rs[1]
            sep_str = argv_rs[2]
        else:
            print("Usage: %s [-xls save as .xls] [-int convert strings into integers] filename [Separator for example ':','|',',']" % sys.argv[0])
            sys.exit()

        if '-xls' in opt_rs:
            if '-int' in opt_rs:
                if os.path.isfile(filename):
                    txt2xls(filename,sep_str)
                else:
                    print(filename + " does not exist")
            else:
                if os.path.isfile(filename):
                    txt2xls_number(filename,sep_str)
                else:
                    print(filename + " does not exist")
        else:
            if '-int' in opt_rs:
                if os.path.isfile(filename):
                    txt2xlsx(filename,sep_str)
                else:
                    print(filename + " does not exist")
            else:
                if os.path.isfile(filename):
                    txt2xlsx_number(filename,sep_str)
                else:
                    print(filename + " does not exist")

                
        '''
	if len(sys.argv) >= 2 and sys.argv[1] == '-xls':
		if len(sys.argv) == 4:
			filename = sys.argv[2]
			sep_str = sys.argv[3]
			if os.path.isfile(filename):
				txt2xls(filename,sep_str)
			else:
				print filename + " does not exist"
		elif len(sys.argv) == 3:
			filename = sys.argv[2]
			sep_str = ' '
			if os.path.isfile(filename):
				txt2xls(filename,sep_str)
			else:
				print filename + " does not exist"
		else:
			print "Usage: %s filename" % sys.argv[0]
	else:
		if len(sys.argv) == 3:
			filename = sys.argv[1]
			sep_str = sys.argv[2]
			if os.path.isfile(filename):
				txt2xlsx(filename,sep_str)
			else:
				print filename + " does not exist"
		elif len(sys.argv) == 2:
			filename = sys.argv[1]
			sep_str = ' '
			if os.path.isfile(filename):
				txt2xlsx(filename,sep_str)
			else:
				print filename + " does not exist"
		else:
			print "Usage: %s [-xls save as .xls] [-int convert strings into integers] filename [Separator for example ':','|',',',':']" % sys.argv[0]
	'''	
