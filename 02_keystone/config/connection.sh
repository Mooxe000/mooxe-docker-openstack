#!/usr/bin/env bash

sed -i \
  -e "/^#connection = */cconnection = mysql+pymysql:\/\/keystone:${OS_PASSWORD}@${HOST_DB_KEYSTONE}:3396\/keystone" \
  /etc/keystone/keystone.conf

sed -i "/fernet_rotate\` command/{n;d}" /etc/keystone/keystone.conf
sed -i "/fernet_rotate\` command/aprovider = fernet" /etc/keystone/keystone.conf
