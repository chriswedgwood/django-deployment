#!/usr/bin/env bash
#wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/chriswedgwood/django-deployment/master/setup_gunicorn.sh
echo -e "#!/bin/bash

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

echo -e "
upstream app_server {
    server unix:/home/pcndodger/run/gunicorn.sock fail_timeout=0;
}

server {
    listen 80;

    # add here the ip address of your server
    # or a domain pointing to that ip (like example.com or www.example.com)
    server_name 178.62.60.159;

    keepalive_timeout 5;
    client_max_body_size 4G;

    access_log /home/pcndodger/logs/nginx-access.log;
    error_log /home/pcndodger/logs/nginx-error.log;

    location /static/ {
        alias /home/pcndodger/pcndodger/staticfiles/;
    }

    # checks for static file, if not found proxy to app
    location / {
        try_files \$uri @proxy_to_app;
    }

    location @proxy_to_app {
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header Host \$http_host;
      proxy_redirect off;
      proxy_pass http://app_server;
    }
}
" > /etc/nginx/sites-available/pcndodger

sudo ln -s /etc/nginx/sites-available/pcndodger /etc/nginx/sites-enabled/pcndodger
sudo rm /etc/nginx/sites-enabled/default
sudo service nginx restart

