#!/usr/bin/env bash

chown -R www-data:www-data /data/mirrors/data
service nginx restart
