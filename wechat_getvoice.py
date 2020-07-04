#!/usr/bin/env python
# -- coding: utf-8 --

#################################################
#
#   File Name: wechat_getvoice.py
#   Author: scan
#   Created Time: Thu Oct 10 16:14:56 2019
# 
#################################################

#import requests,pymysql
import json,jsonpath,random,re,time,datetime,os,imghdr
from lxml import etree
from selenium import webdriver
#from urllib2 import request
import urllib2
import sys 
reload(sys) 
sys.setdefaultencoding('utf8')

def clean_name(s_name):
    str_list = [' ','。','）','（','！','？','+','~','.','，',')','(']
    for i in str_list:
        s_name = s_name.replace(i,'')
    return s_name

all_url = 'https://mp.weixin.qq.com/s/VV6Ab7TEQgdZ8qZglpzLvQ'
all_url = 'https://mp.weixin.qq.com/s/YH8vAezsYNTvHZwKq3zEBw'
all_url = 'https://mp.weixin.qq.com/s/vOP1wmrL3ojGGvJVqvdSsg'

def get_voice(url):
    request=urllib2.Request(url)
    request.add_header("user-agent","Mozilla/5.0")
    res = urllib2.urlopen(request)
    re_data = res.read().decode()
    data = etree.HTML(re_data)
    vid = data.xpath('//mpvoice/@voice_encode_fileid')
    title = data.xpath('//h2[@id="activity-name"]')
    filename = clean_name(title[0].text.strip()) + '.mp3'

    #print filename
    #print vid[0]
    print "wget https://res.wx.qq.com/voice/getvoice?mediaid=" + vid[0] + " -O " + filename

request=urllib2.Request(all_url)
request.add_header("user-agent","Mozilla/5.0")
res = urllib2.urlopen(request)
re_data = res.read().decode()
data = etree.HTML(re_data)
href_content = data.xpath('//a[@data-linktype="2"]/@href')

for href in href_content:
    url = href
    get_voice(url)
