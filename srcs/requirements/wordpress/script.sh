#!/bin/sh

# Configure PHP-FPM
sed -i 's|PHP_PORT|'${PHP_PORT}'|g' /etc/php/8.2/fpm/pool.d/www.conf

# Wait for MariaDB to be connectable
until mysqladmin ping -h mariadb --silent; do
    echo "waiting for mysql to be connectable..."
    sleep 2
done

# Check if WordPress is already installed
if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "WordPress is already configured."
else
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    wp core download --path=$WP_PATH --allow-root
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --path=$WP_PATH --skip-check --allow-root
    wp core install --path=$WP_PATH --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=$WP_EMAIL --skip-email --allow-root
    wp theme install twentytwentyone --path=$WP_PATH --activate --allow-root
    wp user create testuser testuser@example.com --role=author --path=$WP_PATH --user_pass=testpassword --allow-root
fi

/usr/sbin/php-fpm8.2 -F
