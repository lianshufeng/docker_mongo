#!/bin/bash


#仅执行一次
bash $ScriptPath/default_runonce.sh 


#启动服务
mongod --config $MongoConfigFile --setParameter maxTransactionLockRequestTimeoutMillis=3000