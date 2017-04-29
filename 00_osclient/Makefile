#

build:
	docker build -t mooxe/openstack/osclient .

rebuild:
	docker build --no-cache -t mooxe/openstack/osclient .

in:
	docker run --rm -ti \
		-e HOST_KeyStone=${HOST_KeyStone} \
		-e OS_PASSWORD=netserver \
		mooxe/openstack/osclient /usr/bin/env fish
