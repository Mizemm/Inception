#!/bin/bash

wait_for_mariadb() {
    echo "Waiting for MariaDB to be ready..."
    while ! mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
        echo "MariaDB is unavailable - sleeping"
        sleep 5
    done
    echo "MariaDB is up and running!"
}

wait_for_mariadb


if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    
    mkdir -p /var/www/html
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    rm /tmp/wordpress.tar.gz

    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${MYSQL_HOST}/" /var/www/html/wp-config.php
fi


if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."

    wp core install \
        --url="https://mizem.42.fr" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create \
        "$WP_USR" "$WP_EMAIL" \
        --user_pass="$WP_PWD" \
        --role=editor \
        --allow-root
else
    echo "WordPress already installed."
fi

chown -R www-data:www-data /var/www/html

mkdir -p /run/php
sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

php-fpm7.4 -F