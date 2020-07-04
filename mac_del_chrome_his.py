#!/usr/bin/env python

#################################################
#
#   File Name: mac_del_chrome_his.py
#   Author: scan
#   Created Time: Wed Mar 13 13:35:49 2019
# 
#################################################


"""
Get Visitied URLS in Chrome History
"""

import sqlite3
import time
import datetime
import os


def get_history_data():
    now = datetime.datetime.now()
    now_000 = time.strftime('%Y-%m-%d',datetime.datetime.timetuple(now))

    today = datetime.datetime.strptime(now_000,'%Y-%m-%d')
    yestoday = today - datetime.timedelta(days=1)
    basedate = datetime.datetime(1601,1,1)

    yestoday_timestamp = (yestoday - basedate).total_seconds()

    #connstr = '/w/chrome_his.sqlite'
    connstr = '/Users/rill/Library/Application Support/Google/Chrome/Default/History'
    if not os.path.exists(connstr):
        raise Exception('Chrome History File does not exists!')
    t = ((datetime.datetime.now() - datetime.datetime(1601,1,1)).total_seconds()-28800-2*3600)

    conn = sqlite3.connect(connstr)
    cur = conn.cursor()
    querystr = 'select url,last_visit_time from urls order by last_visit_time desc'
    sql = 'delete from urls where last_visit_time > '+  str(t)[0:-2]+'000000'

    os.system("chrome_pid=`ps -ef |awk '/\/Applications\/Google\ Chrome.app\/Contents\/MacOS\/Google\ Chrome/ {print $2 }'`; if [[ $chrome_pid != ''  ]];then kill -9 $chrome_pid; fi")
    try:
        cur.execute(sql)
    except sqlite3.OperationalError:
        print('please close chrome browser at first!')

    conn.commit()
    conn.close()

if __name__ == '__main__':
    get_history_data()
