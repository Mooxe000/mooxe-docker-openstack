ubuntu:
	docker run -d \
		--name devstack \
		--restart=always \
		--privileged \
		--cap-add=SYS_ADMIN \
		--cap-add=NET_ADMIN \
		--security-opt=seccomp:unconfined \
		--stop-signal=SIGRTMIN+3 \
		-v /Volumes/HOME/WorkSpace/OpenStack/devstack:/root/devstack \
		-v /Volumes/HOME/WorkSpace/OpenStack/devstack_sources/requirements:/opt/stack/requirements \
		-v /Volumes/HOME/WorkSpace/OpenStack/devstack_sources/keystone:/opt/stack/keystone \
		-v $$(pwd)/ocata:/root/ocata \
		-p 8080:80 \
		-p 5000:5000 \
		-p 35357:35357 \
		mooxe/systemd:ubuntu

centos:
	docker run -d \
		--name devstack \
		--restart=always \
		--privileged \
		--cap-add=SYS_ADMIN \
		--cap-add=NET_ADMIN \
		--security-opt=seccomp:unconfined \
		--stop-signal=SIGRTMIN+3 \
		-v /Volumes/HOME/WorkSpace/OpenStack/devstack:/root/devstack \
		-v $$(pwd)/ocata:/root/ocata \
		-p 8080:80 \
		-p 5000:5000 \
		-p 35357:35357 \
		mooxe/systemd:centos

bash:
	docker exec -ti devstack bash

fish:
	docker exec -ti devstack fish

remove:
	docker rm -f devstack
