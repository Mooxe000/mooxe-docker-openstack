#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_DB_GLANCE=$$HOST_ALL
	HOST_MC_GLANCE=$$HOST_ALL
endif

build:
	docker build -t mooxe/openstack/glance .

rebuild:
	docker build --no-cache -t mooxe/openstack/glance .

in:
	docker run -ti mooxe/openstack/glance /usr/bin/env fish

check_glance:
# HOST_KEYSTONE
ifndef HOST_KEYSTONE
	$(error HOST_KEYSTONE is undefined)
endif
# HOST_DB_GLANCE
ifndef HOST_DB_GLANCE
	$(error HOST_DB_GLANCE is undefined)
endif
# HOST_MC_GLANCE
ifndef HOST_MC_GLANCE
	$(error HOST_MC_GLANCE is undefined)
endif

# -e PORT_DB_GLANCE=3306 \

glance:
	docker run --rm -ti \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_DB_GLANCE=${HOST_DB_GLANCE} \
		-e HOST_MC_GLANCE=${HOST_MC_GLANCE} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL="http://${HOST_KEYSTONE}:35357/v3" \
		-e compute1_ip=${compute1_ip} \
		-e PORT_DB_GLANCE=3306 \
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
