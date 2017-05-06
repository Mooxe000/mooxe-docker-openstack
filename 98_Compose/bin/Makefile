#
ifndef PW
	PW := netserver
endif

db_create:
	./schema.sh && \
	docker run --name=osdb \
		-d \
		-e MYSQL_ROOT_PASSWORD=${PW} \
		-v $$(pwd)/schema.sql:/data/schema.sql \
		-p 3306:3306 \
		mariadb \
			--character-set-server=utf8 \
			--collation-server=utf8_general_ci \
			--default-storage-engine=innodb \
			--innodb_file_per_table=on \
			--max_connections=4096

db_remove:
	docker rm -f osdb

db_logs:
	docker logs -f osdb

db_init:
	docker exec -ti \
		osdb bash -c " \
			mysql -v \
				-hlocalhost \
				-p${PW} \
				< /data/schema.sql"

mc_create:
	docker run --name osmc \
		-d \
		-p 11211:11211 \
		memcached

mc_remove:
	docker rm -f osmc

mc_logs:
	docker logs -f osmc

mq_create:
	docker run --name osmq \
		-e RABBITMQ_DEFAULT_USER=openstack \
		-e RABBITMQ_DEFAULT_PASS=${PW} \
		-d \
		-p 5672:5672 \
		rabbitmq

mq_remove:
	docker rm -f osmq

mq_logs:
	docker logs -f osmq

# db_create mc_create mq_create
service_create: mc_create mq_create
	cd ../../02_keystone && make db_create
	cd ../../03_glance && make db_create
	cd ../../04_nova && make db_create_novaapi
	cd ../../04_nova && make db_create_nova
	cd ../../04_nova && make db_create_novacell0

# db_remove mc_remove mq_remove
service_remove:
	@for sn in $$(docker ps -a | grep '[osdb|osmc|osmq]' | awk '{print $$1}'); do \
		docker rm -f $$sn; \
	done

service_aio_create: db_create mc_create mq_create
service_aio_remove: db_remove mc_remove mq_remove
