FROM mooxe/openstack/base

MAINTAINER FooTearth "footearth@gmail.com"

ARG MIRROR_CA
ENV MIRROR_CA ${MIRROR_CA}

RUN \
  if [ ! -z ${MIRROR_CA} ]; then \
    cp -R /etc/apt/sources.list.d \
      /etc/apt/sources.list.d.bak; \
    sed -i -e "s/ubuntu-cloud.archive.canonical.com/${MIRROR_CA}/g" \
      /etc/apt/sources.list.d/cloudarchive-ocata.list; \
  fi

# system update
RUN \
  apt-get update && \
  apt-get -y dist-upgrade

RUN apt-get install -y glance python-memcache
ADD ./config /root/glance/config

ENV \
  OS_USERNAME=admin \
  OS_PASSWORD=password \
  OS_PROJECT_NAME=admin \
  OS_USER_DOMAIN_NAME=Default \
  OS_PROJECT_DOMAIN_NAME=Default \
  OS_AUTH_URL=http://0.0.0.0:35357/v3 \
  OS_IDENTITY_API_VERSION=3

RUN \
  apt-get autoremove -y && \
  apt-get clean

RUN \
  if [ ! -z ${MIRROR_LP} ]; then \
    rm -rf /etc/apt/sources.list.d; \
    mv /etc/apt/sources.list.d.bak \
      /etc/apt/sources.list.d; \
  fi
