FROM mooxe/openstack/base

MAINTAINER FooTearth "footearth@gmail.com"

ARG MIRROR_CA
ENV MIRROR_CA ${MIRROR_CA}

# echo "1: ${MIRROR_CA}" && \
# echo "2: ${MIRROR_CA}"; \
RUN \
  if [ ! -z ${MIRROR_CA} ]; then \
    sed -i -e "s/ubuntu-cloud.archive.canonical.com/${MIRROR_CA}/g" \
      /etc/apt/sources.list.d/cloudarchive-ocata.list; \
  fi

# system update
RUN \
  apt-get update && \
  apt-get -y dist-upgrade

RUN apt-get install -y make python-openstackclient
ADD ./config /root/osclient/config
ADD ./images /root/osclient/images

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
