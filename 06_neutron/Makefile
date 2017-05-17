#

ifndef PW
	PW := netserver
endif

ifdef HOST_ALL
	HOST_KEYSTONE=$${HOST_ALL}
	HOST_DB=$${HOST_ALL}
	HOST_MQ=$${HOST_ALL}
	HOST_MC=$${HOST_ALL}
endif

imgName := mooxe/openstack/neutron

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
		--privileged \
		-e OS_PASSWORD=${PW} \
		-e HOST_KEYSTONE=${HOST_KEYSTONE} \
		-e HOST_DB=${HOST_DB} \
		-e HOST_MQ=${HOST_MQ} \
		-e HOST_MC=${HOST_MC} \
		-p 9696:9696 \
		-v $$(pwd)/config:/root/neutron/config \
		mooxe/openstack/neutron fish
