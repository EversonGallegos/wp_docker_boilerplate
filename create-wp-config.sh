#!/bin/bash

# Define the configuration
WP_CONFIG_PATH="./src/wp-config.php"
WP_CONFIG_SAMPLE="./src/wp-config-sample.php"
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress"
DB_HOST="mysql"
DB_CHARSET="utf8"
DB_COLLATE=""
TABLE_PREFIX="wp_"
WP_HOME="http://localhost"
WP_SITEURL="http://localhost"

# Fetch WordPress salts
echo "Fetching WordPress salts..."
SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

# Create wp-config.php
echo "Creating wp-config.php..."
cat > "$WP_CONFIG_PATH" << EOL
<?php
/**
 * The base configuration for WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '$DB_NAME' );

/** Database username */
define( 'DB_USER', '$DB_USER' );

/** Database password */
define( 'DB_PASSWORD', '$DB_PASSWORD' );

/** Database hostname */
define( 'DB_HOST', '$DB_HOST' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', '$DB_CHARSET' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '$DB_COLLATE' );

define( 'WP_HOME', '$WP_HOME' );
define( 'WP_SITEURL', '$WP_SITEURL' );

/**#@+
 * Authentication unique keys and salts.
 */
$SALTS

/**#@-*/

/**
 * WordPress database table prefix.
 */
\$table_prefix = '$TABLE_PREFIX';

/**
 * For developers: WordPress debugging mode.
 */
define( 'WP_DEBUG', true );

/* Add any custom values between this line and the "stop editing" line. */

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOL

echo "✅ wp-config.php created successfully!" 