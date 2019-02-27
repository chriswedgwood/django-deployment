#!/usr/bin/env bash
set -o pipefail  # trace ERR through pipes
set -o errexit   # same as set -e : exit the script if any statement returns a non-true return value

CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}####STARTING SETUP####${NC}"

cd 
source ~/.env

USER=$(whoami)
echo "USER NAME:"$USER
echo "APPLICATION:"$APPLICATION

echo -e "${CYAN}####SETUP SUPERVISORD####${NC}"

sudo mkdir -p /var/log/caddy/ && sudo touch /var/log/caddy/caddy.log

echo -e "[program:$APPLICATION]
command=/usr/local/bin/caddy -agree=true -email=wedgemail@gmail.com -conf=/etc/caddy/Caddyfile
user=root
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/var/log/caddy/caddy.log" > /etc/supervisor/conf.d/$APPLICATION.conf



sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart $APPLICATION
sudo supervisorctl status $APPLICATION

