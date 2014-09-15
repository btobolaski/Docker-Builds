FROM phusion/baseimage:latest
MAINTAINER Brendan Tobolaski "brendan@tobolaski.com"

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get -y update
RUN apt-get install -y nginx php5-gd php5-fpm php5-mysql php5-intl php5-json \
	php5-mcrypt smbclient php5-curl
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm /etc/nginx/sites-enabled/default

ADD nginx.conf /etc/nginx/sites-enabled/owncloud.conf
ADD ssl /etc/ssl
ADD rc.local /etc/rc.local
RUN chown root:root /etc/rc.local

VOLUME ["/var/log/nginx/", "/etc/nginx/sites-enabled", "/etc/ssl", "/etc/php5"]

EXPOSE 80
EXPOSE 443
CMD ["/sbin/my_init"]
