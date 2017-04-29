#

build:
	docker build -t mooxe/openstack/keystone .

rebuild:
	docker build --no-cache -t mooxe/openstack/keystone .

in:
	docker run -ti mooxe/openstack/keystone /usr/bin/env fish

db_create:
	docker run --name=osdb \
		-d \
		-e MYSQL_ROOT_PASSWORD=netserver \
		-e MYSQL_DATABASE=keystone \
		-e MYSQL_USER=keystone \
		-e MYSQL_PASSWORD=netserver \
		-p 3306:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

db_remove:
	docker rm -f osdb

db_in:
	docker exec -ti osdb /bin/bash

db_logs:
	docker logs -f osdb

keystone:
	docker run --rm -ti \
		-e HOST_KeyStone=${HOST_KeyStone} \
		-e OS_PASSWORD=netserver \
		-e OS_AUTH_URL=http://${HOST_KeyStone}:35357/v3 \
		-p 35357:35357 -p 5000:5000 \
		mooxe/openstack/keystone /usr/bin/env \
		bash -c "source /root/keystone/connection.sh && fish"
