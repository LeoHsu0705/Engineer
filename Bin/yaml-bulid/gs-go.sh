#!/bin/bash

file=gs-setting.txt
num=`cat gs-setting.txt|grep -v "#"|wc -l`

for (( i=1;i<=$num;i++ ))
        do
                deskCode=`cat $file |grep -v "#" |head -$i|tail -1|cut -d ',' -f1`
                key=`cat $file |grep -v "#"|head -$i|tail -1|cut -d ',' -f2`
                image=DEV20211008
                id="gs-$deskCode"
                cp -f gs-deploy.yaml ../../deployment/gs/$id-deploy.yaml
                sed -i '' "s/tmp-deploy/$id/g"  ../../deployment/gs/$id-deploy.yaml
                sed -i '' "s/tmp-guid/$key/g"  ../../deployment/gs/$id-deploy.yaml
                sed -i '' "s/tmp-image/$image/g"  ../../deployment/gs/$id-deploy.yaml
                sed -i '' "s/tmp-deskcode/$deskCode/g"  ../../deployment/gs/$id-deploy.yaml
        done
