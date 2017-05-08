#!/usr/bin/env bash

nova_conf_file='/etc/nova/nova.conf'
nova_compute_conf_file='/etc/nova/nova-compute.conf'

# [DEFAULT]
transport_url="rabbit://openstack:${OS_PASSWORD}@${HOST_KEYSTONE}"
my_ip="${compute1_ip}"
use_neutron="True"
firewall_driver="nova.virt.firewall.NoopFirewallDriver"

line_default="transport_url = ${transport_url}\n"
line_default+="my_ip = ${my_ip}\n"
line_default+="use_neutron = ${use_neutron}\n"
line_default+="firewall_driver = ${firewall_driver}\n"

# [api]
auth_strategy="keystone"

line_api="auth_strategy = ${auth_strategy}\n"

# [keystone_authtoken]
auth_uri="http://${HOST_KEYSTONE}:5000"
auth_url="http://${HOST_KEYSTONE}:35357"
memcached_servers="${HOST_KEYSTONE}:11211"
auth_type="password"
project_domain_name="default"
user_domain_name="default"
project_name="service"
username="nova"
password=${OS_PASSWORD}

line_ka="auth_uri = ${auth_uri}\n"
line_ka+="auth_url = ${auth_url}\n"
line_ka+="memcached_servers = ${memcached_servers}\n"
line_ka+="auth_type = ${auth_type}\n"
line_ka+="project_domain_name = ${project_domain_name}\n"
line_ka+="user_domain_name = ${user_domain_name}\n"
line_ka+="project_name = ${project_name}\n"
line_ka+="username = ${username}\n"
line_ka+="password = ${password}\n"

# [vnc]
enabled="true"
vncserver_listen="\$my_ip"
vncserver_proxyclient_address="\$my_ip"

line_vnc="enabled = ${enabled}\n"
line_vnc+="vncserver_listen = ${vncserver_listen}\n"
line_vnc+="vncserver_proxyclient_address = ${vncserver_proxyclient_address}\n"

# [glance]
api_servers="http://${HOST_GLANCE}:9292"

line_glance="api_servers = ${api_servers}\n"

# [oslo_concurrency]
lock_path="/var/lib/nova/tmp"

line_oc="lock_path = ${lock_path}\n"

# [placement]
os_region_name="RegionOne"
project_domain_name="Default"
project_name="service"
auth_type="password"
user_domain_name="Default"
auth_url="http://${HOST_KEYSTONE}:35357/v3"
username="placement"
password=${OS_PASSWORD}

line_placement="os_region_name = ${os_region_name}\n"
line_placement+="project_domain_name = ${project_domain_name}\n"
line_placement+="project_name = ${project_name}\n"
line_placement+="auth_type = ${auth_type}\n"
line_placement+="user_domain_name = ${user_domain_name}\n"
line_placement+="auth_url = ${auth_url}\n"
line_placement+="username = ${username}\n"
line_placement+="password = ${password}"

sed -i \
  -e "/^\[DEFAULT\]*/a${line_default}" \
  -e "/^\[api\]*/a${line_api}" \
  -e "/^\[keystone_authtoken\]*/a${line_ka}" \
  -e "/^\[vnc\]*/a${line_vnc}" \
  -e "/^\[glance\]*/a${line_glance}" \
  -e "/^\[oslo_concurrency\]*/a${line_oc}" \
  -e "/^\[placement\]*/a${line_placement}" \
  -e "/lock_path=\/var\/lock\/nova/d" \
  ${nova_conf_file}

sed -i \
  -e "/virt_type=kvm/cvirt_type=qemu" \
  ${nova_compute_conf_file}
