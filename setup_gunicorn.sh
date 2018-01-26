#!/usr/bin/env bash
#wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/chriswedgwood/django-deployment/master/setup_gunicorn.sh
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

cd \$DIR
source ../bin/activate

export DJANGO_SETTINGS_MODULE=\$DJANGO_SETTINGS_MODULE
export PYTHONPATH=\$DIR:\$PYTHONPATH

exec ../bin/gunicorn \${DJANGO_WSGI_MODULE}:application \
  --name \$NAME \\
  --workers \$WORKERS \\
  --user=\$USER \\
  --group=\$GROUP \\
  --bind=\$BIND \\
  --log-level=\$LOG_LEVEL \\
  --log-file=-"  > /home/pcndodger/bin/gunicorn_start


chmod u+x bin/gunicorn_start

mkdir run


mkdir logs

touch logs/gunicorn-error.log

echo -e "
[program:pcndodger]
command=/home/pcndodger/bin/gunicorn_start
user=pcndodger
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/home/pcndodger/logs/gunicorn-error.log " > /etc/supervisor/conf.d/pcndodger.conf

sudo supervisorctl reread
sudo supervisorctl update