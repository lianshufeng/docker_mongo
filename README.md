# docker_mongo
- Fast
- Simple
- ReplSet
- Transaction
- Auth

## build
- docker build -t mongodb ./ 

## keyfile
- openssl rand -base64 256 -out /opt/mongo/key/keyfile
- -v /opt/mongo/key/keyfilei:/opt/mongo/key/keyfile

## ENV 
### MongoReplSet 
- MongoSets
### ReplSetInitiate
- 192.168.145.129:27017,192.168.145.129:27018
### ReplSetArbiter
- 192.168.145.129:27019
### MongoInitRootUserName
- admin
### MongoInitRootPassWord
- 687mongo2018
### MongoDbpath
- /opt/mongo/store/data
### MongoLogpath
- /opt/mongo/store/logs/mongo.log



## init db
### Enter any data docker container
- docker  exec -it mongo /bin/bash
### shell
- sh init_mongodb.sh



## simple demo

####  firewall
```shell
sudo firewall-cmd --add-port=27017/tcp --permanent 
sudo firewall-cmd --add-port=27018/tcp --permanent 
sudo firewall-cmd --add-port=27019/tcp --permanent 
firewall-cmd --reload 
```

#### start  mongodb data node
```shell
VmHost=192.168.145.129
for((i=0;i<3;i++));
do 
  docker rm -f mongo$i
  let port=27017+$i
  docker run --name mongo$i --privileged=true -p $port:27017 -v /opt/mongo/store/mongo$i:/opt/mongo/store -v /etc/localtime:/etc/localtime:ro -e ReplSetInitiate"192.168.145.129:27017,192.168.145.129:27018" -e ReplSetArbiter="192.168.145.129:27019" -e MongoInitRootUserName="admin" -e MongoInitRootPassWord="687mongo2018" -d lianshufeng/mongodb 
done
```

#### init db
```shell
docker  exec -it mongo /bin/bash
sh init_mongodb.sh
```


## client login
```shell
mongo --host MongoSets/192.168.145.129:27017,192.168.145.129:27018,192.168.145.129:27019 admin -u admin -p 687mongo2018
```
