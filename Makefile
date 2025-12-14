# Makefile for Inception WordPress Docker setup

# Variables
DOCKER_COMPOSE=docker compose -f srcs/docker-compose.yml
WP_DATA=${HOME}/data/wordpress
DB_DATA=${HOME}/data/mariadb

.PHONY: up down restart rebuild clean logs

# Start containers (detached)
up:
	$(DOCKER_COMPOSE) up -d

# Stop containers
down:
	$(DOCKER_COMPOSE) down

# Restart containers
restart: down up

# Rebuild containers
rebuild:
	$(DOCKER_COMPOSE) build --no-cache
	$(DOCKER_COMPOSE) up -d

# View logs
logs:
	$(DOCKER_COMPOSE) logs -f

# Full reset: stop containers + remove volumes + clear host data
clean:
	$(DOCKER_COMPOSE) down -v
	@echo "[INFO] Removing host WordPress and MariaDB data..."
	rm -rf $(WP_DATA)/*
	rm -rf $(DB_DATA)/*
	@echo "[INFO] Reset complete. You can now run 'make up'."
