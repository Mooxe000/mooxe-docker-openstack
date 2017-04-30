#
ifndef PW
	PW := netserver
endif

build:
	docker build -t mooxe/openstack/osclient .

rebuild:
	docker build --no-cache -t mooxe/openstack/osclient .

in_check:
# HOST_DB_KeyStone
ifndef HOST_DB_KeyStone
	$(error HOST_DB_KeyStone is undefined)
endif
# HOST_KeyStone
ifndef HOST_KeyStone
	$(error HOST_KeyStone is undefined)
endif

in: in_check
	docker run --rm -ti \
		-e HOST_DB_KeyStone=${HOST_DB_KeyStone} \
		-e HOST_KeyStone=${HOST_KeyStone} \
		-e OS_PASSWORD=${PW} \
		-e OS_AUTH_URL=http://${HOST_KeyStone}:35357/v3 \
		mooxe/openstack/osclient /usr/bin/env fish
