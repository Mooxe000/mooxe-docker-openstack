#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_GLANCE=$$HOST_ALL
	HOST_NOVA=$$HOST_ALL
endif

build:
	docker build -t mooxe/openstack/osclient .

rebuild:
	docker build --no-cache -t mooxe/openstack/osclient .

in_check:
# HOST_KEYSTONE
ifndef HOST_KEYSTONE
	$(error HOST_KEYSTONE is undefined)
endif
# HOST_GLANCE
ifndef HOST_GLANCE
	$(error HOST_GLANCE is undefined)
endif
# HOST_NOVA
ifndef HOST_NOVA
	$(error HOST_NOVA is undefined)
endif

in: in_check
	docker run --rm -ti \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_GLANCE=${HOST_GLANCE} \
		-e HOST_NOVA=${HOST_NOVA} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL=http://${HOST_KEYSTONE}:35357/v3 \
		-v $$(pwd)/config:/root/osclient/config \
		-v $$(pwd)/images:/root/osclient/images \
		mooxe/openstack/osclient /usr/bin/env fish
