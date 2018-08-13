#!/bin/bash


#副本集群
members=""
CLUSTER_HOST=${ReplSetInitiate//,/ }
i=0
for host in ${CLUSTER_HOST[@]}
do
	item="{_id:$i,host:'$host'}"
	members=$members$item","
	let i=$i+1
done


#仲裁服务器
CLUSTER_HOST=${ReplSetArbiter//,/ }
for host in ${CLUSTER_HOST[@]}
do
	item="{_id:$i,host:'$host',arbiterOnly:true}"
	members=$members$item","
	let i=$i+1
done

#去掉多余的,
members=${members%,*}



if [ -n $members ]; then
cat <<EOF > $ScriptPath/replSetInitiate.js
//切换admin库
db = db.getSiblingDB('admin');
//配置集群
cfg={_id:"$MongoReplSet", members:[$members]}; 
//初始化
rs.initiate(cfg);
EOF
fi


rm -rf $0
