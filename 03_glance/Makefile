#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_DB_GLANCE=$$HOST_ALL
	HOST_MC_GLANCE=$$HOST_ALL
	compute1_ip=$$HOST_ALL
endif

imgName := mooxe/openstack/glance

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
# compute1_ip
ifndef compute1_ip
	$(error compute1_ip is undefined)
endif

# -e PORT_DB_GLANCE=3306 \

glance:
	docker run --rm -ti \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_DB_GLANCE=${HOST_DB_GLANCE} \
		-e PORT_DB_GLANCE=3306 \
		-e HOST_MC_GLANCE=${HOST_MC_GLANCE} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL="http://${HOST_KEYSTONE}:35357/v3" \
		-e compute1_ip=${compute1_ip} \
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
