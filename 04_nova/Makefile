
#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_GLANCE=$$HOST_ALL
	HOST_MC_GLANCE=$$HOST_ALL
	HOST_MQ=$$HOST_ALL
	HOST_DB_NOVAAPI=$$HOST_ALL
	HOST_DB_NOVA=$$HOST_ALL
endif

build:
	docker build -t mooxe/openstack/nova .

rebuild:
	docker build --no-cache -t mooxe/openstack/nova .

in:
	docker run -ti mooxe/openstack/nova /usr/bin/env fish

db_create_novaapi:
	docker run --name=osdbnovaapi \
		-d \
		-e MYSQL_ROOT_PASSWORD=${PW} \
		-e MYSQL_DATABASE=nova_api \
		-e MYSQL_USER=nova \
		-e MYSQL_PASSWORD=${PW} \
		-p 3393:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

db_remove_novaapi:
	docker rm -f osdbnovaapi

db_logs_novaapi:
	docker logs -f osdbnovaapi

db_create_nova:
	docker run --name=osdbnova \
		-d \
		-e MYSQL_ROOT_PASSWORD=${PW} \
		-e MYSQL_DATABASE=nova \
		-e MYSQL_USER=nova \
		-e MYSQL_PASSWORD=${PW} \
		-p 3394:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

db_remove_nova:
	docker rm -f osdbnova

db_logs_nova:
	docker logs -f osdbnova

db_create_novacell0:
	docker run --name=osdbnovacell0 \
		-d \
		-e MYSQL_ROOT_PASSWORD=${PW} \
		-e MYSQL_DATABASE=nova_cell0 \
		-e MYSQL_USER=nova \
		-e MYSQL_PASSWORD=${PW} \
		-p 3395:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

db_remove_novacell0:
	docker rm -f osdbnovacell0

db_logs_novacell0:
	docker logs -f osdbnovacell0

check_nova:
# HOST_KEYSTONE
ifndef HOST_KEYSTONE
	$(error HOST_KEYSTONE is undefined)
endif
# HOST_MC_GLANCE
ifndef HOST_MC_GLANCE
	$(error HOST_MC_GLANCE is undefined)
endif
# HOST_MQ
ifndef HOST_MQ
	$(error HOST_MQ is undefined)
endif
# HOST_DB_NOVAAPI
ifndef HOST_DB_NOVAAPI
	$(error HOST_DB_NOVAAPI is undefined)
endif
# HOST_DB_NOVA
ifndef HOST_DB_NOVA
	$(error HOST_DB_NOVA is undefined)
endif

nova: check_nova
	docker run --rm -ti \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_GLANCE=${HOST_GLANCE} \
		-e HOST_MC_GLANCE=${HOST_MC_GLANCE} \
		-e HOST_MQ=${HOST_MQ} \
		-e HOST_DB_NOVAAPI=${HOST_DB_NOVAAPI} \
		-e PORT_DB_NOVAAPI=3306 \
		-e HOST_DB_NOVA=${HOST_DB_NOVA} \
		-e PORT_DB_NOVA=3306 \
		-e HOST_DB_NOVACELL0=${HOST_DB_NOVACELL0} \
		-e PORT_DB_NOVACELL0=3306 \
		-e OS_PASSWORD=${PW} \
		-p 8774:8774 \
		-v $$(pwd)/config:/root/nova/config \
		mooxe/openstack/nova /usr/bin/env \
		bash -c "source /root/nova/config/connection.sh && fish"
