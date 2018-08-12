#/bin/bash
source /etc/profile 


#启动的时，默认配置或证书



sh /opt/scripts/default_config.sh 
sh /opt/scripts/default_keyFile.sh



#启动服务
mongod --config /opt/mongo/conf/mongo.conf --bind_ip_all