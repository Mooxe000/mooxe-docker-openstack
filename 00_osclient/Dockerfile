FROM mooxe/openstack/base

MAINTAINER FooTearth "footearth@gmail.com"

# system update
RUN \
  apt-get update && \
  apt-get -y dist-upgrade

RUN apt-get install -y make python-openstackclient

RUN \
  apt-get autoremove -y && \
  apt-get clean
