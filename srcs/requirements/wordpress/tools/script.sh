#!/bin/bash
set -e

WP_PATH="/var/www/wordpress"

# Wait for MariaDB
while ! mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done
echo "MariaDB is ready"

# Create WordPress directory
mkdir -p $WP_PATH
cd $WP_PATH

# Download WordPress if missing
if [ ! -f "wp-config-sample.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi

# Create wp-config.php
if [ ! -f "wp-config.php" ]; then
    echo "Creating wp-config"
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOST" \
        --allow-root \
        --skip-check
fi

# Install wordpress
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
fi

# Start PHP-FPM 7.4 foreground
exec php-fpm7.4 -F

















# #!/bin/bash

# # Wait for MariaDB to be ready
# while ! mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
#     echo "Waiting for MariaDB..."
#     sleep 2
# done
# echo "MariaDB is ready"


# # If wp-config.php doesn't exist, create it
# if [ ! -f /var/www/wordpress/wp-config.php ]; then
#     echo "Creating wp-confing"
#     wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
#         --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOST" --allow-root --skip-check
# fi


# # installing wordpress and creating admin user
# wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR \
#     --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL \
#     --allow-root

# # creating additional user
# wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# # setting permission so it can change on wp-content file
# chmod 777 /var/www/wordpress/wp-content

# # running PHP-FPM in foreground so Docker keeps the container running.
# exec php-fpm
