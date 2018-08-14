# docker_mongo
- Fast
- Simple
- ReplSet
- Transaction
- Auth

## build
- docker build -t mongodb ./ 

## simple 
docker run -d lianshufeng/mongodb

## keyfile
- openssl rand -base64 256 -out /opt/mongo/key/keyfile
- -v /opt/mongo/key/keyfilei:/opt/mongo/key/keyfile

## ENV 
### MongoReplSet 
- MongoSets
### ReplSetInitiate
- mongo1:27017,mongo2:27017,mongo3:27017
### ReplSetArbiter
- mongo4:27017
### MongoInitRootUserName
- admin
### MongoInitRootPassWord
- 687mongo2018
### MongoDbpath
- /opt/mongo/store/data
### MongoLogpath
- /opt/mongo/store/logs/mongo.log

## eg
- docker run --name mongo --privileged=true -p 27017:27017 -v /opt/mongo/store/mongo:/opt/mongo/store -v /etc/localtime:/etc/localtime:ro -e ReplSetInitiate="192.168.145.129:27017,192.168.145.129:27018" -e ReplSetArbiter="192.168.145.129:27019" e MongoInitRootUserName="admin" -e MongoInitRootPassWord="687mongo2018" -d mongodb 


## init db
### Enter any data docker container
- docker  exec -it mongo /bin/bash
### shell
- sh init_mongodb.sh


## client login
- mongo --host testrs/192.168.145.129:27017,192.168.145.129:27018,192.168.145.129:27019 admin -u admin -p 687mongo2018

