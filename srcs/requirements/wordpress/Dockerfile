FROM debian:bullseye

RUN apt -y update && apt upgrade -y \
    && apt install -y php-fpm \
    php-mysql \
    bash \
    wget \
    unzip \
    curl \
    less \
    vim \
    mariadb-client

# Downloads and installs WP-CLI → allows wp core install, wp user create, in your script.
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Set working directory
WORKDIR /var/www/html/

# Copy and make the script executable
COPY ./tools/script.sh /usr/local/bin/wp-conf.sh
RUN chmod +x /usr/local/bin/wp-conf.sh


# listens on port 9000 for FastCGI requests
EXPOSE 9000

# Use absolute path for ENTRYPOINT
ENTRYPOINT ["/usr/local/bin/wp-conf.sh"]
