#!/bin/bash

if [ -n $MongoInitRootUserName ]; then
cat <<EOF > $ScriptPath/initRootUser.js
db.createUser({
	user:'$MongoInitRootUserName',
	pwd:'$MongoInitRootPassWord',
	roles:[{
		'role':'root',
		'db':'admin'
	}]
})
EOF
fi





rm -rf $0
