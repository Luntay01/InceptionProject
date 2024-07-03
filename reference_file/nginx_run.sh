#!/bin/sh

mkdir -p $WP_PATH
chown -R www-data $WP_PATH


#req: This initiates a certificate signing request (CSR) or creates a self-signed certificate.
#-x509: This option is used to create a self-signed certificate instead of a certificate signing request.
#-nodes: This option tells openssl to not encrypt the private key. Without this, openssl would prompt for a password to protect the private key
#openssl req -x509 -nodes -days 365 \
#-subj "/C=AU/ST=South Australia/L=Adelaide/O=42/OU='${MYSQL_USER}'/CN='${DOMAIN_NAME}'" -newkey rsa:2048
#-keyout $CERTS_KEY -out $CERTS_CRT

openssl req -x509 -nodes -days 365 \
-subj "/C=AU/ST=South Australia/L=Adelaide/O=42/OU='${MYSQL_USER}'/CN='${DOMAIN_NAME}'" -newkey rsa:2048 \
-keyout $CERTS_KEY -out $CERTS_CRT

sed -i 's/DOMAIN_NAME/'${DOMAIN_NAME}'/g' /etc/nginx/sites-available/default.conf
sed -i 's/WP_PATH/'${WP_PATH}'/g' /etc/nginx/sites-available/default.conf
sed -i 's/PHP_HOST/'${PHP_HOST}'/g' /etc/nginx/sites-available/default.conf
sed -i 's/PHP_PORT/'${PHP_PORT}'/g' /etc/nginx/sites-available/default.conf
sed -i 's/CERTS_KEY/'${CERTS_KEY}'/g' /etc/nginx/sites-available/default.conf
sed -i 's/CERTS_CRT/'${CERTS_CRT}'/g' /etc/nginx/sites-available/default.conf


#This command starts the NGINX web server with the configuration to not 
#run as a daemon (daemon off), meaning it will run in the foreground. 
#This is useful in container environments where you want the main process to keep running and not exit.
nginx -g "daemon off;"