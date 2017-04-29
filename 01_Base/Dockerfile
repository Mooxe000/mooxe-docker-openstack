FROM mooxe/base:dev

MAINTAINER FooTearth "footearth@gmail.com"

RUN add-apt-repository cloud-archive:ocata

# system update
RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get autoremove -y && \
  apt-get clean
