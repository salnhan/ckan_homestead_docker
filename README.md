# ckan_homestead_docker
Development Environment built with Docker
Repository on github: https://github.com/salnhan/ckan_homestead_docker.git

## Startup local development

In the Project root folder
* create temp/ folder
* run `docker-compose up`
* After startup open `http://localhost:8000`

## Rebuild a base container i.e. ckan_app

In the Project root folder:
* run `docker-compose stop ckan_app`
* run `docker-compose rm -f ckan_app`
* run `docker-compose up -d --build --no-recreate ckan_app`

# Install appropriate CKAN Version

Change the value of variable `` in `dockfiles/ckan/Dockerfile`



## Config in local development

* Gurnicorn: server
* Supervisor: automatically restart gurnicorn, harvest_gather_stage

## Supervisor
* Status: `supervisorctl /app/config/supervisor/supervisord_docker.conf status`
* remove all tasks : `supervisorctl /app/config/supervisor/supervisord_docker.conf remove all`
* reload supervisor: `supervisorctl /app/config/supervisor/supervisord_docker.conf status`

## Solr
* URL: http://solr:8983/solr/ckan

## Redis
* URL: redis://localhost:6379/0

## Mailhog
* URL: http://localhost:8025