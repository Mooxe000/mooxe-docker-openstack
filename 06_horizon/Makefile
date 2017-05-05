#

build:
	docker build -t mooxe/openstack/horizon .

rebuild:
	docker build --no-cache -t mooxe/openstack/horizon .

in:
	docker run -ti --rm \
		-p 3398:80 \
		mooxe/openstack/horizon \
		/usr/bin/env fish
