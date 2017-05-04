
#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
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
		-e HOST_MC_GLANCE=${HOST_MC_GLANCE} \
		-e HOST_MQ=${HOST_MQ} \
		-e HOST_DB_NOVAAPI=${HOST_DB_NOVAAPI} \
		-e PORT_DB_NOVAAPI=3306 \
		-e HOST_DB_NOVA=${HOST_DB_NOVA} \
		-e PORT_DB_NOVA=3306 \
		-e OS_PASSWORD=${PW} \
		-p 8774:8774 \
		-v $$(pwd)/config:/root/nova/config \
		mooxe/openstack/nova /usr/bin/env \
		bash -c "source /root/nova/config/connection.sh && fish"
