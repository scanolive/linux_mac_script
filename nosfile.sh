#!/bin/bash

a=$1
b=$(echo $a|tr ' ' '_'|tr '(' '_'|tr ')' '_')
mv "$a" "$b"
