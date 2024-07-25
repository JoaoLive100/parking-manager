#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /parking-manager/tmp/pids/server.pid

# Executa as migrações do banco de dados e inicializa com dados seed
bundle exec rails db:migrate
bundle exec rails db:seed

# Executa o comando principal (Rails server)
exec "$@"
