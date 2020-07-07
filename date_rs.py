#!/usr/bin/env python

#################################################
#
#   File Name: date_rs.py
#   Author: scan
#   Created Time: 2019-07-24 14:33:39
# 
#################################################

#encoding=utf-8
import datetime

def date2rs(s_date,e_date):
        a = 1
        date_rs = []
        sdate = datetime.datetime.strptime(s_date, "%Y-%m-%d")
        edate = datetime.datetime.strptime(e_date, "%Y-%m-%d")
        while a:
                if sdate <= edate:
                        date_rs.append(sdate.strftime('%Y-%m-%d'))
                else:
                        a = 0
                sdate = sdate + datetime.timedelta(days=1)
        return date_rs

for i in date2rs('2018-05-03','2019-01-01'):
    print(i)
