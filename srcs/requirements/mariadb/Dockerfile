FROM debian:bullseye

RUN apt -y update && apt upgrade -y

RUN apt -y install mariadb-server 


# COPY ./tools/my-config.conf /tmp/my-config.conf
COPY ./tools/script.sh  /tmp/script.sh

RUN chmod +x /tmp/script.sh

EXPOSE 3306

ENTRYPOINT ["/bin/bash","/tmp/script.sh"]

CMD ["mariadbd","--bind-address=0.0.0.0"]