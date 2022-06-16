#!/bin/bash

# 使用方式 sh gs-restart-batch.sh $1 $2...
# 範例 sh gs-restart-batch.sh gs-gc001010 gs-gc011004

listArr=("$@")

file=gs-setting.txt
num=`cat gs-setting.txt|grep -v "#"|wc -l`
k=0

for (( i=1;i<=$num;i++ )); do
	dp=`cat $file |grep -v "#"|head -$i|tail -1|cut -d ',' -f1`
	id=gs-$dp
	for j in "${listArr[@]}"; do
		if [ "$id" = "$j" ]; then
			((k=k+1))
			echo "$k. $id is match"
			kubectl rollout restart deployment/$id -n rcg
		fi
	done
done

echo "Total: $k"