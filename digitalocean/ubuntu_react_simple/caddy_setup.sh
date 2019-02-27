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
echo "DOMAIN:"$DOMAIN
echo -e "${CYAN}####SETUP CADDY####${NC}"

sudo mkdir -p /etc/caddy
sudo chown -R root:www-data /etc/caddy
sudo mkdir -p /etc/ssl/caddy
sudo chown -R www-data:root /etc/ssl/caddy
sudo chmod 0770 /etc/ssl/caddy
sudo touch /etc/caddy/Caddyfile
sudo chown www-data: /root/$APPLICATION/build

sudo touch /etc/Caddyfile

echo -e "www.$DOMAIN {
    redir https://$DOMAIN
}

$DOMAIN {
    root /root/$APPLICATION/build
    log stdout
    errors stdout
    gzip
}
" > /etc/caddy/Caddyfile
cat /etc/caddy/Caddyfile




