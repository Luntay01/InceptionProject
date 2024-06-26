FROM debian:latest

# Install necessary packages
RUN apt update && apt upgrade -y && apt install -y php-fpm php-mysqli curl mariadb-client

# Copy configuration files
COPY www.conf /etc/php/8.2/fpm/pool.d/
COPY script.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/script.sh

# Run the script
CMD ["script.sh"]