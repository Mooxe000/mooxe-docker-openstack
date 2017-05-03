#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_DB_KEYSTONE=$$HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_GLANCE=$$HOST_ALL
	HOST_DB_GLANCE=$$HOST_ALL
	HOST_MC_GLANCE=$$HOST_ALL
endif

build:
	docker build -t mooxe/openstack/glance .

rebuild:
	docker build --no-cache -t mooxe/openstack/glance .

in:
	docker run -ti mooxe/openstack/glance /usr/bin/env fish

glance:
	docker run --rm -ti \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_DB_GLANCE=${HOST_DB_GLANCE} \
		-e HOST_MC_GLANCE=${HOST_MC_GLANCE} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL="http://${HOST_KEYSTONE}:35357/v3" \
		-v $$(pwd)/config:/root/glance/config \
		-p 9292:9292 -p 9191:9191 \
		mooxe/openstack/glance /usr/bin/env \
		bash -c "source /root/glance/config/connection.sh && fish"

db_create:
	docker run --name=osdbglance \
		-d \
		-e MYSQL_ROOT_PASSWORD=${PW} \
		-e MYSQL_DATABASE=glance \
		-e MYSQL_USER=glance \
		-e MYSQL_PASSWORD=${PW} \
		-p 3397:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

db_remove:
	docker rm -f osdbglance

db_logs:
	docker logs -f osdbglance

mc_create:
	docker run --name osmcglance \
	-d \
	-p 11211:11211 \
	memcached

mc_remove:
	docker rm -f osmcglance

mc_logs:
	docker logs -f osmcglance
