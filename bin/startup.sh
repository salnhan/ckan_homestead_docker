#!/bin/sh

set -eu -o pipefail

export config_file="config/environment/${environment}.ini"

echo "Waiting for other services to start ckan"

echo "Waiting for solr"
until $(nc -zv solr 8983); do
    printf '.'
    sleep 5
done

echo "Waiting for postgres"
until $(nc -zv db 5432); do
    printf '.'
    sleep 5
done

echo "Waiting for redis"
until $(nc -zv redis 6379); do
    printf '.'
    sleep 5
done

echo "All services are up starting ckan..."

echo "creating folder /var/log/ckan"
mkdir -p /var/log/ckan

echo "creating app.log"
touch /var/log/ckan/app.log

echo "creating gather_consumer.log"
touch /var/log/ckan/gather_consumer.log

echo "creating fetch_consumer.log"
touch /var/log/ckan/fetch_consumer.log

echo "creating supervisord_stdout.log"
touch /var/log/ckan/supervisord_stdout.log

echo "creating supervisord_stderr.log"
touch /var/log/ckan/supervisord_stderr.log

echo "Initialise Database"
if [ $init_database -eq 1 ]; then
    echo "start initialise"
    paster --plugin=ckan db init -c ${config_file}
else
    echo "Skipping database initialisation"
fi

echo "Install Extensions"
bash /app/bin/setup.sh

echo "Start Supervisord"
supervisord -n -c /app/config/supervisor/supervisord_docker.conf
