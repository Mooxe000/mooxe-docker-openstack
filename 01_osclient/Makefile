#
ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_GLANCE=$$HOST_ALL
	HOST_NOVA=$$HOST_ALL
	HOST_NEUTRON=$$HOST_ALL
	compute1_ip=$$HOST_ALL
endif

imgName := mooxe/openstack/osclient

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
# HOST_NEUTRON
ifndef HOST_NEUTRON
	$(error HOST_NEUTRON is undefined)
endif
# compute1_ip
ifndef compute1_ip
	$(error compute1_ip is undefined)
endif

in: in_check
	docker run --rm -ti \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_GLANCE=${HOST_GLANCE} \
		-e HOST_NOVA=${HOST_NOVA} \
		-e HOST_NEUTRON=${HOST_NEUTRON} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL=http://${HOST_KEYSTONE}:35357/v3 \
		-e compute1_ip=${compute1_ip} \
		-v $$(pwd)/config:/root/osclient/config \
		-v $$(pwd)/images:/root/osclient/images \
		mooxe/openstack/osclient /usr/bin/env bash -c " \
			echo \"$compute1_ip		compute1\" >> /etc/hosts && fish"
