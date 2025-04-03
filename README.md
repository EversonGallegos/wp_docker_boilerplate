# WordPress Docker Boilerplate

This is a modern WordPress development environment using Docker, Composer, and Nginx. This setup is designed to provide a consistent and isolated development environment with easy setup and configuration.

## Features

- WordPress installed via Composer
- PHP 8.1 with all required extensions
- MySQL 8.0 database
- Nginx web server
- Automatic WordPress configuration
- Persistent database storage
- Proper development environment

## Prerequisites

- Docker and Docker Compose
- Git
- Composer (optional, handled in Docker)

## Getting Started

### Clone the Repository

```bash
git clone <repository-url>
cd <repository-directory>
```

### Starting the Environment

```bash
# Create src directory if it doesn't exist
mkdir -p src

# Start MySQL and create the database
./db-setup.sh

# Start all services
docker-compose up -d
```

Access WordPress at [http://localhost](http://localhost)

### Stopping the Environment

```bash
docker-compose down
```

To remove all data including the database volume:

```bash
docker-compose down -v
```

## Project Structure

```
.
├── docker-compose.yml     # Docker Compose configuration
├── Dockerfile             # PHP/WordPress container definition
├── composer.json          # Composer dependencies and scripts
├── nginx/                 # Nginx configuration files
│   └── conf.d/
│       └── default.conf
├── src/                   # WordPress core files
│   └── wp-content/        # Themes, plugins, and uploads
├── db-setup.sh            # Database setup script
└── create-wp-config.sh    # WordPress configuration script
```

## Configuration

### WordPress

The WordPress configuration is managed through environment variables in `docker-compose.yml` and the `create-wp-config.sh` script. You can modify the following settings:

- Database credentials
- WordPress URL and site URL
- WordPress debug settings
- Table prefix

### Database

Database configuration is set in `docker-compose.yml`:

- Host: mysql
- Port: 3306
- Name: wordpress
- User: wordpress
- Password: wordpress

### Web Server

Nginx is configured to serve WordPress from the `src` directory. The configuration file is located at `nginx/conf.d/default.conf`.

## Development Workflow

1. Add custom themes and plugins to `src/wp-content/`
2. Code changes are reflected immediately without container restarts
3. Database changes persist across container restarts

## Adding Plugins and Themes

### Via WordPress Admin

You can install plugins and themes directly through the WordPress admin interface.

### Via Composer

Add WordPress plugins from the WordPress Packagist repository in your `composer.json` file:

```json
"require": {
    "roots/wordpress": "^6.7",
    "roots/wordpress-core-installer": "^1.100",
    "roots/wordpress-no-content": "^6.7",
    "wpackagist-plugin/plugin-name": "version"
}
```

## Troubleshooting

### Database Connection Issues

If WordPress cannot connect to the database:

1. Check if the MySQL container is running: `docker-compose ps`
2. Verify database credentials in `src/wp-config.php`
3. Try running `./db-setup.sh` to ensure the database exists

### File Permission Issues

If you encounter permission issues:

```bash
docker-compose exec wordpress chown -R www-data:www-data /var/www/html
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the [MIT License](LICENSE). 