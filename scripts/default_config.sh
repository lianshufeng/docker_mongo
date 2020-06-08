#!/bin/bash

mkdir -p $MongoDbpath
mkdir -p ${MongoConfigFile%/*}
mkdir -p ${MongoLogpath%/*}
mkdir -p ${MongoKeyFile%/*}




if [ ! -f $MongoConfigFile ]; then

cat <<EOF > $MongoConfigFile
net:
   bindIpAll: true
   port: 27017
storage:
   dbPath: $MongoDbpath
   directoryPerDB: true
   journal:
      enabled: true
systemLog:
   destination: file
   path: "$MongoLogpath"
   logAppend: true
security:
   keyFile: $MongoKeyFile
   authorization: enabled
replication:
   oplogSizeMB: 300
   replSetName: $MongoReplSet
EOF

fi





rm -rf $0