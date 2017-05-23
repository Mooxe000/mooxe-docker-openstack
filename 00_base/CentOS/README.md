# Base

```bash
yum update && yum upgrade -y
yum install -y git zsh
```

## fish

```bash
pushd /etc/yum.repos.d
  curl -OL http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
popd
yum install -y fish
```

## fisher

```bash
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fish
fisher omf/theme-robbyrussell
```

## oh-my-zsh

```bash
zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## bash-it

```bash
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh
```

# Ocata

```bash
yum install -y centos-release-openstack-ocata
yum update; yum upgrade -y
yum install -y python2-PyMySQL python-memcached
```

## osclient

```bash
yum install -y python-openstackclient
```

## keystone

```bash
yum install -y openstack-keystone httpd mod_wsgi

rm -f /etc/keystone/keystone.conf
ln -s /root/ocata/config/keystone/keystone.conf /etc/keystone/keystone.conf

cp /root/ocata/config/keystone/keystone.conf /etc/keystone/keystone.conf

/bin/sh -c "keystone-manage db_sync" keystone

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap \
  --bootstrap-password netserver \
  --bootstrap-admin-url http://192.168.0.108:35357/v3/ \
  --bootstrap-internal-url http://192.168.0.108:5000/v3/ \
  --bootstrap-public-url http://192.168.0.108:5000/v3/ \
  --bootstrap-region-id RegionOne

sed -i -e "/^#ServerName*/cServerName = 192.168.0.108" /etc/httpd/conf/httpd.conf
ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/
```
