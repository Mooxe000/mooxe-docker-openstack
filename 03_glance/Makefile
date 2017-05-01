#
ifndef PW
	PW := netserver
endif

build:
	docker build -t mooxe/openstack/glance .

rebuild:
	docker build --no-cache -t mooxe/openstack/glance .

in:
	docker run -ti mooxe/openstack/glance /usr/bin/env fish

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
