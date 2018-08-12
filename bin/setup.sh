#!/bin/sh

#cp /build/config/docker.ini /app/config/docker.ini
#cp /build/ckanconfig.json /app/ckanconfig.json
#cp /build/config/supervisor/supervisord_docker.conf /app/config/supervisor/supervisord_docker.conf

#ckanbuilder install extensions
#ckanbuilder build assets
#ckanbuilder configure plugins --configini_file /app/config/environment/docker.ini

supervisorctl -c /app/config/supervisor/supervisord_docker.conf restart gunicorn
