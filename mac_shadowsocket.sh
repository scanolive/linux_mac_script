#!/bin/bash

#################################################
#
#   File Name: mac_shadowsocket.sh
#   Author: scan
#   Created Time: Wed Jul 06 15:26:15 2019
# 
#################################################

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/Users/rill/bin:/usr/local/bin"
ss_local_cmd=`which ss-local`
privoxy_cmd=`which privoxy`
cfg_dir="/etc/shadowsocks-libev/"
#ss_local_cmd="/usr/local/bin/ss-local"
#privoxy_cmd="/usr/local/bin/privoxy"
pac_dir="/etc/proxy"
pac_file='http://127.0.0.1:14321/proxy.pac'
white_list="/etc/proxy/chn.acl"
gfwlist="/etc/proxy/gfwlist.acl"
if [[ `/usr/sbin/networksetup -listallnetworkservices |grep "^USB$"|wc -l` -eq 1 ]];then
	net_devs="USB Wi-Fi"
else
	net_devs="Wi-Fi"
fi

down_ip_arr=()
alive_ip_arr=()
min_delay=300
min_delay_ip=""

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
                alive_ip_arr+=("$ip""__""$delay""ms")
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
	done
	if [[ $server != 'www.google.com' ]] && [[ $server != 'ld.remang.cn' ]] && [[ $server != '219.76.161.238' ]];then
		check_ip $server
	fi
	#echo $proto_param $password
	if echo "${alive_ip_arr[@]}" | grep  "$server" &>/dev/null; then
		server_pre=`echo "$server"| awk -F "." '{print $1}'`
		cfg_file="$cfg_dir""$server_pre""_""$port"".json"
		if [[ ! -f $cfg_file ]];then
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
		fi
	else
		:
	fi
}

function check_speed()
{
	sub_txt=$cfg_dir"ssr_sub.txt"
	sub_url="https://ss.remang.cn/link/kmD0dzbGESjPGGaK"
	rm $sub_txt
	if [[ ! -f $sub_txt ]];then
		wget -O $sub_txt $sub_url
	fi
	for str in `cat $sub_txt |base64 -D`
	do
		node_txt=`echo $str|sed 's/ssr:\/\///g'`
		check_node $node_txt
	done
}

#echo "--------alive_ip--------"
#echo ${alive_ip_arr[@]}|tr " " "\n"
#echo "--------down_ip---------"
#echo ${down_ip_arr[@]} |tr " " "\n"

function check_fast()
{
	check_speed
	server_pre=`echo "$min_delay_ip"| awk -F "." '{print $1"_"}'`
	cfg_file=`ls $cfg_dir$server_pre*.json|awk '{print $1}'`
}

function check_cfg()
{
	cfg_file=$1
	if [[ ! -f "$ss_local_cmd" ]] || [[ ! "$privoxy_cmd" ]] || [[ ! -f "$white_list"  ]] || [[ ! -f "$gfwlist"  ]] ;then
		echo "ss_local_cmd or privoxy_cmd or white_list or gfwlist not found !"
		exit 1
	fi
	if [[ -f $cfg_file ]];then
		server=`cat $cfg_file |grep '"server"'|awk -F ':' '{print $2}'|awk -F '"' '{print $2}'`
		check_ip $server
		ping -W 200 -c 2 $server > /dev/null
		if [ $? -ne 0 ];then
			echo "$server"" cannot connect"
			exit 1
		fi
	else
		echo "config file is not exist"
		exit 1
	fi
}

function start()
{
	cfg_file=$2
	if [[ "$1" == "g" ]];then
		nohup $ss_local_cmd -c $cfg_file  > /dev/null 2>&1  &
		for netdev in $net_devs
		do
			/usr/sbin/networksetup -setsocksfirewallproxy  "$netdev" 127.0.0.1 1086
		done
	elif [[ "$1" == "w" ]];then
		nohup $ss_local_cmd -c $cfg_file -v --acl "$white_list" > /dev/null 2>&1  & 
		nohup $privoxy_cmd  --no-daemon /etc/privoxy.config  > /dev/null 2>&1  &
		for netdev in $net_devs
		do
			/usr/sbin/networksetup -setwebproxy "$netdev" "127.0.0.1" "1087"
			/usr/sbin/networksetup -setsecurewebproxy "$netdev" "127.0.0.1" "1087"
			/usr/sbin/networksetup -setsocksfirewallproxy  "$netdev" 127.0.0.1 1086
		done
	elif [[ "$1" == "l" ]];then
		nohup $ss_local_cmd -c $cfg_file -v --acl "$gfwlist" > /dev/null 2>&1  & 
		nohup $privoxy_cmd  --no-daemon /etc/privoxy.config  > /dev/null 2>&1  &
		for netdev in $net_devs
		do
			/usr/sbin/networksetup -setwebproxy "$netdev" "127.0.0.1" "1087"
			/usr/sbin/networksetup -setsecurewebproxy "$netdev" "127.0.0.1" "1087"
			/usr/sbin/networksetup -setsocksfirewallproxy  "$netdev" 127.0.0.1 1086
		done
	else
		nohup $ss_local_cmd -c $cfg_file  > /dev/null 2>&1  &
		nohup $privoxy_cmd	--no-daemon /etc/privoxy.config  > /dev/null 2>&1  &
		cd "$pac_dir"
		nohup python -m SimpleHTTPServer 14321 >> /Users/rill/logs/pac.log 2>&1 &
		for netdev in $net_devs
		do
			/usr/sbin/networksetup -setautoproxyurl "$netdev"  "$pac_file"
			#/usr/sbin/networksetup -setautoproxyurl "$netdev"  "file:""$pac_file"
		done
	fi
}
function stop()
{
	if [[ `ps -ef|grep ss-local|grep -v grep|wc -l` -gt 0 ]] ;then
		killall ss-local
	fi
	if [[ `ps -ef|grep privoxy|grep -v grep|wc -l` -gt 0 ]] ;then
		killall privoxy	
	fi
	
	if [[ `ps -ef|grep "SimpleHTTPServer 14321"|grep -v "grep"|wc -l` -gt 0 ]] ;then
		kill -9 `ps -ef|grep "SimpleHTTPServer 14321"|grep -v "grep"|awk '{print $2}'`
	fi

    for netdev in $net_devs
	do
		/usr/sbin/networksetup -setautoproxystate  "$netdev" off
		/usr/sbin/networksetup -setsocksfirewallproxystate "$netdev" off
		/usr/sbin/networksetup -setwebproxystate	"$netdev" off
		/usr/sbin/networksetup -setsecurewebproxystate "$netdev" off
	done
}


while [[ $# -gt 0 ]]
do
case $1 in 
	-g)
	mode="g"
	;;
	-w)
	mode="w"
	;;
	-l)
	mode="l"	
	;;
	start)
	action="start"
	;;
	stop)
	action="stop"
	;;
	check)
	action="check"
	;;
	-c)
	cfg_file=$2
	shift
	;;
	*)
	echo "Unknow Options -> $1"
	echo "Usage: $0 [-g Global | -w white_list | -l gwflist default pac] [-c config_file]  {start|stop|check}"
	exit 1
	;;
esac
shift
done

if [[ "$mode" == "" ]];then
	mode="pac"
fi

if [[ "$action" == "" ]];then
	echo "Usage: $0 [-g Global | -w white_list | -l gwflist default pac] [-c config_file]  {start|stop|check}"
elif [[ "$action" == "start" ]];then
	if [[ "$cfg_file" == "" ]];then
		check_fast
	fi
	stop
	check_cfg $cfg_file
	start $mode $cfg_file
	echo "connect to "$min_delay_ip"  delay is ""$min_delay""ms"
elif [[ "$action" == "stop" ]];then
	stop
elif [[ "$action" == "check"  ]];then
	check_speed
	echo "-+-+-+-+- DOWN_IP -+-+-+-+-"
	echo ${down_ip_arr[@]} |tr " " "\n"
	echo "-+-+-+-+- ALIVE_IP -+-+-+-+-"
	echo ${alive_ip_arr[@]}|tr " " "\n"|tr '__' "\t"
else
	echo "Usage: $0 [-g Global | -w white_list | -l gwflist default pac] [-c config_file]  {start|stop|check}"
fi
