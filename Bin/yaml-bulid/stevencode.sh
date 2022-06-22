#!/bin/bash

file=stevencode-setting.txt
num=`cat stevencode-setting.txt|grep -v "#"|wc -l`
game=gcs

for (( i=1;i<=$num;i++ ))
        do
                StevenCode=`cat $file |grep -v "#" |head -$i|tail -1|cut -d ',' -f1`
                image=DEV20220621
                id="$game-$StevenCode"
                cp -f $game-deploy.yaml ../../deployment/$game/$id-deploy.yaml
                sed -i '' "s/tmp-deploy/$id/g"  ../../deployment/$game/$id-deploy.yaml
                sed -i '' "s/tmp-image/$image/g"  ../../deployment/$game/$id-deploy.yaml
                sed -i '' "s/tmp-stevencode/$StevenCode/g"  ../../deployment/$game/$id-deploy.yaml
        done
