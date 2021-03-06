#!/bin/bash

#################################################
#
#   File Name: mac_dns.sh
#   Author: scan
#   Created Time: 2019-07-24 14:07:13
# 
#################################################

# DNS profiles
# profile name::dns servers
DNS_PROFILES=$(cat <<EOF
Default DNS::221.130.33.52 221.130.33.60
rt DSN::192.168.123.1 223.5.5.5
t252 DNS::192.168.10.252 223.5.5.5
Ali Public DNS::223.5.5.5 223.6.6.6
114 Public DNS::114.114.114.114 114.114.115.115
gl Public DNS::8.8.8.8 8.8.4.4
dx Public DNS::219.141.136.10 219.141.140.10
bd Public DNS::180.76.76.76 8.8.4.4
one Public DNS::114.215.126.16 42.236.82.22
Opener DNS::208.67.222.222 208.67.220.220
EOF
)

# Swith to matched dns profile
function switch_dns()
{
    local dns_profile=$(echo "$DNS_PROFILES" | grep -iE "$1")
    local dns_name dns_servers

    dns_name=$(echo "$dns_profile" | awk -F:: '{print $1;exit}')
    dns_servers=$(echo "$dns_profile" | awk -F:: '{print $2;exit}')

    if [ -z "$dns_name" ]; then
        echo "没有找到匹配的 DNS 配置: '$1'"
        return
    fi

	local curr_net_dev=$(netstat -rn |grep -v "utun0"|grep -v 'stf0'| awk '/default/{print $NF}'|tr '\n' '|')
	local curr_net_serv=$(networksetup -listnetworkserviceorder | awk "/${curr_net_dev%?}/{print \$3}" | tr -d ', ')
	
    # Get the current network device and corresponding network service name
	if [[ $# -eq 0 ]];then
		for i in ${curr_net_serv}
		do
			echo "$i"" "$(networksetup -getdnsservers "$i")
		done
		exit 0
	fi
    # Clear the dns 
    dscacheutil -flushcache

    # Set the dns servers
	dns_name=$(echo $dns_name|awk '{print $1}')
	for i in ${curr_net_serv}
	do
		sudo networksetup -setdnsservers "$i" $dns_servers	
	done
	echo "切换DNS到 $dns_name $dns_servers"
	
}
if [[ $# -eq 1 ]];then
	switch_dns	$1
elif [[ $# -eq 0 ]];then
	switch_dns 
fi
#	echo	`networksetup -getdnsservers Wi-Fi`
