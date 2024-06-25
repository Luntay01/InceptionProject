#!/bin/bash

# Create required directories
mkdir -p /etc/nginx/sites-enabled
mkdir -p /etc/nginx/ssl

# Generate SSL certificate
openssl req -x509 -nodes -days 365 \
-subj "/C=FR/ST=Paris/L=Paris/O=42/OU='${MYSQL_USER}'/CN='${DOMAIN_NAME}'" -newkey rsa:2048 \
-keyout $CERTS_KEY -out $CERTS_CRT

# Update configuration with environment variables
sed -i 's|$DOMAIN_NAME|'${DOMAIN_NAME}'|g' /etc/nginx/sites-available/default
sed -i 's|$PHP_HOST|'${PHP_HOST}'|g' /etc/nginx/sites-available/default
sed -i 's|$PHP_PORT|'${PHP_PORT}'|g' /etc/nginx/sites-available/default
sed -i 's|$CERTS_KEY|'${CERTS_KEY}'|g' /etc/nginx/sites-available/default
sed -i 's|$CERTS_CRT|'${CERTS_CRT}'|g' /etc/nginx/sites-available/default

# Create symbolic link to enable site
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Start NGINX
nginx -g "daemon off;"