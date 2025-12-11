#!/bin/bash

# Wait for MariaDB to be ready
while ! mariadb -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" &> /dev/null; do
	echo "Waiting for MariaDB"
	sleep 2
done
    echo "MariaDB is ready"

# If wp-config.php doesn't exist, create it
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root  --skip-check


# Copy default wp-config
cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php


# installing wordpress and creating admin user
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL \
    --allow-root

# creating additional user
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# setting permission so it can change on wp-content file
chmod 777 /var/www/wordpress/wp-content

# running PHP-FPM in foreground so Docker keeps the container running.
/usr/sbin/php-fpm7.3 -F
