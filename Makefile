# Makefile for Inception WordPress Docker setup
# Works with srcs/docker-compose.yml and bind mounts

# Variables
DOCKER_COMPOSE=docker compose -f srcs/docker-compose.yml
WP_DATA=${HOME}/data/wordpress
DB_DATA=${HOME}/data/mariadb

all: up

# Create bind-mount directories
dirs:
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	sudo chown -R $(USER):$(USER) $(HOME)/data
	sudo chmod -R 755 $(HOME)/data

# Starting containers
up:dirs
	@echo "Starting ..."
	$(DOCKER_COMPOSE) up --build

# Follow logs
logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	@echo "Cleaning ..."
	$(DOCKER_COMPOSE) down -v

fclean: clean
	@echo "Full cleaning..."
# 	sudo chown -R $(USER):$(USER) $(WP_DATA)
	sudo rm -rf $(WP_DATA)
# 	sudo chown -R $(USER):$(USER) $(DB_DATA)
	sudo rm -rf $(DB_DATA)

re: fclean all

.PHONY: up down restart rebuild clean logs
