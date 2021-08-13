# docker_mongo
- Fast
- Simple
- ReplSet
- Transaction
- Auth


## version
- MongoDB server version: 5.0.2

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
sudo firewall-cmd --add-port=27020/tcp --permanent
firewall-cmd --reload 
```

#### .env
````shell
# host ip
VmHost=192.168.80.128

# store 
store=/opt/mongo/store

# db password
MongoInitRootUserName=admin
MongoInitRootPassWord=687mongo2021
````


#### docker-compose.yml
````shell
version: '3.7'

services:
  mongo1:
    image: lianshufeng/mongodb
    restart: always
    hostname: mongo1
    container_name: mongo1
    volumes:
      - "${store}/mongo1:/opt/mongo/store"
      - "/etc/localtime:/etc/localtime"
      - ./.env:/opt/cmd/.env
      - ./client.sh:/opt/cmd/client.sh
    ports:
      - 27017:27017
    environment:
      ReplSetInitiate: "${VmHost}:27017,${VmHost}:27018,${VmHost}:27019"
      ReplSetArbiter: "${VmHost}:27020"
      MongoInitRootUserName: "${MongoInitRootUserName}"
      MongoInitRootPassWord: "${MongoInitRootPassWord}"
  mongo2:
    image: lianshufeng/mongodb
    restart: always
    hostname: mongo2
    container_name: mongo2
    volumes:
      - "${store}/mongo2:/opt/mongo/store"
      - "/etc/localtime:/etc/localtime"
    ports:
      - 27018:27017
    environment:
      ReplSetInitiate: "${VmHost}:27017,${VmHost}:27018,${VmHost}:27019"
      ReplSetArbiter: "${VmHost}:27020"
      MongoInitRootUserName: "${MongoInitRootUserName}"
      MongoInitRootPassWord: "${MongoInitRootPassWord}"
  mongo3:
    image: lianshufeng/mongodb
    restart: always
    hostname: mongo3
    container_name: mongo3
    volumes:
      - "${store}/mongo3:/opt/mongo/store"
      - "/etc/localtime:/etc/localtime"
    ports:
      - 27019:27017
    environment:
      ReplSetInitiate: "${VmHost}:27017,${VmHost}:27018,${VmHost}:27019"
      ReplSetArbiter: "${VmHost}:27020"
      MongoInitRootUserName: "${MongoInitRootUserName}"
      MongoInitRootPassWord: "${MongoInitRootPassWord}"
  mongo4:
    image: lianshufeng/mongodb
    restart: always
    hostname: mongo4
    container_name: mongo4
    volumes:
      - "${store}/mongo4:/opt/mongo/store"
      - "/etc/localtime:/etc/localtime"
    ports:
      - 27020:27017
    environment:
      ReplSetInitiate: "${VmHost}:27017,${VmHost}:27018,${VmHost}:27019"
      ReplSetArbiter: "${VmHost}:27020"
      MongoInitRootUserName: "${MongoInitRootUserName}"
      MongoInitRootPassWord: "${MongoInitRootPassWord}"


  mongo-express:
    image: mongo-express
    restart: always
    container_name: mongo-express
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_URL: "mongodb://${MongoInitRootUserName}:${MongoInitRootPassWord}@mongo1,mongo2,mongo3,mongo4/admin?replicaSet=MongoSets"
      ME_CONFIG_BASICAUTH_USERNAME: "${MongoInitRootUserName}"
      ME_CONFIG_BASICAUTH_PASSWORD: "${MongoInitRootPassWord}"
      ME_CONFIG_MONGODB_ENABLE_ADMIN: "true"
````



#### init db
```shell
docker exec -it mongo1 /bin/bash init_mongodb.sh
```


## client login
```shell
docker exec -it mongo1 /bin/bash /opt/cmd/client.sh
```
