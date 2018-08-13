#/bin/bash





#sudo firewall-cmd --add-port=27017/tcp --permanent 
#sudo firewall-cmd --add-port=27018/tcp --permanent 
#sudo firewall-cmd --add-port=27019/tcp --permanent 
#sudo firewall-cmd --add-port=27020/tcp --permanent 
#sudo firewall-cmd --add-port=27021/tcp --permanent 
#firewall-cmd --reload 

countSize=3



openssl rand -base64 256 -out /opt/mongo/key/keyfile


rm -rf /opt/mongo/store

for((i=0;i<$countSize;i++));
do 
docker rm -f mongo$i
mkdir /opt/mongo/store/mongo$i/data -p ;
mkdir /opt/mongo/store/mongo$i/logs -p ;
done



chmod -R 777 /opt/mongo
for((i=0;i<$countSize;i++));
do 
let port=27017+$i
docker run \
--name mongo$i \
--privileged=true \
-p $port:27017 \
-v /opt/mongo/store/mongo$i:/opt/mongo/store \
-v /etc/localtime:/etc/localtime:ro \
-e ReplSetInitiate="192.168.145.129:27017,192.168.145.129:27018" \
-e ReplSetArbiter="192.168.145.129:27019" \
-e MongoInitRootUserName="admin" \
-e MongoInitRootPassWord="xiaofeng" \
-d mongodb 
#-v /opt/mongo/node_script:/docker-entrypoint-initdb.d \
#


#-v /opt/mongo/key:/opt/mongo/key \
#-v /opt/mongo/conf:/opt/mongo/conf \


#-v /opt/mongo/key:/opt/mongo/key \
#-v /opt/mongo/conf:/opt/mongo/conf \

done







