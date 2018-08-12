#/bin/bash

mkdir -p /opt/mongo/conf/


file=/opt/mongo/conf/mongo.conf
if [ ! -f $file ]; then

cat <<EOF > $file
dbpath=/opt/mongo/store/data
logpath=/opt/mongo/store/logs/mongo.log
keyFile=/opt/mongo/key/keyfile
directoryperdb=true
logappend=true
replSet=testrs
port=27017
auth=true
oplogSize=300
EOF

fi


echo "" > $0