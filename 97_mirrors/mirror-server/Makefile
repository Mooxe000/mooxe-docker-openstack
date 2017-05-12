build:
	docker build -t mooxe/mirrors/server .

rebuild:
	docker build --no-cache -t mooxe/mirrors/server .

in:
	docker run --rm -ti \
		--name mirrors-server \
		-p 8080:8080 \
		-v $$(pwd)/config:/root/mirrors/config:ro \
		-v $$(pwd)/../data/openstack:/data/mirrors/data \
		mooxe/mirrors/server fish

create:
	docker run -d -ti \
		--name mirrors-server \
		-p 8080:8080 \
		-v $$(pwd)/../data/openstack:/data/mirrors/data \
		mooxe/mirrors/server \
		/usr/bin/env bash -c " \
			/root/mirrors/config/init.sh && tail -f /dev/null "

logs:
	docker logs -f mirrors-server

remove:
	docker rm -f mirrors-server

exec:
	docker exec -ti mirrors-server fish
