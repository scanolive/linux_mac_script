#!/bin/bash
UNAME=`which uname`
HOSTNAME_CMD=`which hostname`
DMIDECODE=`which dmidecode` || (yum install dmidecode -y;DMIDECODE=`which dmidecode`)
FDISK=`which fdisk`
FREE=`which free`
UNAME=`which uname`
CPU_MODEL=`cat /proc/cpuinfo | grep "model name"|uniq |cut -f2 -d:`
DISK_SIZE=`$FDISK -l 2>/dev/null |grep "Disk"|grep bytes|grep -v "VolGroup"|grep -v "mapper"|grep -v "md0"| awk '{print $2$3$4}'|tr '\n' ','|sed 's/,,/,/g'|awk '{sub(/.$/,"")}1'`
DISK_NUM=`$FDISK -l 2>/dev/null |grep "Disk"|grep bytes|grep -v "VolGroup"|grep -v "mapper"|grep -v "md0"|wc -l`
MEM_SIZE=`$FREE -m|grep Mem|awk '{if ($2<1024) print substr($2,1,3)"M";else if ($2<10240 && $2>1024) print substr($2/1024,1,3)"G";else print substr($2/1024,1,4)"G"}'`
GPU=`lspci | grep -i nvidia|grep VGA|awk -F ':' '{print $3}' |tr '\n' ','|awk '{sub(/.$/,"")}1'`
GPU_NUM=`lspci | grep -i nvidia|grep VGA|wc -l`
IP=`hostname -I`

#echo  Cpu_Model:$CPU_MODEL
#echo  Disk:$DISK_SIZE
#echo  Memory:$MEM_SIZE
#echo  GPU:$GPU

echo -e $IP"\n"$CPU_MODEL"\n"$MEM_SIZE"\n"$DISK_SIZE"\n"$DISK_NUM"\n"$GPU"\n"$GPU_NUM
