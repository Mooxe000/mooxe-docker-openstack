#
ifndef PW
	PW := netserver
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
# HOST_DB_KeyStone
ifndef HOST_DB_KeyStone
	$(error HOST_DB_KeyStone is undefined)
endif
# HOST_KeyStone
ifndef HOST_KeyStone
	$(error HOST_KeyStone is undefined)
endif

keystone: check_keystone
	docker run --rm -ti \
		-e HOST_DB_KeyStone=${HOST_DB_KeyStone} \
		-e HOST_KeyStone=${HOST_KeyStone} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL=http://${HOST_KeyStone}:35357/v3 \
		-v $$(pwd)/config:/root/keystone \
		-p 35357:35357 -p 5000:5000 \
		mooxe/openstack/keystone /usr/bin/env \
		bash -c "source /root/keystone/connection.sh && fish"
