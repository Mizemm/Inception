# Makefile for Inception WordPress Docker setup
# Works with srcs/docker-compose.yml and bind mounts

# Variables
DOCKER_COMPOSE=docker compose -f srcs/docker-compose.yml
WP_DATA=${HOME}/data/wordpress
DB_DATA=${HOME}/data/mariadb

.PHONY: up down restart rebuild clean logs

# Start containers (detached)
up:
	$(DOCKER_COMPOSE) up --build

# Stop containers
down:
	$(DOCKER_COMPOSE) down

# Restart containers
restart: down up

# Rebuild containers
rebuild:
	$(DOCKER_COMPOSE) build --no-cache
	$(DOCKER_COMPOSE) up -d

# Follow logs
logs:
	$(DOCKER_COMPOSE) logs -f

# Full reset: stop containers + remove volumes + clear host data
clean:
	@echo "[INFO] Stopping containers and removing volumes..."
	$(DOCKER_COMPOSE) down -v
	@echo "[INFO] Resetting WordPress and MariaDB host data..."
	# Fix ownership and remove WordPress files
	sudo chown -R $(USER):$(USER) $(WP_DATA)
	sudo rm -rf $(WP_DATA)/*
	# Fix ownership and remove MariaDB files
	sudo chown -R $(USER):$(USER) $(DB_DATA)
	sudo rm -rf $(DB_DATA)/*
	@echo "[INFO] Reset complete. You can now run 'make up'."
