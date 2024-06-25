#!/bin/bash

# Initialize the MariaDB data directory
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Start the MariaDB server
mysqld_safe &

# Wait for the MariaDB server to start
until mysqladmin ping --silent; do
    echo 'waiting for mysql to be connectable...'
    sleep 2
done

# Run the initialization script to create the database and user
if [ ! -f /var/lib/mysql/initialized ]; then
    mysql < /etc/mysql/init.sql
    touch /var/lib/mysql/initialized
fi

# Keep the container running
tail -f /dev/null