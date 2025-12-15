#!/bin/bash

# service mariadb start

# # service mysql start
# mysql -h localhost -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
# mysql -h localhost -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
# mysql -h localhost -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
# # mysql -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "ALTER USER '$MYSQL_ROOT_PASSWORD'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
# mysql -h localhost -e "FLUSH PRIVILEGES;"
# mysqladmin -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD shutdown


# exec mysqld --console

service mariadb start
# sleep 3


mariadb -h localhost -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mariadb -h localhost -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -h localhost -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
mariadb -h localhost -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

exec "$@"