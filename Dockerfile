FROM phusion/baseimage:latest
MAINTAINER Brendan Tobolaski "brendan@tobolaski.com"

ENV OC_VERSION 9.0.1

# Install dependencies
RUN apt-get -y update \
    && apt-get install -y \
      apache2 \
      bzip2 \
      curl \
      libcurl3 \
      php5 \
      php5-curl \
      php5-gd \
      php5-intl \
      php5-json \
      php5-ldap \
      php5-mcrypt \
      php5-mysqlnd \
      php-xml-parser \
      smbclient \
      wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove ssh daemon
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Download owncloud
RUN curl -k https://download.owncloud.org/community/owncloud-$OC_VERSION.tar.bz2 | tar jx -C /var/www/ \
    && mkdir /var/www/owncloud/data \
    && chown -R www-data:www-data /var/www/owncloud

# Apache configuration
ADD ./001-owncloud.conf /etc/apache2/sites-available/
RUN rm -f /etc/apache2/sites-enabled/* \
    && ln -s /etc/apache2/sites-available/001-owncloud.conf /etc/apache2/sites-enabled/ \
    && a2enmod rewrite

ADD rc.local /etc/rc.local
RUN chown root:root /etc/rc.local

# Add volumes for persistency
VOLUME ["/var/www/owncloud/data", "/var/www/owncloud/config"]

# Expose HTTP and HTTPS ports
EXPOSE 80 443


CMD ["/sbin/my_init"]
