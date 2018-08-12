# mongo replicaset
#
# build	: docker build -t mongodb ./ 
# run	: 
#
#
# docker run -d mongodb -p 27017:27017 
#


FROM mongo:latest
MAINTAINER lianshufeng <251708339@qq.com>


	
#生成默认的配置文件
ADD scripts/default_config.sh /opt/scripts/default_config.sh
ADD scripts/default_keyFile.sh /opt/scripts/default_keyFile.sh
ADD scripts/bootstrap.sh /opt/bootstrap.sh





ENTRYPOINT  sh /opt/bootstrap.sh 
