FROM busybox:latest
MAINTAINER Brendan Tobolaski "brendan@tobolaski.com"

RUN wget http://download.owncloud.org/community/owncloud-7.0.2.tar.bz2 -P /
RUN if [ `sha1sum /owncloud-7.0.2.tar.bz2 | awk '{print $1}'` != d0b0012972db6a1415251d3d6c49432b4f7cc3ec ]; \
	then \
		echo "checksum filaed." && exit 1; \
	else \
		bzcat /owncloud-*.tar.bz2 | tar x -C /var/www  -f - ; \
	fi
RUN mkdir /var/www/owncloud/data
RUN chown -R www-data:www-data /var/www/owncloud
RUN rm /owncloud-*.tar.bz2

VOLUME ["/var/www"]
