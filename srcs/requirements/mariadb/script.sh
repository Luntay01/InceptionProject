#!/bin/sh

# MariaDB initialization
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
    mariadbd --user=mysql --bootstrap < /path/to/init.sql
    echo "MariaDB data directory initialized."
fi

# MariaDB configuration adjustments
if [ -f /etc/my.cnf.d/mariadb-server.cnf ]; then
    sed -i "s/^bind-address/#bind-address/" /etc/my.cnf.d/mariadb-server.cnf
else
    echo "/etc/my.cnf.d/mariadb-server.cnf not found, skipping configuration adjustment."
fi

# Start MariaDB
echo "Starting MariaDB..."
exec /usr/sbin/mysqld --user=mysql --console