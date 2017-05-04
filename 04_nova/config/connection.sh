#!/usr/bin/env bash

if [ -z $PORT_DB_GLANCE ]; then
  PORT_DB_GLANCE=3397
fi

apt install -y vim
cp /etc/nova/nova.conf /etc/nova/nova.conf.bak

sed -i \
  -e "/^connection = */cconnection = mysql+pymysql://nova:${OS_PASSWORD}@${HOST_DB_NOVAAPI}:${PORT_DB_NOVAAPI}/nova_api" \
  -e "/^#connection=*/cconnection = mysql+pymysql://nova:${OS_PASSWORD}@${HOST_DB_NOVAAPI}:${PORT_DB_NOVAAPI}/nova_api" \
  /etc/nova/nova.conf
