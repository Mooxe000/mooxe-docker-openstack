create:
	docker run -d \
		--name centos \
		--restart=always \
		--privileged \
		--cap-add=SYS_ADMIN \
		--security-opt=seccomp:unconfined \
		--stop-signal=SIGRTMIN+3 \
		-v $$(pwd)/ocata:/root/ocata \
		-p 8080:80 \
		-p 5000:5000 \
		-p 35357:35357 \
		centos-systemd

remove:
	docker rm -f centos

bash:
	@docker exec -ti centos \
		bash -c "cd ~ && bash"

fish:
	@docker exec -ti centos \
		bash -c "cd ~ && fish"
