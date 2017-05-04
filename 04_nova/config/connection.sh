#!/usr/bin/env bash

if [ -z $PORT_DB_NOVAAPI ]; then
  PORT_DB_NOVAAPI=3393
fi
if [ -z $PORT_DB_NOVA ]; then
  PORT_DB_NOVA=3394
fi

# apt install -y vim
# cp /etc/nova/nova.conf /etc/nova/nova.conf.bak

nova_conf_file='/etc/nova/nova.conf'

# [api_database]
connection_novaapi="mysql+pymysql://"
connection_novaapi+="nova:${OS_PASSWORD}"
connection_novaapi+="@"
connection_novaapi+="${HOST_DB_NOVAAPI}:${PORT_DB_NOVAAPI}"
connection_novaapi+="/nova_api"
line_apidb="connection = ${connection_novaapi}"

# [database]
connection_nova="mysql+pymysql://"
connection_nova+="nova:${OS_PASSWORD}"
connection_nova+="@"
connection_nova+="${HOST_DB_NOVA}:${PORT_DB_NOVA}"
connection_nova+="/nova"
line_db="connection = ${connection_nova}"

# [DEFAULT] TODO
transport_url="rabbit://openstack:${OS_PASSWORD}@${HOST_MQ}"
line_df="transport_url = ${transport_url}"

# [api]
auth_strategy='keystone'
line_api="auth_strategy = ${auth_strategy}"

# [keystone_authtoken]
auth_uri="auth_uri = http://${HOST_KEYSTONE}:5000\n"
auth_uri+="auth_uri = http://${HOST_KEYSTONE}:35357"
memcached_servers="${HOST_MC_GLANCE}:11211"
auth_type_nova="auth_type = password\n"
auth_type_nova+="project_domain_name = default\n"
auth_type_nova+="user_domain_name = default\n"
auth_type_nova+="project_name = service\n"
auth_type_nova+="username = nova\n"
auth_type_nova+="password = ${OS_PASSWORD}"
line_ka="${auth_uri}\n"
line_ka+="memcached_servers = ${memcached_servers}\n"
line_ka+="${auth_type_nova}"

# [glance]
api_servers="http://${HOST_GLANCE}:9292"
line_glance="api_servers = ${api_servers}"

# [oslo_concurrency]
lock_path="/var/lib/nova/tmp"
line_oc="lock_path = ${lock_path}"

# [placement]
auth_type_placement="os_region_name = RegionOne\n"
auth_type_placement+="auth_type = password\n"
auth_type_placement+="project_domain_name = Default\n"
auth_type_placement+="user_domain_name = Default\n"
auth_type_placement+="project_name = service\n"
auth_type_placement+="username = placement\n"
auth_type_placement+="password = ${OS_PASSWORD}\n"
auth_type_placement+="auth_url = http://${HOST_KEYSTONE}:35357/v3"
line_placement=${auth_type_placement}

sed -i \
  -e "/^\[api_database\]*/a${line_apidb}" \
  -e "/^\[database\]*/a${line_db}" \
  -e "/^\[DEFAULT\]*/a${line_df}" \
  -e "/^\[api\]*/a${line_api}" \
  -e "/^\[keystone_authtoken\]*/a${line_ka}" \
  -e "/^\[glance\]*/a${line_glance}" \
  -e "/^\[oslo_concurrency\]*/a${line_oc}" \
  -e "/^\[placement\]*/a${line_placement}" \
  -e "/^connection=sqlite:\/\/\/\/var\/lib\/nova\/nova.sqlite/d" \
  -e "/^lock_path=\/var\/lock\/nova/d" \
  -e "/^os_region_name = openstack/d" \
  ${nova_conf_file}

# grep "^[^#]" /etc/nova/nova.conf | less
# cp /etc/nova/nova.conf.bak /etc/nova/nova.conf
# ./connection.sh
# vi /etc/nova/nova.conf
