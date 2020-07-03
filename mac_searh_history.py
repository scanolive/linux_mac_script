#!/usr/bin/python
#encoding=utf-8

import sqlite3

db_file="/Users/rill/Library/Safari/History.db"
conn=sqlite3.connect(db_file)

def Select(sql):
    conn=sqlite3.connect(db_file)
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute(sql)
            rs = cursor.fetchall()
            cursor.close()
            return [True,rs]
        except Exception ,e:
            print sql+str(e)
            return [False,[]]
    else:
        return [False,[]]

sql="select title,url,url from history_visits left join history_items on  history_visits.history_item=history_items.id"

rs=Select(sql)

tmp_rs = []

for i in rs[1]:
    tmp_rs.append(('WebBookmarkTypeLeaf',i[0],i[1],i[2],'image/web.png', True, u'Favorite', u'/Favorite'))

print tmp_rs
