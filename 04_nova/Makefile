
#
ifndef PW
	PW := netserver
endif

build:
	docker build -t mooxe/openstack/nova .

rebuild:
	docker build --no-cache -t mooxe/openstack/nova .

in:
	docker run -ti mooxe/openstack/nova /usr/bin/env fish

nova:
	docker run --rm -ti \
		-p 8774:8774 \
		-v $$(pwd)/config:/root/nova/config \
		mooxe/openstack/nova /usr/bin/env \
		bash -c "source /root/nova/config/connection.sh && fish"

db_create:
	docker run --name=osdbnova \
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

db_remove:
	@for svname in osdbnovaapi osdbnova osdbnovacell0; do \
		docker rm -f $$svname; \
	done

db_logs_novaapi:
	docker logs -f osdbnovaapi

db_logs_nova:
	docker logs -f osdbnova

db_logs_novacell0:
	docker logs -f osdbnovacell0
