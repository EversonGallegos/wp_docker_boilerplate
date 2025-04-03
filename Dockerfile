FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Configure Git to trust the directory
RUN git config --global --add safe.directory /var/www/html

# Create directories
RUN mkdir -p src/wp-admin src/wp-includes src/wp-content

# Copy composer files
COPY composer.json composer.lock ./

# Install dependencies with scripts
RUN composer install

# Copy the rest of the application code
COPY . .

# Create wp-config.php from the sample config
RUN ./db-setup.sh

RUN ./create-wp-config.sh

# Generate optimized autoloader
RUN composer dump-autoload --optimize

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]
