.keystone:
	openstack project create --domain default --description "Service Project" service
	openstack project create --domain default --description "Demo Project" demo
	openstack user create --domain default --password $$OS_PASSWORD demo
	openstack role create user
	openstack role add --project demo --user demo user

.glance:
	openstack user create --domain default --password $$OS_PASSWORD glance
	openstack role add --project service --user glance admin
	openstack service create --name glance --description "OpenStack Image" image
	openstack endpoint create --region RegionOne image public http://$$HOST_Glance:9292
	openstack endpoint create --region RegionOne image internal http://$$HOST_Glance:9292
	openstack endpoint create --region RegionOne image admin http://$$HOST_Glance:9292

keystone:
	env OS_AUTH_URL='http://${HOST_KeyStone}:5000/v3' make .keystone

glance:
	env OS_AUTH_URL='http://${HOST_KeyStone}:5000/v3' make .glance

verifyKTEX:
	openstack \
		--os-auth-url http://$$HOST_KeyStone:35357/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name admin \
		--os-username admin \
		--os-auth-type password \
		token issue

verifyKTIN:
	openstack \
		--os-auth-url http://$$HOST_KeyStone:5000/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name demo \
		--os-username demo \
		--os-auth-type password \
		token issue
