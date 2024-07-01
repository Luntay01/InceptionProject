CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'wpuser'@'%' IDENTIFIED BY 'securepassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;