#!/usr/bin/env bash

if [ -z $PORT_DB_KEYSTONE ]; then
  PORT_DB_KEYSTONE=3396
fi

sed -i \
  -e "/^#connection = */cconnection = mysql+pymysql:\/\/keystone:${OS_PASSWORD}@${HOST_DB_KEYSTONE}:${PORT_DB_KEYSTONE}\/keystone" \
  /etc/keystone/keystone.conf

sed -i "/fernet_rotate\` command/{n;d}" /etc/keystone/keystone.conf
sed -i "/fernet_rotate\` command/aprovider = fernet" /etc/keystone/keystone.conf

echo "${compute1_ip}    compute1" >> /etc/hosts
