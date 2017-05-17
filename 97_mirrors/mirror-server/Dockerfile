FROM mooxe/base:dev

MAINTAINER FooTearth "footearth@gmail.com"

# system update
RUN \
  apt-get update && \
  apt-get -y dist-upgrade

RUN apt-get install -y nginx
ADD ./config /root/mirrors/config

RUN \
  ln -s /root/mirrors/config/mirrors \
    /etc/nginx/sites-enabled/mirrors

RUN \
  apt-get autoremove -y && \
  apt-get clean
