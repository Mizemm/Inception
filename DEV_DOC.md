# Developer Documentation

## Environment Setup

### Prerequisites
* Linux system
* Docker
* Docker Compose
* Make
Ensure Docker is running before starting the project.

---

## Project Configuration
* Dockerfiles define each service (NGINX, WordPress, MariaDB)
* `docker-compose.yml` orchestrates services and networking
* `.env` file stores configuration values and credentials

---

## Build and Launch
Build and start the project:
```bash
make up
```
Rebuild everything:
```bash
make re
```

---

## Container and Volume Management
List containers:
```bash
docker ps -a
```

Stop and remove containers:
```bash
docker compose down
```

Remove volumes:
```bash
docker compose down -v
```

---

## Data Persistence
Project data is stored using bind mounts:
* WordPress files: `~/data/wordpress`
* MariaDB data: `~/data/mariadb`
These directories persist data even after containers are stopped or rebuilt.
