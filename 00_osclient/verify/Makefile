.demo:
	openstack project create --domain default --description "Service Project" service
	openstack project create --domain default --description "Demo Project" demo
	openstack user create --domain default --password $$OS_PASSWORD demo
	openstack role create user
	openstack role add --project demo --user demo user

demo:
	@env OS_AUTH_URL='http://keystone:5000/v3' make .demo

verifyEX:
	openstack \
		--os-auth-url http://$$HOST_KeyStone:35357/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name admin \
		--os-username admin \
		--os-auth-type password \
		token issue

verifyIN:
	openstack \
		--os-auth-url http://$$HOST_KeyStone:5000/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name demo \
		--os-username demo \
		--os-auth-type password \
		token issue
