#!/bin/bash



##################################副本集群
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

if [ $members != "" ]; then
cat <<EOF > $ScriptPath/replSetInitiate.js
//切换admin库
db = db.getSiblingDB('admin');
//配置集群
cfg={_id:"$MongoReplSet", members:[$members]}; 
//初始化
rs.initiate(cfg);
//退出
quit()
EOF
fi



################################## 数据库创建root账号和密码
if [ $MongoInitRootUserName != "" ]; then
cat <<EOF > $ScriptPath/initRootUser.js
//切换admin库
db = db.getSiblingDB('admin');
//创建root角色的账号和密码 
db.createUser({
	user:'$MongoInitRootUserName',
	pwd:'$MongoInitRootPassWord',
	roles:[{
		'role':'root',
		'db':'admin'
	}]
})
//退出
quit()
EOF
fi





#生成一键初始化数据库的脚本
if [ $MongoInitRootUserName != ""  ] || [ $ReplSetInitiate != "" ] ; then

cat <<EOF > init_mongodb.sh
#!/bin/bash
echo "replSet initiate ."
mongo --shell $ScriptPath/replSetInitiate.js


echo "Add root user"
while [ ! -s /tmp/initRootUser ]  ; do
	echo "Wait..."
	sleep 5
	mongo --shell $ScriptPath/initRootUser.js | grep  "Successfully" > /tmp/initRootUser
done
rm -rf /tmp/initRootUser
echo "Success"



#清理使用过的脚本
rm -rf $ScriptPath/replSetInitiate.js
rm -rf $ScriptPath/initRootUser.js
rm -rf \$0
EOF
fi

rm -rf $0
