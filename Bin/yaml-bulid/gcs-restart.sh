#!/bin/bash

file=gcs-setting.txt
num=`cat gcs-setting.txt|grep -v "#"|wc -l`

for (( i=1;i<=$num;i++ ))
	do
	dp=`cat $file |grep -v "#"|head -$i|tail -1|cut -d ',' -f1`
        id=$dp
        kubectl rollout restart deployment/$id -n rcg
	done
