# FROM debian:bullseye

# RUN apt-get update && apt-get install -y \
#     php-fpm \
#     php-mysql \
#     default-mysql-client \
#     curl \
#     && rm -rf /var/lib/apt/lists/* \
#     && mkdir -p /run/php

# # Install WP-CLI
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp



# COPY tools/script.sh /tools/script.sh
# RUN chmod +x /tools/script.sh

# EXPOSE 9000
# CMD ["/tools/script.sh"]



FROM debian:bullseye

RUN apt -y update && apt upgrade -y\
    && apt install -y php-fpm \
    php-mysql \
    bash \
    wget \
    unzip \
    curl \
    less \
    vim \
    mariadb-client


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/

COPY ./tools/script.sh wp-conf.sh  

RUN chmod +x wp-conf.sh

EXPOSE 9000

ENTRYPOINT ["./wp-conf.sh"]