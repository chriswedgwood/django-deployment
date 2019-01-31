#!/usr/bin/env bash

CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}####STARTING SETUP####${NC}"

source ~/.env
USER=$(whoami)
echo "USER NAME:"$USER
echo "APPLICATION:"$APPLICATION

TODAY=`date '+%Y%m%d%H%M%S'`;
echo -e "${CYAN}####CREATING APPLICATION $APPLICATION$TODAY ####${NC}"
mkdir ~/$APPLICATION$TODAY
cd ~/$APPLICATION$TODAY
mkdir ~/logs
echo -e "${CYAN}####CLONING git@github.com:chriswedgwood/$APPLICATION.git ####${NC}"
git clone git@github.com:chriswedgwood/$APPLICATION.git

echo -e "${CYAN}####CREATING VIRTUALENV venv ####${NC}"

virtualenv venv -p python3.6

echo -e "${CYAN}####ACTIVATING VIRTUALENV venv ####${NC}"

source venv/bin/activate


pwd
echo -e "${CYAN}####INSTALL REQUIREMENTS####${NC}"

pip install -r $APPLICATION/requirements/production.txt

echo -e "${CYAN}####INSTALL NODE MODULES####${NC}"
cd $APPLICATION/frontend

npm install


cd $APPLICATION
echo -e "${CYAN}####RUN MIGRATIONS####${NC}"


python manage.py migrate --settings config.settings.production
echo -e "${CYAN}####COLLECT STATIC FILES####${NC}"

python manage.py collectstatic --noinput --settings config.settings.production
#python manage.py createsuperuser

echo -e "${CYAN}####SETUP GUNICORN####${NC}"

echo -e "#!/bin/bash

NAME='$APPLICATION'
DIR=/home/$USER/$APPLICATION$TODAY/$APPLICATION
USER=$APPLICATION
GROUP=$APPLICATION
WORKERS=3
BIND=unix:/home/$USER/$APPLICATION$TODAY/run/gunicorn.sock
DJANGO_SETTINGS_MODULE=config.settings.production
DJANGO_WSGI_MODULE=config.wsgi
LOG_LEVEL=debug

cd \$DIR
source ../venv/bin/activate
source /home/$APPLICATION/.env

export DJANGO_SETTINGS_MODULE=\$DJANGO_SETTINGS_MODULE
export PYTHONPATH=\$DIR:\$PYTHONPATH

exec ../venv/bin/gunicorn \${DJANGO_WSGI_MODULE}:application \
  --name \$NAME \\
  --workers \$WORKERS \\
  --user=\$USER \\
  --group=\$GROUP \\
  --bind=\$BIND \\
  --log-level=\$LOG_LEVEL \\
  --log-file=-"  > /home/$USER/$APPLICATION$TODAY/gunicorn_start


chmod u+x ../gunicorn_start
echo -e "${CYAN}####SETUP LOG FOLDERS AND FILES####${NC}"
mkdir ../run
mkdir ../logs
touch ../logs/gunicorn-error.log

echo -e "${CYAN}####SETUP SUPERVISORD####${NC}"

echo -e "[program:$APPLICATION]
command=/home/$USER/$APPLICATION$TODAY/gunicorn_start
user=$USER
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/home/$USER/logs/gunicorn-error.log" > /etc/supervisor/conf.d/$APPLICATION.conf

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl status $APPLICATION
sudo supervisorctl restart $APPLICATION

echo -e "${CYAN}####SETUP NGINX####${NC}"

echo -e "upstream app_server {
    server unix:/home/$USER/$APPLICATION$TODAY/run/gunicorn.sock fail_timeout=0;
}

server {
    listen 80;

    # add here the ip address of your server
    # or a domain pointing to that ip (like example.com or www.example.com)
    server_name $IP_ADDRESS;

    keepalive_timeout 5;
    client_max_body_size 4G;

    access_log /home/$USER/logs/nginx-access.log;
    error_log /home/$USER/logs/nginx-error.log;

    location /static/ {
        alias /home/$USER/$APPLICATION$TODAY/$APPLICATION/staticfiles/;
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
}" > /etc/nginx/sites-available/$APPLICATION


sudo ln -sf /etc/nginx/sites-available/$APPLICATION /etc/nginx/sites-enabled/$APPLICATION
sudo service nginx restart


