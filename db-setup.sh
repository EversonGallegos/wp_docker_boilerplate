#!/bin/bash

DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress"
SERVER_URL="http://localhost"

# Function to check if containers are running
check_containers() {
    if [ "$(docker-compose ps -q mysql)" ]; then
        echo "✅ MySQL container is running"
    else
        echo "❌ MySQL container is not running"
        echo "Starting MySQL container..."
        docker-compose up -d mysql
        sleep 5  # Give it time to start
    fi
}

# Start containers if they're not running
check_containers

# Connect to MySQL and check if WordPress database exists
echo "Checking for WordPress database..."
DB_EXISTS=$(docker-compose exec mysql mysql -uroot -proot -e "SHOW DATABASES LIKE '$DB_NAME';" | grep -c "$DB_NAME")

if [ "$DB_EXISTS" -gt 0 ]; then
    echo "✅ WordPress database exists"
else
    echo "❌ WordPress database doesn't exist"
    echo "Creating WordPress database..."
    docker-compose exec mysql mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
    docker-compose exec mysql mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
    docker-compose exec mysql mysql -uroot -proot -e "FLUSH PRIVILEGES;"
    echo "✅ WordPress database created"
fi

# Display database connection info
echo "
Database connection information:
-------------------------------
Host: mysql
Port: 3306
Database: $DB_NAME
Username: $DB_USER
Password: $DB_PASSWORD
"

echo "Would you like to start all services? (y/n)"
read -r START_ALL

if [ "$START_ALL" = "y" ]; then
    docker-compose up -d
    echo "✅ All services started"
    echo "Access WordPress at $SERVER_URL"
fi 