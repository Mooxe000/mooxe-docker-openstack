#

ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_GLANCE=$$HOST_ALL
endif

build:
	docker build -t mooxe/openstack/compute .

rebuild:
	docker build --no-cache -t mooxe/openstack/compute .

in:
	docker run --rm -ti \
		-v $$(pwd)/config:/root/compute/config \
		mooxe/openstack/compute \
		/usr/bin/env fish

compute:
	docker run --rm -ti \
		--privileged \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_GLANCE=${HOST_GLANCE} \
		-e HOST_GLANCE=${HOST_GLANCE} \
		-e compute1_ip=${compute1_ip} \
		-e OS_PASSWORD=${PW} \
		-v $$(pwd)/config:/root/compute/config \
		mooxe/openstack/compute /usr/bin/env \
		bash -c "source /root/compute/config/connection.sh && fish"
