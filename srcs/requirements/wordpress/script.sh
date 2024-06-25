#!/bin/bash

# Wait for MariaDB to be ready
until mysqladmin ping -h"$MYSQL_HOST" --silent; do
    echo 'waiting for mysql to be connectable...'
    sleep 2
done

# Download and set up WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
    cd /var/www/html
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    ./wp-cli.phar core download --allow-root
    ./wp-cli.phar config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root
    ./wp-cli.phar core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
fi

# Start PHP-FPM
php-fpm8.2 -F