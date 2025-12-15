# User Documentation

## Overview

This project provides a simple web stack using Docker:

* **NGINX**: Web server (HTTPS)
* **WordPress**: Website and admin interface
* **MariaDB**: Database for WordPress

All services run in separate containers and communicate through Docker.

---

## Start and Stop the Project

Start the project:

```bash
make up
```

Stop the project:

```bash
make clean
```

Remove containers and stored data:

```bash
make fclean
```

---

## Accessing the Website

* Website: `https://localhost`
* WordPress Admin Panel: `https://localhost/wp-admin`

Log in using the WordPress admin credentials defined in the environment variables.

---

## Credentials Management

Credentials are stored in environment variables defined in the `.env` file:

* Database name
* Database user and password
* WordPress admin user and password

These variables are injected into containers at startup.

---

## Checking Services Status

Check running containers:

```bash
docker ps
```

View logs:

```bash
docker compose logs
```

If all containers are running and accessible via HTTPS, the stack is working correctly.
