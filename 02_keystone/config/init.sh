#!/usr/bin/env bash

# init DB
keystone-manage db_sync

# init fernet
keystone-manage fernet_setup \
  --keystone-user keystone \
  --keystone-group keystone
keystone-manage credential_setup \
  --keystone-user keystone \
  --keystone-group keystone

# bootstrap
keystone-manage bootstrap \
  --bootstrap-password ${OS_PASSWORD} \
  --bootstrap-admin-url http://${HOST_KEYSTONE}:35357/v3/ \
  --bootstrap-internal-url http://${HOST_KEYSTONE}:5000/v3/ \
  --bootstrap-public-url http://${HOST_KEYSTONE}:5000/v3/ \
  --bootstrap-region-id RegionOne

# init apache2
echo "ServerName ${HOST_KEYSTONE}" >> /etc/apache2/apache2.conf
service apache2 restart
rm -f /var/lib/keystone/keystone.db
