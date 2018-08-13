# mongo replicaset
#
# build	: docker build -t mongodb ./ 
# 
# docker run -d mongodb -p 27017:27017 
#


FROM mongo:latest
MAINTAINER lianshufeng <251708339@qq.com>



#脚本存放路径
ENV ScriptPath="/opt/_scripts"
#配置文件
ENV MongoConfigFile="/opt/mongo/conf/mongo.conf"
#内部安全的密钥文件
ENV MongoKeyFile="/opt/mongo/key/keyfile"
#日志路径
ENV MongoLogpath="/opt/mongo/store/logs/mongo.log"
#DB存放位置
ENV MongoDbpath="/opt/mongo/store/data"
#集群名称
ENV MongoReplSet="MongoSets"
#初始化副本 如； mongo1:27017,mongo2:27017,mongo3:27017
ENV ReplSetInitiate=""
#集群的仲裁者ip
ENV ReplSetArbiter=""
#默认的root账号和密码
ENV MongoInitRootUserName=""
ENV MongoInitRootPassWord=""




	
#生成默认的配置文件
ADD scripts/default_config.sh $ScriptPath/default_config.sh
ADD scripts/default_keyFile.sh $ScriptPath/default_keyFile.sh
ADD scripts/default_initRootUser.sh $ScriptPath/default_initRootUser.sh
ADD scripts/default_replSetInitiate.sh $ScriptPath/default_replSetInitiate.sh
ADD scripts/default_runonce.sh $ScriptPath/default_runonce.sh
ADD scripts/default_startMongod.sh $ScriptPath/default_startMongod.sh
#自动启动
ADD scripts/bootstrap.sh /opt/bootstrap.sh




ENTRYPOINT bash /opt/bootstrap.sh 
