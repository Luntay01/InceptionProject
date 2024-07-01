#!/bin/sh

while ! mariadb -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} &>/dev/null;
do
    echo "waiting for mysql to be connectable..."
    sleep 3
done

WP_PATH=${WP_PATH}

if [ -f ${WP_PATH}/wp-config.php ]
then
    echo "[WP config] WordPress already configured."
else
    wp --allow-root cli update --yes
    wp --allow-root core download --path=${WP_PATH}
    wp --allow-root config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --path=${WP_PATH}
    wp --allow-root core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_USER} --admin_password=${WP_PASSWORD} --admin_email=${WP_EMAIL} --path=${WP_PATH}
    wp --allow-root user create ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWORD} --role=administrator --path=${WP_PATH}
    wp --allow-root theme install bravada --path=${WP_PATH} --activate
    wp --allow-root theme status bravada
fi

exec php-fpm81 -F -R
