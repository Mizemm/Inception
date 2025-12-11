FROM debian:bullseye


# this line is for updating packages and installing mysql, mariadb tools
RUN apt-get update && apt-get install -y mariadb-server

# Ensure runtime directory exists with correct permissions
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# this line is for copying my settings into mariadb dafault container settings
COPY conf/my-config.conf /etc/mysql/mariadb.conf.d/my-config.cnf


# this line copy the script file to the root directory, so when script is called it setup mariadb before it runs
COPY tools/script.sh /tools/script.sh
RUN chmod +x /tools/script.sh

# this line runs the script
CMD ["/tools/script.sh"]
