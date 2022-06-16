#!/bin/bash

ns=rcg
deploy_num=`kubectl get deploy -n $ns |grep -v NAME |awk '{ print $1}'|wc -l`


#kubectl config current-context
cat /dev/null > version.txt
for (( i=1;i<=$deploy_num;i++))
do
	deploy_list=`kubectl get deploy -n $ns |grep -v NAME |awk '{ print $1}'|head -$i|tail -1`
	image=`kubectl get deploy $deploy_list -o yaml -n $ns|grep image:|awk '{ print $2}'`
	echo $deploy_list=$image 
	echo $deploy_list=$image >> version.txt
done
