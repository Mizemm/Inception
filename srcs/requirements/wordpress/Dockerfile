FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    default-mysql-client \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/php

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY tools/script.sh /tools/script.sh
RUN chmod +x /tools/script.sh

EXPOSE 9000
CMD ["/tools/script.sh"]