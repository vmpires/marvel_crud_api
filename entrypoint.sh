#!/bin/sh

# Docker entrypoint script.

# Wait until Postgres is ready before running the next step.
while ! pg_isready -q -h $DB_HOST -p $DB_PORT -U $DB_USERNAME
do
  echo "$(date) - waiting for database to start."
  sleep 2
done

# If the database exists, migrate. Otherwise setup (create and migrate)
echo "Running database migrations..."
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create db:migrate db:seed
echo "Finished running database migrations."

# Remove a potentially pre-existing server.pid for Rails.
echo "Deleting server.pid file..."
rm -f /tmp/pids/server.pid

# Start the server.
echo "Starting rails server..."
bundle exec rails server