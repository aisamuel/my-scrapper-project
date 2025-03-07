#!/bin/sh

echo "Waiting for PostgreSQL database..."
while ! nc -z "$POSTGRES_HOST" "${POSTGRES_PORT:-5432}"; do
  sleep 1
done
echo "PostgreSQL is ready!"

# Apply migrations
echo "Applying database migrations..."
python manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Start Gunicorn server
echo "Starting Gunicorn server..."
exec gunicorn -b 0.0.0.0:8000 product_scraper.wsgi:application
