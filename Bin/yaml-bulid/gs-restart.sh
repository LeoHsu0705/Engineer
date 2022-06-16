#!/bin/bash

file=gs-setting.txt
num=`cat gs-setting.txt|grep -v "#"|wc -l`

for (( i=1;i<=$num;i++ ))
	do
	dp=`cat $file |grep -v "#"|head -$i|tail -1|cut -d ',' -f1`
        id=gs-$dp
        kubectl rollout restart deployment/$id -n rcg
	done
