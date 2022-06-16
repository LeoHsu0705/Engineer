#!/bin/bash

file=gcs-setting.txt
num=`cat gcs-setting.txt|grep -v "#"|wc -l`

for (( i=1;i<=$num;i++ ))
	do
	id=`cat $file |grep -v "#"|head -$i|tail -1|cut -d ',' -f1`
        key=`cat $file |grep -v "#"|head -$i|tail -1|cut -d ',' -f2`
        image=DEV
        cp -f gcs-deploy.yaml ../../deployment/gcs/$id-deploy.yaml
        sed -i '' "s/tmp-deploy/$id/g"  ../../deployment/gcs/$id-deploy.yaml
        sed -i '' "s/tmp-guid/$key/g"  ../../deployment/gcs/$id-deploy.yaml
        sed -i '' "s/tmp-image/$image/g"  ../../deployment/gcs/$id-deploy.yaml
	done
