FROM python:2.7-alpine3.7
LABEL name="CKAN Base" version="1.0.0"

ENV environment=development \
ckan_version=2.7.4 \
init_database=true

VOLUME /app/uploads
VOLUME /app/extensions
VOLUME /app/bin
VOLUME /app/temp
VOLUME /build

WORKDIR /app

COPY ./ ./
RUN apk update && apk add postgresql-dev postgresql-client git gcc linux-headers libmagic musl-dev bash libxslt-dev libxml2-dev
RUN pip install setuptools==20.4 \
    && pip install gunicorn==19.7.1 \
    && pip install supervisor==3.3.3 \
    && pip install superlance==1.0.0

# install CKAN
RUN pip install -e "git+https://github.com/ckan/ckan.git@ckan-${ckan_version}#egg=ckan" --src ./ \
    && pip install -r ./dockerfiles/ckan/requirements/requirements.txt
    && pip uninstall -y python-magic \
    && pip install python-magic==0.4.13

ENTRYPOINT bash /app/bin/startup.sh