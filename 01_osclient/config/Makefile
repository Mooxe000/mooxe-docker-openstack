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
	openstack endpoint create --region RegionOne image public http://$$HOST_GLANCE:9292
	openstack endpoint create --region RegionOne image internal http://$$HOST_GLANCE:9292
	openstack endpoint create --region RegionOne image admin http://$$HOST_GLANCE:9292

.nova:
# nova
	openstack user create --domain default --password $$OS_PASSWORD nova
	openstack role add --project service --user nova admin
	openstack service create --name nova --description "OpenStack Compute" compute
	openstack endpoint create --region RegionOne compute public http://$$HOST_NOVA:8774/v2.1
	openstack endpoint create --region RegionOne compute internal http://$$HOST_NOVA:8774/v2.1
	openstack endpoint create --region RegionOne compute admin http://$$HOST_NOVA:8774/v2.1
# placement
	openstack user create --domain default --password $$OS_PASSWORD placement
	openstack role add --project service --user placement admin
	openstack service create --name placement --description "Placement API" placement
	openstack endpoint create --region RegionOne placement public http://$$HOST_NOVA/placement
	openstack endpoint create --region RegionOne placement internal http://$$HOST_NOVA/placement
	openstack endpoint create --region RegionOne placement admin http://$$HOST_NOVA/placement

.neutron:
	openstack user create --domain default --password $$OS_PASSWORD neutron
	openstack role add --project service --user neutron admin
	openstack service create --name neutron --description "OpenStack Networking" network
	openstack endpoint create --region RegionOne network public http://$$HOST_NEUTRON:9696
	openstack endpoint create --region RegionOne network internal http://$$HOST_NEUTRON:9696
	openstack endpoint create --region RegionOne network admin http://$$HOST_NEUTRON:9696

keystone:
	env OS_AUTH_URL='http://${HOST_KEYSTONE}:5000/v3' make .keystone

glance:
	env OS_AUTH_URL='http://${HOST_KEYSTONE}:5000/v3' make .glance

nova:
	env OS_AUTH_URL='http://${HOST_KEYSTONE}:5000/v3' make .nova

neutron:
	env OS_AUTH_URL='http://${HOST_KEYSTONE}:5000/v3' make .neutron

verifyKTEX:
	openstack \
		--os-auth-url http://$$HOST_KEYSTONE:35357/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name admin \
		--os-username admin \
		--os-auth-type password \
		token issue

verifyKTIN:
	openstack \
		--os-auth-url http://$$HOST_KEYSTONE:5000/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name demo \
		--os-username demo \
		--os-auth-type password \
		token issue
