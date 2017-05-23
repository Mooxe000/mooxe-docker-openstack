# yum install -y make

all: base fish ocata osclient keystone

base:
	yum update && yum upgrade -y
	yum install -y git zsh

fish:
	@bash -c " \
		pushd /etc/yum.repos.d; \
			curl -OL http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo; \
		popd"
	yum install -y fish
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
	fish -c "fisher omf/theme-robbyrussell"

ocata:
	yum install -y centos-release-openstack-ocata
	yum update; yum upgrade -y
	yum install -y python2-PyMySQL python-memcached

osclient:
	yum install -y python-openstackclient

keystone:
	yum install -y openstack-keystone httpd mod_wsgi
	rm -f /etc/keystone/keystone.conf
	ln -s /root/ocata/config/keystone/keystone.conf /etc/keystone/keystone.conf

keystone_init:
	/bin/sh -c "keystone-manage db_sync" keystone
	keystone-manage fernet_setup \
	  --keystone-user keystone \
	  --keystone-group keystone
	keystone-manage credential_setup \
	  --keystone-user keystone \
	  --keystone-group keystone
	keystone-manage bootstrap \
	  --bootstrap-password netserver \
	  --bootstrap-admin-url http://192.168.0.108:35357/v3/ \
	  --bootstrap-internal-url http://192.168.0.108:5000/v3/ \
	  --bootstrap-public-url http://192.168.0.108:5000/v3/ \
	  --bootstrap-region-id RegionOne

keystone_httpd:
	sed -i -e "/^#ServerName*/cServerName 192.168.0.108" /etc/httpd/conf/httpd.conf
	ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/
	systemctl enable httpd.service
	systemctl start httpd.service
	systemctl status httpd.service
