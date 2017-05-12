FROM mooxe/openstack/base

MAINTAINER FooTearth "footearth@gmail.com"

ARG MIRROR_CA
ENV MIRROR_CA ${MIRROR_CA}

RUN \
  if [ ! -z ${MIRROR_CA} ]; then \
    sed -i -e "s/ubuntu-cloud.archive.canonical.com/${MIRROR_CA}/g" \
      /etc/apt/sources.list.d/cloudarchive-ocata.list; \
  fi

# system update
RUN \
  apt-get update && \
  apt-get -y dist-upgrade

RUN apt-get install -y openstack-dashboard

# ENV HORIZON_BASEDIR=/opt/horizon \
#     KEYSTONE_URL='http://keystone:5000/v3' \
#     APACHE_RUN_USER=www-data \
#     APACHE_RUN_GROUP=www-data \
#     APACHE_PID_FILE=/var/run/apache2/apache2.pid \
#     APACHE_RUN_DIR=/var/run/apache2 \
#     APACHE_LOCK_DIR=/var/lock/apache2 \
#     APACHE_LOG_DIR=/var/log/apache2 \
#     LANG=C \
#     VERSION=stable/ocata
#
# EXPOSE 80
#
# RUN \
#   apt install -y \
#     apache2 libapache2-mod-wsgi \
#     python-pip python-dev
#
# RUN \
#   git clone --branch $VERSION --depth 1 \
#     https://github.com/openstack/horizon.git ${HORIZON_BASEDIR}
#
# WORKDIR ${HORIZON_BASEDIR}
#
# RUN pip install .
#
# RUN \
#   cp openstack_dashboard/local/local_settings.py.example \
#     openstack_dashboard/local/local_settings.py && \
#   ./manage.py collectstatic --noinput && \
#   ./manage.py compress --force && \
#   ./manage.py make_web_conf --wsgi && \
#   rm -rf /etc/apache2/sites-enabled/* && \
#   ./manage.py make_web_conf --apache > \
#     /etc/apache2/sites-enabled/horizon.conf
#
# RUN \
#   sed -i 's/<VirtualHost \*.*/<VirtualHost _default_:80>/g' \
#     /etc/apache2/sites-enabled/horizon.conf && \
#   chown -R www-data:www-data ${HORIZON_BASEDIR} && \
#   sed -i 's/^DEBUG.*/DEBUG = False/g' \
#     $HORIZON_BASEDIR/openstack_dashboard/local/local_settings.py && \
#   sed -i 's/^OPENSTACK_KEYSTONE_URL.*/OPENSTACK_KEYSTONE_URL = os\.environ\["KEYSTONE_URL"\]/g' \
#     $HORIZON_BASEDIR/openstack_dashboard/local/local_settings.py && \
#   printf  "\nALLOWED_HOSTS = ['*', ]\n" >> $HORIZON_BASEDIR/openstack_dashboard/local/local_settings.py && \
#   python -m compileall $HORIZON_BASEDIR
#
# # VOLUME /var/log/apache2
#
# CMD /usr/sbin/apache2 -DFOREGROUND

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
