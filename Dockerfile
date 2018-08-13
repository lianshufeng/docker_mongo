# mongo replicaset
#
# build	: docker build -t mongodb ./ 
# 
# docker run -d mongodb -p 27017:27017 
#


FROM mongo:latest
MAINTAINER lianshufeng <251708339@qq.com>




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



	
#生成默认的配置文件
ADD scripts/default_config.sh /opt/scripts/default_config.sh
ADD scripts/default_keyFile.sh /opt/scripts/default_keyFile.sh
ADD scripts/bootstrap.sh /opt/bootstrap.sh





ENTRYPOINT  sh /opt/bootstrap.sh 
