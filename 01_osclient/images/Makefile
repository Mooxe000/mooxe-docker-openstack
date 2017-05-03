#

pull:
	curl -OL "http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img"

push:
	openstack image create "cirros" \
		--file cirros-0.3.5-x86_64-disk.img \
		--disk-format qcow2 --container-format bare \
		--public
