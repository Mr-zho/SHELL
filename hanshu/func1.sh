#!/bin/bash

DISK_CONFIG=/tmp/disk.txt
CHECK_CONFIG=./config.ini

# 磁盘使用率

df | awk '/^\/dev\//{print $1,$5}' | sort | uniq > $DISK_CONFIG



check_enable() {
	enable=0
	while read lines
	do
		enable=$(echo "$lines" | awk '{if($1 == "enable"){print $3}}')
	done < $CHECK_CONFIG
	
	return $enable
}

func() {
	while read lines
	do
		key=$(echo "$lines" | awk '{print $1}')
		value=$(echo "$lines" | awk '{print $2}')
		echo "key:$key"
		echo "value:$value"
	done < $DISK_CONFIG	
}

check_enable
if [ $enable -eq 1 ]
then
	func
fi
