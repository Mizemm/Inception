*This project has been created as part of the 42 curriculum by mizem.*

# Inception

## Description

**Inception** is a DevOps project focused on learning **Docker** and containerization. The goal is to set up a small infrastructure composed of **NGINX**, **WordPress**, and **MariaDB**, each running in its own Docker container and orchestrated with **Docker Compose**.

The project emphasizes service isolation, container networking, environment-based configuration, and persistent data management.

---

## Instructions

### Requirements

* Docker
* Docker Compose
* Make

### Run the project

```bash
make up
```

### Stop containers

```bash
make clean
```

### Full cleanup (containers + data)

```bash
make fclean
```

### Rebuild from scratch

```bash
make re
```

---

## Docker Usage & Design Choices

* **Docker** is used instead of virtual machines for its lightweight nature, fast startup, and efficient resource usage.
* **Environment variables** are used to configure services (database name, users, passwords). Docker secrets are more secure but unnecessary for this educational project.
* A **custom Docker network** is used to allow container-to-container communication while keeping services isolated from the host.
* **Bind mounts** are used to persist WordPress and MariaDB data on the host filesystem.

### Comparisons

* **Virtual Machines vs Docker**: VMs run full operating systems, while Docker containers share the host kernel and are lighter.
* **Secrets vs Environment Variables**: Secrets are safer for production; environment variables are simpler and sufficient here.
* **Docker Network vs Host Network**: Docker networks provide isolation; host networking removes it.
* **Docker Volumes vs Bind Mounts**: Volumes are Docker-managed; bind mounts give direct access to host files.

---

## Resources

* Docker Documentation
* Docker Compose Documentation
* NGINX Documentation
* WordPress Codex
* MariaDB Documentation

### AI Usage

AI tools were used to help understand Docker concepts, debug configuration issues, and improve documentation clarity.
