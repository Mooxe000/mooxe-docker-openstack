#

ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$$HOST_ALL
	HOST_GLANCE=$$HOST_ALL
	compute1_ip=$$HOST_ALL
endif

imgName := mooxe/openstack/compute

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
	docker run --rm -ti \
		-v $$(pwd)/config:/root/compute/config \
		mooxe/openstack/compute \
		/usr/bin/env fish

check_compute:
# HOST_KEYSTONE
ifndef HOST_KEYSTONE
	$(error HOST_KEYSTONE is undefined)
endif
# HOST_GLANCE
ifndef HOST_GLANCE
	$(error HOST_GLANCE is undefined)
endif
# compute1_ip
ifndef compute1_ip
	$(error compute1_ip is undefined)
endif

compute: check_compute
	docker run --rm -ti \
		--privileged \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_GLANCE=${HOST_GLANCE} \
		-e compute1_ip=${compute1_ip} \
		-e OS_PASSWORD=${PW} \
		-v $$(pwd)/config:/root/compute/config \
		mooxe/openstack/compute /usr/bin/env \
		bash -c "source /root/compute/config/connection.sh && fish"
