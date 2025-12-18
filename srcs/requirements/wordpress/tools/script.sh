#!/bin/bash

wait_for_mariadb() {
    echo "Waiting for MariaDB to be ready..."
    while ! mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
        echo "MariaDB is unavailable - sleeping"
        sleep 5
    done
    echo "MariaDB is up and running!"
}

# Call the function to ensure DB is ready before proceeding
wait_for_mariadb


# Check if WordPress is already installed  (by checking wp-config.php)
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    
    # checking dir exists, cloning wp, extracting wp, deleting tar file
    mkdir -p /var/www/html
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    rm /tmp/wordpress.tar.gz

    # Replace placeholder values in wp-config.php with actual environment variables
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${MYSQL_HOST}/" /var/www/html/wp-config.php
fi

# Check if WordPress core (WP Website) is installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."

    # Install WordPress with credentials
    wp core install \
        --url="https://mizem.42.fr" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    # Create an additional WordPress user
    wp user create \
        "$WP_USR" "$WP_EMAIL" \
        --user_pass="$WP_PWD" \
        --role=editor \
        --allow-root
else
    echo "WordPress already installed."
fi

# Ensure WordPress files are owned by www-data (Nginx/PHP user)
chown -R www-data:www-data /var/www/html

# Prepare PHP-FPM runtime directory
mkdir -p /run/php

# Configure PHP-FPM to listen on all network interfaces at port 9000
sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Start PHP-FPM in the foreground so Docker keeps the container running
php-fpm7.4 -F