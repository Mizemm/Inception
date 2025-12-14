# FROM debian:bullseye


# # this line is for updating packages and installing mysql, mariadb tools
# RUN apt-get update && apt-get install -y mariadb-server

# # Ensure runtime directory exists with correct permissions
# RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# # this line is for copying my settings into mariadb dafault container settings
# COPY conf/my-config.conf /etc/mysql/mariadb.conf.d/my-config.cnf


# # this line copy the script file to the root directory, so when script is called it setup mariadb before it runs
# COPY tools/script.sh /tools/script.sh
# RUN chmod +x /tools/script.sh

# CMD ["tail", "-f", "/dev/null"]

FROM debian:bullseye

RUN apt -y update && apt upgrade -y

RUN apt -y install mariadb-server 


# COPY ./tools/my-config.conf /tmp/my-config.conf
COPY ./tools/script.sh  /tmp/script.sh

RUN chmod +x /tmp/script.sh

EXPOSE 3306

ENTRYPOINT ["/bin/bash","/tmp/script.sh"]

CMD ["mariadbd","--bind-address=0.0.0.0"]