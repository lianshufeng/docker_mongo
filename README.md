# docker_mongo
- Fast
- Simple
- ReplSet
- Transaction
- Auth

## build
```shell
docker build -t mongodb ./ 
```

## keyfile
```shell
openssl rand -base64 256 -out /opt/mongo/key/keyfile
```
```shell
-v /opt/mongo/key/keyfilei:/opt/mongo/key/keyfile
```

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
```shell
docker  exec -it mongo /bin/bash
```
### shell
```shell
sh init_mongodb.sh
```



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
  docker run --name mongo$i --privileged=true -p $port:27017 -v /opt/mongo/store/mongo$i:/opt/mongo/store -v /etc/localtime:/etc/localtime:ro -e ReplSetInitiate="$VmHost:27017,$VmHost:27018" -e ReplSetArbiter="$VmHost:27019" -e MongoInitRootUserName="admin" -e MongoInitRootPassWord="687mongo2018" -d lianshufeng/mongodb 
done
```

#### init db
```shell
docker exec -it mongo0 /bin/bash init_mongodb.sh
```


## client login
```shell
docker exec -it mongo0 /bin/bash init_mongodb.sh
VmHost=192.168.145.129
mongo --host MongoSets/$VmHost:27017,$VmHost:27018,$VmHost:27019 admin -u admin -p 687mongo2018
```
