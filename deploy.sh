#!/bin/bash

# Stop on error
set -e

echo "🚀 Starting deployment script based on README.md..."

# 1. Install PHP dependencies
echo "📦 Installing PHP dependencies..."
composer install

# 2. Install JavaScript dependencies
echo "📦 Installing JavaScript dependencies..."
npm install

# 3. Set up environment
if [ ! -f ".env" ]; then
    echo "⚙️ Setting up environment file..."
    cp .env.example .env
    php artisan key:generate
else
    echo "✅ .env file already exists."
fi

# 4. Database Migrations
echo "🗄️ Running migrations..."
php artisan migrate --force

# 5. Build assets
echo "🏗️ Building assets..."
npm run build

# 6. Optimize for Production
echo "🚀 Optimizing for Production..."
php artisan optimize:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "✅ Deployment finished successfully!"

# 7. Start the server (Commented out for Nginx environments)
# echo "🚀 Starting server on PORT 8080..."
# php artisan serve --port=8080
