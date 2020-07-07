#!/bin/bash

#################################################
#
#   File Name: check_ssr.sh
#   Author: scan
#   Created Time: 2019-07-10 15:12:43
# 
#################################################

function check_ip()
{
	ip=$1
	if echo "${alive_ip_arr[@]}" | grep "$ip" &>/dev/null; then
		:
	else
		if echo "${down_ip_arr[@]}" | grep  "$ip" &>/dev/null; then
			:
		else
			delay=`ping -W 300 -c 1 $ip | grep 'time=' |awk -F '=' '{print $4}'|awk '{print $1}'|awk -F "." '{print $1}'` 
			if [[ $delay == "" ]];then
				down_ip_arr+=("$ip")
			else
				if [[ $min_delay -gt $delay ]];then
					min_delay=$delay
					min_delay_ip=$ip
				fi
				alive_ip_arr+=("$ip""_""$delay")
			fi
		fi
	fi
}

function check_node()
{
	s_str=$1
	ssr_str=`echo $s_str |base64 -D`
	server=`echo $ssr_str|awk -F ':' '{print $1}'`
	port=`echo $ssr_str|awk -F ':' '{print $2}'`
	protocol=`echo $ssr_str|awk -F ':' '{print $3}'`
	method=`echo $ssr_str|awk -F ':' '{print $4}'`
	obfs=`echo $ssr_str|awk -F ':' '{print $5}'`
	e_str=`echo $ssr_str|awk -F ':' '{print $6}'`
	password=`echo $e_str|awk -F '/?' '{print $1"="}'|base64 -D`
	o_str=`echo $e_str|awk -F '\?' '{print $2}'`
	for i in `echo $o_str|sed 's/&/ /g'`
	do
		if [[ `echo $i|grep  'obfsparam'|grep -v 'grep'|wc -l` -eq 1 ]];then
			obfs_param=`echo $i|awk -F '=' '{print $2"=="}'|base64 -D 2>/dev/null`
		fi
		if [[ `echo $i|grep  'protoparam'|grep -v 'grep'|wc -l` -eq 1 ]];then
			proto_param=`echo $i|awk -F '=' '{print $2"=="}'|base64 -D  2>/dev/null` 
		fi
		if [[ `echo $i|grep  'group'|grep -v 'grep'|wc -l` -eq 1 ]];then
			echo $i
			group=`echo $i|awk -F '=' '{print $2"=="}'|tr '_' '/'|base64 -D  2>/dev/null` 
			echo $group
		fi
	done
	if [[ $server != 'www.google.com' ]];then
		check_ip $server
	fi
	#echo $proto_param $password
	if echo "${alive_ip_arr[@]}" | grep  "$server" &>/dev/null; then
		cfg_file=`echo "$server"_"$port"".conf"`
		cat >$cfg_file<<EOF
	{
		"local_address" : "127.0.0.1",	
		"local_port" : 1086,
		"timeout" : 60,
		"obfs_param" : "$obfs_param",
		"protocol_param" : "$proto_param",
		"server" : "$server",
		"server_port" : $port,
		"protocol" : "$protocol",
		"method" : "$method",
		"obfs" : "$obfs",
		"password" : "$password"
	}
EOF
	else
		:
	fi
}

function dcode_ssr()
{
#	sub_url="https://ss.remang.cn/link/msyu6F5GDwkPmoyC"
#	wget -O '/tmp/ssr.txt' $sub_url
	for str in `cat /tmp/ssr.txt |base64 -D`
	do
		node_txt=`echo $str|sed 's/ssr:\/\///g'`
		check_node $node_txt
	done
}
alive_ip_arr=()
down_ip_arr=()
min_delay=300
min_delay_ip=""

dcode_ssr

echo "--------alive_ip--------"
echo ${alive_ip_arr[@]}|tr " " "\n"
echo "--------down_ip---------"
echo ${down_ip_arr[@]} |tr " " "\n"

echo $min_delay_ip $min_delay
