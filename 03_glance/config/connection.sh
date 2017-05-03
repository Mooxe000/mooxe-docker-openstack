#!/usr/bin/env bash

if [ -z $PORT_DB_GLANCE ]; then
  PORT_DB_GLANCE=3397
fi

connection="mysql+pymysql:\/\/glance:${OS_PASSWORD}@${HOST_DB_GLANCE}:${PORT_DB_GLANCE}\/glance"
auth_uri="auth_uri = http://${HOST_KEYSTONE}:5000"
auth_uri+="\nauth_uri = http://${HOST_KEYSTONE}:35357"
memcached_servers="${HOST_MC_GLANCE}:11211"
auth_type="auth_type = password"
auth_type+="\nproject_domain_name = default"
auth_type+="\nuser_domain_name = default"
auth_type+="\nproject_name = service"
auth_type+="\nusername = glance"
auth_type+="\npassword = ${OS_PASSWORD}"

for confname in api registry; do
  sed -i \
    -e "/^#connection = */cconnection = ${connection}" \
    -e "/^#auth_uri = */a${auth_uri}" \
    -e "/^#auth_uri = */d" \
    -e "/^#memcached_servers = */cmemcached_servers = ${memcached_servers}"\
    -e "/^#auth_type = */c${auth_type}" \
    -e "/^#service_token_roles_required = */cservice_token_roles_required = true" \
    -e "/^#flavor = */cflavor = keystone" \
    /etc/glance/glance-${confname}.conf
  sed -i \
    -e "/^\[filter:authtoken\]$/aauth_url = http://${HOST_KEYSTONE}:35357" \
    /etc/glance/glance-${confname}-paste.ini
done

sed -i \
  -e "/^#stores = */cstores = file,http" \
  -e "/^#default_store = */cdefault_store = file" \
  -e "/^#filesystem_store_datadir = */cfilesystem_store_datadir = /data/glance/images" \
  /etc/glance/glance-api.conf

mkdir -p /data/glance/images
chown -R glance:glance /data/glance
ln -s /data/glance/images /root/glance/images
# cat /etc/glance/glance-api.conf | grep "^[^#]" | less
# cat /etc/glance/glance-registry.conf | grep "^[^#]" | less
