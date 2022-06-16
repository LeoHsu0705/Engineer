#!/bin/bash

file=gs-setting.txt
num=`cat gs-setting.txt|grep -v "#"|wc -l`

for (( i=1;i<=$num;i++ ))
	do
	gameid=`cat $file |grep -v "#"|head -$i|tail -1|cut -d ',' -f1`
        id="gs-$gameid"
        cp -f gs-svc.yaml ./out/$id-svc.yaml
        sed -i '' "s/tmp-id/$id/g"  ./out/$id-svc.yaml
        sed -i '' "s/tmp-svc/$id-svc/g"  ./out/$id-svc.yaml
	done
