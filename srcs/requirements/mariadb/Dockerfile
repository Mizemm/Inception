FROM debian:bullseye

RUN apt -y update && apt upgrade -y

RUN apt -y install mariadb-server 


# COPY ./tools/my-config.conf /tmp/my-config.conf
COPY ./tools/script.sh  /tmp/script.sh

RUN chmod +x /tmp/script.sh

# declare that the container listens on port 3306, so other containers can connect to it.
EXPOSE 3306

ENTRYPOINT ["/bin/bash","/tmp/script.sh"]

# allows MariaDB to accept connections from other Docker containers on the same network
# which is required for WordPress to connect to it.
CMD ["mariadbd","--bind-address=0.0.0.0"]