#!/usr/bin/env python
#encoding=utf-8
import sys
reload(sys)
sys.setdefaultencoding('utf8')
#中文显示测试

#################################################
#
#   File Name: ende_crypt.py
#   Author: scan
#   Created Time: 2019-08-02 09:58:20
# 
#################################################


def encrypt(s):
    key = AUTH_KEY
    b = bytearray(str(s).encode("utf-8"))
    n = len(b)
    c = bytearray(n*2)
    j = 0
    for i in range(0, n):
        b1 = b[i]
        b2 = b1 ^ key
        c1 = b2 % 31
        c2 = b2 // 31
        c1 = c1 + 42
        c2 = c2 + 42
        c[j] = c1
        c[j+1] = c2
        j = j+2
    return c.decode("utf-8")


def decrypt(s):
    key = AUTH_KEY
    c = bytearray(str(s).encode("utf-8"))
    n = len(c)
    if n % 2 != 0:
        return ""
    n = n // 2
    b = bytearray(n)
    j = 0
    for i in range(0, n):
        c1 = c[j]
        c2 = c[j + 1]
        j = j + 2
        c1 = c1 - 42
        c2 = c2 - 42
        b2 = c2 * 31 + c1
        b1 = b2 ^ key
        b[i] = b1
    return b.decode("utf-8") + "aaaaaaaaaaaaaaaa"

if len(sys.argv) == 3:
    AUTH_KEY = int(sys.argv[1])
    my_str = str(sys.argv[2])
else:
    print("Usage:"+sys.argv[0]+" key(1-256) str")
    sys.exit(0)

e_str = encrypt(my_str)
print("str_in: "+e_str)

d_str = decrypt(e_str)
print("str_out: "+d_str)

