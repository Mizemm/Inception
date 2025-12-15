FROM debian:bullseye

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl


# -Generate a self-signed SSL certificate
# -x509        → create an X.509 certificate (self-signed)
# -nodes       → do not encrypt the private key (required for Nginx auto-start)
# -days 365    → certificate validity period (1 year)
# -newkey rsa:2048 → generate a new 2048-bit RSA key
# -keyout      → path where the private key is stored
# -out         → path where the certificate is stored
# -subj        → defines certificate identity non-interactively
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MA/ST=Kenitra/L=Keni/O=42/CN=mizem.42.fr"

# Copy the custom Nginx server configuration
COPY conf/default /etc/nginx/sites-available/default

# Enable the Nginx configuration i just copied by creating a symbolic link
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default


# Document that the container listens on port 443 (HTTPS)
EXPOSE 443

# Start Nginx in the foreground
# 'daemon off;' is required so Docker keeps the container running
CMD ["nginx", "-g", "daemon off;"]