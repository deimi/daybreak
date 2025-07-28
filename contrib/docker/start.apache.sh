#!/bin/bash

# Create storage tree if needed and fix permissions
cp -r storage.skel/* storage/
chown -R www-data:www-data storage/ bootstrap/

# Refresh environment
php artisan route:cache
php artisan view:cache
php artisan config:cache

# do migrations
touch $DB_DATABASE
chown -R www-data:www-data $DB_DATABASE
php artisan migrate --force

# Run Apache in foreground
apache2-foreground
