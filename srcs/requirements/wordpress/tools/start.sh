#!/bin/bash

# Wait for MariaDB to be ready
while ! mariadb -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" &> /dev/null; do
	echo "Waiting for MariaDB"
	sleep 2
done
    echo "MariaDB is ready"

# If wp-config.php doesn't exist, create it
if [ ! -f /var/www/wordpress/wp-config.php ]; then
	echo "Creating wp-config.php"

# Copy default wp-config
cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

# Apply credentials in wp-config.php
sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/wordpress/wp-config.php
sed -i "s/username_here/$MYSQL_USER/" /var/www/wordpress/wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/wordpress/wp-config.php
sed -i "s/localhost/$MYSQL_HOST/" /var/www/wordpress/wp-config.php

# Set unique security keys automatically
curl -s https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wp.keys
sed -i "/AUTH_KEY/d" /var/www/wordpress/wp-config.php
sed -i "/SECURE_AUTH_KEY/d" /var/www/wordpress/wp-config.php
sed -i "/LOGGED_IN_KEY/d" /var/www/wordpress/wp-config.php
sed -i "/NONCE_KEY/d" /var/www/wordpress/wp-config.php
sed -i "/AUTH_SALT/d" /var/www/wordpress/wp-config.php
sed -i "/SECURE_AUTH_SALT/d" /var/www/wordpress/wp-config.php
sed -i "/LOGGED_IN_SALT/d" /var/www/wordpress/wp-config.php
sed -i "/NONCE_SALT/d" /var/www/wordpress/wp-config.php
sed -i "49 r /tmp/wp.keys" /var/www/wordpress/wp-config.php

echo "✔️ wp-config.php created!"
fi

# Correct permissions
chown -R www-data:www-data /var/www/wordpress

echo "🚀 Starting PHP-FPM..."

# Run PHP-FPM in foreground (PID 1)
exec php-fpm7.4 -F
