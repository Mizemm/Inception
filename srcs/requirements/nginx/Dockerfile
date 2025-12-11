FROM debian:bullseye

# Install nginx + openssl to generate ssl cert
RUN apt update && apt install -y nginx openssl

# Generating SSL certificates
# -509: create a self-signed certificate (not from a real authority)
# -nodes: no password on the key
# -days 365: certificate valid for 1 year
# -newkey rsa:2048: generate a new RSA 2048-bit key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    # Saves the private key file here that NGINX uses to encrypt HTTPS.
    -keyout /etc/ssl/private/mizem.key \
    # Save what browsers read when connecting to your site.
    -out /etc/ssl/certs/mizem.crt \
    -subj "/C=MA/ST=Tetouan/L=Tetouan/O=1337/OU=mizem/CN=mizem.42.fr"

# copying my own SETTINGS into nginx default direc
COPY conf/default /etc/nginx/sites-available/default

RUN chmod +x /etc/nginx/sites-available/default
# Start Nginx in foreground so the container doesnt quit
CMD ["nginx", "-g", "daemon off;"]
