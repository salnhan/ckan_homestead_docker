#!/bin/bash

# Restore database
DB_FILE=$1
DB_NAME=$2
DB_USER=$3
CONFIG_FILE=$4
DB_CUSTOM_FORMAT=$5

# check if DB_FILE and $CONFIG_FILE not empty
if [[ ! -z "${DB_FILE}" || ! -z "${CONFIG_FILE}" ]]; then
    # check if the database file and config file exists
    if [ -f "${DB_FILE}" ]; then
        if  [  -f "${CONFIG_FILE}" ] ; then
            echo "clean the current database"
            paster --plugin=ckan db clean -c ${CONFIG_FILE}
            echo "Restoring the database ..."
            # decides restore method for the dump
            # Uses pg_restore if the dump has custom format
            if [[ ! -z "${DB_CUSTOM_FORMAT}" && ${DB_CUSTOM_FORMAT} -eq 1 ]]; then
                cat ${DB_FILE} | pg_restore -U ${DB_USER} -d ${DB_NAME} -h db
            else
                # otherwise uses psql
                cat ${DB_FILE} | psql -U ${DB_USER} -d ${DB_NAME} -h db
            fi
            echo "Indexing the dataset"
            paster --plugin=ckan search-index rebuild -c ${CONFIG_FILE}
        else
            echo "File ${CONFIG_FILE} not found"
        fi
    else
        echo "File ${DB_FILE} not found"
    fi
else
    echo "DB_FILE or CONFIG_FILE must not be empty"
fi