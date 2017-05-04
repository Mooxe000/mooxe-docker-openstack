
#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_DB_NOVAAPI=$$HOST_ALL
endif

build:
	docker build -t mooxe/openstack/nova .

rebuild:
	docker build --no-cache -t mooxe/openstack/nova .

in:
	docker run -ti mooxe/openstack/nova /usr/bin/env fish

check_nova:
# HOST_DB_NOVAAPI
ifndef HOST_DB_NOVAAPI
	$(error HOST_DB_NOVAAPI is undefined)
endif

nova: check_nova
	docker run --rm -ti \
		-e HOST_DB_NOVAAPI=${HOST_DB_NOVAAPI} \
		-e PORT_DB_NOVAAPI=3306 \
		-e OS_PASSWORD=${PW} \
		-p 8774:8774 \
		-v $$(pwd)/config:/root/nova/config \
		mooxe/openstack/nova /usr/bin/env \
		bash -c "source /root/nova/config/connection.sh && fish"
