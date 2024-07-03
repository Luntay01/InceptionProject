FROM debian:buster

RUN apt update -yq && \
    apt upgrade -yq && \
    apt install -yq php && \
	apt install -yq php-mysql && \
	apt install -yq php-cli && \
	apt install -yq php-mbstring && \
	apt install -yq php-fpm && \
	apt install -yq php-gettext && \
	apt install -yq mariadb-client && \
	apt install -yq wget && \
    rm -rf /etc/php/7.3/fpm/pool.d/www.conf && \
    mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./tools/run.sh /tmp/

RUN chmod +x /tmp/run.sh

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
