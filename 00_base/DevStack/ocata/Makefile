#

all: ubuntu_update pip

fish:
	@bash -c " \
		pushd /etc/yum.repos.d; \
			curl -OL http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo; \
		popd"
	yum install -y fish
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
	fish -c "fisher omf/theme-robbyrussell"

centos_update:
	yum update && yum upgrade -y
	yum install -y git zsh iproute openvswitch-switch

ubuntu_update:
	mkdir -p /etc/apt/sources.list.d.bak
	cp -R /etc/apt/sources.list.d/* /etc/apt/sources.list.d.bak
	rm -rf /etc/apt/sources.list.d/*
	apt update && apt upgrade -y
	apt install -y sudo iptables net-tools bridge-utils

# arptables

pip:
	curl -fsSL https://bootstrap.pypa.io/get-pip.py | python
	pip install os-testr virtualenv prettytable httplib2

stack:
	$$(pwd)/../devstack/tools/create-stack-user.sh
	$$(pwd)/../devstack/stack.sh
