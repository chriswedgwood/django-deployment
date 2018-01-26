#!/usr/bin/env bash

echo -e "

#!/bin/bash

NAME='pcndodger'
DIR=/home/pcndodger/pcndodger
USER=pcndodger
GROUP=pcndodger
WORKERS=3
BIND=unix:/home/pcndodger/run/gunicorn.sock
DJANGO_SETTINGS_MODULE=config.settings.production
DJANGO_WSGI_MODULE=config.wsgi
LOG_LEVEL=error

cd $DIR
source ../bin/activate

export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DIR:$PYTHONPATH

exec ../bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $WORKERS \
  --user=$USER \
  --group=$GROUP \
  --bind=$BIND \
  --log-level=$LOG_LEVEL \
  --log-file=-" > /home/pcndodger/bin/gunicorn_start
