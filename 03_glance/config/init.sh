#!/usr/bin/env bash

# init DB
glance-manage db_sync

# restart service
service glance-registry restart
service glance-api restart
