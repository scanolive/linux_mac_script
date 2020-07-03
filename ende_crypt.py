#!/usr/bin/env python
#encoding=utf-8
#中文显示测试

#################################################
#
#   File Name: ende_crypt.py
#   Author: scan
#   Created Time: Thu Oct 24 09:49:46 2019
# 
#################################################

AUTH_KEY = 17

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
        print(i)
        c1 = c[j]
        c2 = c[j + 1]
        j = j + 2
        c1 = c1 - 42
        c2 = c2 - 42
        b2 = c2 * 31 + c1
        b1 = b2 ^ key
        b[i] = b1
    return b.decode("utf-8") + "aaaaaaaaaaaaaaaa"

my_str="iloverill_)#_)(_@#$(_@#($_#@(_''''''))))"

e_str = encrypt(my_str)
print(e_str)

d_str = decrypt(e_str)
print(d_str)

print(decrypt(b'+-*-D,3,@,:,.,@,/,3,@,/,:,>,H,A,=,;+=,+./-=,;+=,+-*-D,3,@,:,@,+->,'))
