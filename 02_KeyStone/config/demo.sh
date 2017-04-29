#!/usr/bin/env bash

apt-get install -y python-openstackclient
openstack project create --domain default --description "Service Project" service
openstack project create --domain default --description "Demo Project" demo
openstack user create --domain default --password netserver demo
openstack role create user
openstack role add --project demo --user demo user
