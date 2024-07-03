--These commands set up the initial database and user with the necessary permissions.
CREATE DATABASE MYSQL_DATABASE;

CREATE USER 'MYSQL_USER'@'%' IDENTIFIED BY 'MYSQL_PASSWORD';

GRANT ALL PRIVILEGES ON MYSQL_DATABASE.* TO 'MYSQL_USER'@'%' IDENTIFIED BY 'MYSQL_PASSWORD';

--FLUSH PRIVILEGES;Reloads the privilege tables to ensure the changes take effect immediately.
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'MYSQL_ROOT_PASSWORD';