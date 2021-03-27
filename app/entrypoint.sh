#!/bin/sh

# Verify Postgres is healthy before applying the 
# migrations and running the 
# Django development server:

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# You may want to comment out the database flush and migrate commands in the entrypoint.sh script so they don't run on every container start or re-start:
# python manage.py flush --no-input
# python manage.py migrate

# Instead, you can run them manually, after the containers spin up, like so:
# docker-compose exec web python manage.py flush --no-input
# docker-compose exec web python manage.py migrate


exec "$@"