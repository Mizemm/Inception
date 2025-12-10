FROM debian:bullseye


# this line is for updating packages and installing php-fpm and php-mysql packages
RUN apt-get update && 
# php-fpm (FastCGI Process Manager) is used to execute PHP scripts
RUN apt-get install -y php-fpm 
# php-mysql allows PHP to communicate with MySQL databases
RUN apt-get install -y php-mysql
# curl package is for transferring data using various network protocols, including HTTP, HTTPS, and FTP.
RUN apt install curl -y


# this is for copying our settings in thew wordpress .sh file
COPY tools/start.sh /
# this is for copying our settings in thew wordpress .php file
COPY tools/wp-config.php /


# this is for running the script
CMD [/tools/start.sh]