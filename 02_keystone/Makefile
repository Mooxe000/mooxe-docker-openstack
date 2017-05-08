#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_DB_KEYSTONE=$$HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
endif

build:
	docker build -t mooxe/openstack/keystone .

rebuild:
	docker build --no-cache -t mooxe/openstack/keystone .

in:
	docker run -ti mooxe/openstack/keystone /usr/bin/env fish

db_create:
	docker run --name=osdbkeystone \
		-d \
		-e MYSQL_ROOT_PASSWORD=${PW} \
		-e MYSQL_DATABASE=keystone \
		-e MYSQL_USER=keystone \
		-e MYSQL_PASSWORD=${PW} \
		-p 3396:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

db_remove:
	docker rm -f osdbkeystone

db_in:
	docker exec -ti osdbkeystone /bin/bash

db_logs:
	docker logs -f osdbkeystone

check_keystone:
# HOST_DB_KEYSTONE
ifndef HOST_DB_KEYSTONE
	$(error HOST_DB_KEYSTONE is undefined)
endif
# HOST_KEYSTONE
ifndef HOST_KEYSTONE
	$(error HOST_KEYSTONE is undefined)
endif

# -e PORT_DB_KEYSTONE=3306 \

keystone: check_keystone
	docker run --rm -ti \
		-e HOST_DB_KEYSTONE=${HOST_DB_KEYSTONE} \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL=http://${HOST_KEYSTONE}:35357/v3 \
		-e PORT_DB_KEYSTONE=3306 \
		-e compute1_ip=${compute1_ip} \
		-v $$(pwd)/config:/root/keystone/config \
		-p 35357:35357 -p 5000:5000 \
		mooxe/openstack/keystone /usr/bin/env \
		bash -c "source /root/keystone/config/connection.sh && fish"
