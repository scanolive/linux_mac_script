#!/usr/bin/env python
#encoding=utf-8

#################################################
#
#   File Name: mac_show_chrome_his.py
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

    connstr = '/Users/rill/Library/Application Support/Google/Chrome/Default/History'
    if not os.path.exists(connstr):
        raise Exception('Chrome History File does not exists!')
    t = ((datetime.datetime.now() - datetime.datetime(1601,1,1)).total_seconds()-310800)
    conn = sqlite3.connect(connstr)
    cur = conn.cursor()
    querystr = 'select url,last_visit_time from urls order by last_visit_time desc'

    print(sql)
    try:
        cur.execute(querystr)
    except sqlite3.OperationalError:
        print('please close chrome browser at first!')

    data_all = cur.fetchall()
    expectdata = []
    for data in data_all:
        last_visit_time = data[1] / 1000 / 1000
        if last_visit_time > yestoday_timestamp:
            visit_time = basedate + datetime.timedelta(seconds=last_visit_time,hours=8)
            visit_time = time.strftime('%Y-%m-%d %H:%M:%S',datetime.datetime.timetuple(visit_time))
            expectdata.append(visit_time + '   ' + data[0])
        else:
            if expectdata == []:
                raise Exception('there is no data.')
            break
    cur.close()
    conn.commit()
    conn.close()
    return '\n'.join(expectdata)

if __name__ == '__main__':
    print(get_history_data())
