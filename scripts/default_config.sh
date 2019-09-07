#!/bin/bash

mkdir -p $MongoDbpath
mkdir -p ${MongoConfigFile%/*}
mkdir -p ${MongoLogpath%/*}
mkdir -p ${MongoKeyFile%/*}




if [ ! -f $MongoConfigFile ]; then

cat <<EOF > $MongoConfigFile
dbpath=$MongoDbpath
logpath=$MongoLogpath
keyFile=$MongoKeyFile
directoryperdb=true
logappend=true
replSet=$MongoReplSet
port=27017
auth=true
oplogSize=300
bind_ip_all=true
EOF

fi





rm -rf $0