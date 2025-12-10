FROM debian:bullseye


# this line is for updating packages and installing mysql, mariadb tools
RUN apt-get update && apt-get install -y mariadb-server


# this line is for copying my settings into mariadb dafault container settings
COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.conf


# this line copy the script file to the root directory, so when script is called it setup mariadb before it runs
COPY tools/script.sh /


# this line runs the script
CMD [/tools/script.sh]
