
#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_GLANCE=$$HOST_ALL
	HOST_NOVA=$$HOST_ALL
	HOST_NEUTRON=$$HOST_ALL
	HOST_MC=$$HOST_ALL
	HOST_MQ=$$HOST_ALL
	HOST_DB_NOVAAPI=$$HOST_ALL
	HOST_DB_NOVA=$$HOST_ALL
	compute1_ip=$$HOST_ALL
endif

imgName := mooxe/openstack/nova

# env MIRROR_CA="192.168.1.100:8080\\\/cloud-archive" make build
build:
	@cmd="docker build" && \
	if [ ! -z ${MIRROR_CA} ]; then \
		cmd+=" --build-arg MIRROR_CA=$${MIRROR_CA}"; \
	fi && \
	cmd+=" -t ${imgName} ." && \
	bash -c "$${cmd}"

rebuild:
	@cmd="docker build" && \
	cmd+=" --no-cache"; \
	if [ ! -z ${MIRROR_CA} ]; then \
		cmd+=" --build-arg MIRROR_CA=$${MIRROR_CA}"; \
	fi && \
	cmd+=" -t ${imgName} ." && \
	bash -c "$${cmd}"

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
# HOST_MC
ifndef HOST_MC
	$(error HOST_MC is undefined)
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
# compute1_ip
ifndef compute1_ip
	$(error compute1_ip is undefined)
endif

nova: check_nova
	docker run --rm -ti \
		--privileged \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_GLANCE=${HOST_GLANCE} \
		-e HOST_NOVA=${HOST_NOVA} \
		-e HOST_NEUTRON=${HOST_NEUTRON} \
		-e HOST_MC=${HOST_MC} \
		-e HOST_MQ=${HOST_MQ} \
		-e HOST_DB_NOVAAPI=${HOST_DB_NOVAAPI} \
		-e PORT_DB_NOVAAPI=3306 \
		-e HOST_DB_NOVA=${HOST_DB_NOVA} \
		-e PORT_DB_NOVA=3306 \
		-e OS_PASSWORD=${PW} \
		-e compute1_ip=${compute1_ip} \
		-p 8774:8774 \
		-v $$(pwd)/config:/root/nova/config \
		mooxe/openstack/nova /usr/bin/env \
		bash -c "source /root/nova/config/connection.sh && fish"
