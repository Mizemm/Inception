!/bin/bash


# Before MariaDB really starts we need to :
# Create a database
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_NAME ;" > db1.sql
# Create a user
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db1.sql
# Give that user permissions
echo "GRANT ALL PRIVILEGES ON $MYSQL_NAME.* TO '$MYSQL_USER'@'%' ;" >> db1.sql
# Change root password
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> db1.sql
# Save changes
echo "FLUSH PRIVILEGES;" >> db1.sql


#runs the SQL file once to initialize the database without starting the full MariaDB server.
mysqld --bootstrap --user=mysql < db1.sql


# starts the maria db server as pid1, and prints the errors in terminal so docker can handle them
exec mysqld --console