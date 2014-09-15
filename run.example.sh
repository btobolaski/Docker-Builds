#!/bin/bash

source common.hdr

docker ps -a | grep ' oc_data' || \
	docker run -d --name oc_data $CDATA_NAME

docker ps -a | grep ' oc_db' || \
	docker run -d --name oc_db -e MYSQL_PASS="password" tutum/mysql

docker ps -a | grep ' oc_nginx' || \
	docker run -d -p 80:80 -p 443:443 \
		--volumes-from oc_data \
		--link oc_db:oc_db \
		-e MAX_UPLOAD_SIZE="5G" \
		--name oc_nginx $CNGINX_NAME
