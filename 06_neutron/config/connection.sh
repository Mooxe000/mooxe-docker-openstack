#!/usr/bin/env bash

PROVIDER_INTERFACE_NAME=` \
  ip addr | \
  grep eth0 | \
  cut -f 2 -d ":" | \
  sed -n -e "1p" | \
  sed 's/ //g'`

PROVIDER_INTERFACE_NAME=eth0

# echo ${PROVIDER_INTERFACE_NAME}

sed \
  -e "s/\${OS_PASSWORD}/${OS_PASSWORD}/g" \
  -e "s/\${HOST_KEYSTONE}/${HOST_KEYSTONE}/g" \
  -e "s/\${HOST_DB}/${HOST_DB}/g" \
  -e "s/\${HOST_MQ}/${HOST_MQ}/g" \
  -e "s/\${HOST_MC}/${HOST_MC}/g" \
  ./ini/neutron.conf.ini > /etc/neutron/neutron.conf

cat ./ini/ml2_conf.ini \
  > /etc/neutron/plugins/ml2/ml2_conf.ini

sed \
  -e "s/\${PROVIDER_INTERFACE_NAME}/${PROVIDER_INTERFACE_NAME}/g" \
  ./ini/linuxbridge_agent.ini > \
    /etc/neutron/plugins/ml2/linuxbridge_agent.ini

cat ./ini/dhcp_agent.ini \
  > /etc/neutron/dhcp_agent.ini

sed \
  -e "s/\${METADATA_SECRET}/${OS_PASSWORD}/g" \
  ./ini/metadata_agent.ini > /etc/neutron/metadata_agent.ini
