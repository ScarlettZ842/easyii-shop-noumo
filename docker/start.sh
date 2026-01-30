#!/bin/bash
set -e

# Install Composer dependencies if vendor/autoload.php doesn't exist
if [ ! -f "/var/www/html/vendor/autoload.php" ]; then
    echo "Installing Composer dependencies..."
    cd /var/www/html
    
    # Install with dev dependencies for debug module
    composer install --no-interaction --prefer-dist || true
fi

# Create symlinks for bower and npm assets (asset-packagist.org uses different naming)
if [ -d "/var/www/html/vendor/bower-asset" ] && [ ! -L "/var/www/html/vendor/bower" ]; then
    echo "Creating bower-asset symlink..."
    ln -s bower-asset /var/www/html/vendor/bower
fi
if [ -d "/var/www/html/vendor/npm-asset" ] && [ ! -L "/var/www/html/vendor/npm" ]; then
    echo "Creating npm-asset symlink..."
    ln -s npm-asset /var/www/html/vendor/npm
fi

# Fix permissions for runtime directories
echo "Setting up permissions..."
mkdir -p /var/www/html/runtime /var/www/html/uploads /var/www/html/assets /var/www/html/app/web/assets
chmod -R 777 /var/www/html/runtime /var/www/html/uploads /var/www/html/assets /var/www/html/app/web/assets
chown -R www-data:www-data /var/www/html

echo "Starting Apache..."
apache2-foreground
