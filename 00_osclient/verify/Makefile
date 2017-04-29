demo:
	openstack project create --domain default --description "Service Project" service
	openstack project create --domain default --description "Demo Project" demo
	openstack user create --domain default --password $OS_PASSWORD demo
	openstack role create user
	openstack role add --project demo --user demo user

verify:
	curl -i \
		-H "Content-Type: application/json" \
		-d '
	{ "auth": {
		"identity": {
			"methods": ["password"],
				"password": {
					"user": {
						"name": "admin",
						"domain": { "id": "default" },
						"password": "$$OS_PASSWORD"
					}
				}
			}
		}
	}' \
		http://$HOST_KeyStone:5000/v3/auth/tokens ; echo

testEX:
	openstack \
		--os-auth-url http://$HOST_KeyStone:35357/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name admin \
		--os-username admin token issue

testIN:
	openstack \
		--os-auth-url http://$HOST_KeyStone:5000/v3 \
		--os-project-domain-name default \
		--os-user-domain-name default \
		--os-project-name demo \
		--os-username demo token issue
