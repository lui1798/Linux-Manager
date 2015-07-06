#!/bin/bash

	ethtool wlan0 | grep "Link detected: yes" > /dev/null #判断是否是无线网

	if [ $? -eq 0 ]  #判断网卡
	then
		eth=wlan0
	else
		eth=eth0
   	 fi
       #求出一秒前后流量的差值,作为这一秒的上传网速, 从/proc/net/dev文件中
	TXpre=$(cat /proc/net/dev | grep $eth | tr : " " | awk '{print $10}')
	sleep 1
	TXnext=$(cat /proc/net/dev | grep $eth | tr : " " | awk '{print $10}')
	TX=$((${TXnext}-${TXpre}))
	  #流量单位转换	 
	if [[ $TX -lt 1024 ]];then
	TX="${TX}B/s"
	elif [[ $TX -gt 1048576 ]];then
	TX=$(echo $TX | awk '{print $1/1048576 "MB/s"}')
	else
	TX=$(echo $TX | awk '{print $1/1024 "KB/s"}')
	fi
          #输出下载速度
	echo -e "$TX"     


