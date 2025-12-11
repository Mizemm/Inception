#!/bin/bash


# Ensure data directory exists
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql


# Before MariaDB really starts we need to :
# Create a database
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" > db.sql

# Create a user
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db.sql

# Give that user permissions
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;" >> db.sql

# Change root password
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> db.sql

# Save changes
echo "FLUSH PRIVILEGES;" >> db.sql


# starts the maria db server as pid1, and prints the errors in terminal so docker can handle them
exec mysqld --console
