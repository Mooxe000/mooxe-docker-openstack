#!/usr/bin/env bash

PW=netserver

schemaSQL=""

for db in \
  keystone,keystone \
  glance,glance \
  nova_api,nova \
  nova,nova \
  nova_cell0,nova \
; do
  dbname=${db%,*}
  dbuser=${db#*,}
  schemaSQL+="CREATE DATABASE ${dbname};\n\n"
  for host in localhost %; do
    schemaSQL+="GRANT ALL PRIVILEGES ON ${dbname}.* TO "
    schemaSQL+="'${dbuser}'@'${host}' IDENTIFIED BY '${PW}';\n\n"
  done
done

echo -e $schemaSQL > schema.sql
