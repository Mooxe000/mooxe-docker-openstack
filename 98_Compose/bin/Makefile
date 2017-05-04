#
ifndef PW
	PW := netserver
endif

data_create:
	cd ../../02_keystone && make db_create
	cd ../../03_glance && make db_create
	cd ../../03_glance && make mc_create
	cd ../../04_nova && make db_create

data_remove:
	cd ../../02_keystone && make db_remove
	cd ../../03_glance && make db_remove
	cd ../../03_glance && make mc_remove
	cd ../../04_nova && make db_remove

db_create:
	docker run --name=osdb \
		-d \
		-e MYSQL_ROOT_PASSWORD=${PW} \
		-p 3306:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

check_db_init:
# DB_HOST
ifndef DB_HOST
	$(error DB_HOST is undefined)
endif
# DB_PORT
ifndef DB_PORT
DB_PORT=3306
endif
# DB_PW
ifndef DB_PW
	$(error DB_PW is undefined)
endif

db_init: check_db_init
	docker run --rm -ti --name=osdbinit \
		-e DB_HOST=${DB_HOST} \
		-e DB_PORT=${DB_PORT} \
		-e DB_PW=${DB_PW} \
		-v $$(pwd)/schema.sh:/data/schema.sh \
		mariadb /usr/bin/env bash -c " \
			cd /data/ && ./schema.sh && \
			mysql \
				-h${DB_HOST} \
				-P${DB_PORT} \
				-uroot \
				-p${DB_PW} \
				--protocol=tcp \
				< /data/schema.sql"
