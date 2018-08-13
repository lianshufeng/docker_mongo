#/bin/bash


openssl rand -base64 256 -out /opt/mongo/key/keyfile


rm -rf /opt/mongo/store

for((i=0;i<=3;i++));
do 
docker rm -f mongo$i
mkdir /opt/mongo/store/mongo$i/data -p ;
mkdir /opt/mongo/store/mongo$i/logs -p ;
done



chmod -R 777 /opt/mongo
for((i=0;i<=3;i++));
do 
let port=27017+$i
docker run \
--name mongo$i \
--privileged=true \
-e MongoConfigFile="/opt/mongo/mongo.conf" \
-p $port:27017 \
-v /opt/mongo/store/mongo$i:/opt/mongo/store \
-v /etc/localtime:/etc/localtime:ro \
-d mongodb 
#-v /opt/mongo/node_script:/docker-entrypoint-initdb.d \
#


#-v /opt/mongo/key:/opt/mongo/key \
#-v /opt/mongo/conf:/opt/mongo/conf \


#-v /opt/mongo/key:/opt/mongo/key \
#-v /opt/mongo/conf:/opt/mongo/conf \


done

