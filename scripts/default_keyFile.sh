#/bin/bash

mkdir -p /opt/mongo/key/

file=/opt/mongo/key/keyfile
if [ ! -f $file ]; then

cat <<EOF > $file
PNVLr0SXtL9dzaX1eLA/1CiKO8EVA75TlQVQpbPhhnV428iX8UrzaE1V38ZVW4rK
pkYSMkvftaIqRf3ctvb+Slvw2CIHaI5AyKaDdJui+hIZ0C/zhH15biYva7e9pz3Y
nBwchS5k8Hd1QrJ9tCXhjKgDvCQGO8MgyOWBxkzq7NAZrU8x42kmVRkLCwUwbXlB
XvElKJtuC3ooCwrWQkGdW/ISKLJhK7cVFgIMUOdomXIFDPGj1JTgqQbv9FXFZaV8
1pm5WuCaS32+6N51ewPLGtQP0K++ZLCOfMjZ2H00RNF7CBsUsk7G28OQWWbDUQU6
yi+ClmUGkbWBjgmE2u9xqQ==
EOF

fi



chmod 600 /opt/mongo/key/keyfile
chown 999 /opt/mongo/key/keyfile



echo "" > $0
