# Quick Start Guide

This guide will help you quickly set up a WordPress development environment using Docker.

## Prerequisites

- Docker and Docker Compose installed

## Steps

### 1. Clone the repository

```bash
git clone <repository-url>
cd <repository-directory>
```

### 2. Create required directories

```bash
mkdir -p src
```

### 3. Set up the database and WordPress config

```bash
./db-setup.sh
./create-wp-config.sh
```

### 4. Start the Docker environment

```bash
docker-compose up -d
```

### 5. Access WordPress

Open [http://localhost](http://localhost) in your browser

Complete the WordPress installation process by following the on-screen instructions.

## Common Commands

### Start all services
```bash
docker-compose up -d
```

### Stop all services
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f
```

### Access WordPress container shell
```bash
docker-compose exec wordpress bash
```

### Access MySQL
```bash
docker-compose exec mysql mysql -uwordpress -pwordpress wordpress
```

## Default Credentials

### WordPress Database
- Host: mysql
- Port: 3306
- Database: wordpress
- Username: wordpress
- Password: wordpress

## File Locations

- WordPress files: `./src/`
- WordPress content: `./src/wp-content/`
- Nginx config: `./nginx/conf.d/default.conf`
- WordPress config: `./src/wp-config.php` 