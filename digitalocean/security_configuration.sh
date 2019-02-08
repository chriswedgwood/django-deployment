#!/usr/bin/env bash
# ssh -t username@host "$(cat example.sh)"

set -o pipefail  # trace ERR through pipes
set -o errexit   # same as set -e : exit the script if any statement returns a non-true return value

read -p "Application User:" APPLICATION
read -p "Droplet IP Address:" IPADDRESS
read -p "Site Domain(no www):" DOMAIN
read -p "Mailgun Domain:" MAILGUN_DOMAIN
read -p "Sentry DSN:" SENTRY_DSN


read -p "Database Name:" DB_NAME
read -p "Database user:" DB_USER
read -s -p "Database Password:" DB_PASSWORD


CYAN='\033[0;36m'
NC='\033[0m' # No Color
echo -e "${CYAN}####CREATING USER $APPLICATION####${NC}"

adduser $APPLICATION
gpasswd -a $APPLICATION sudo
usermod -aG sudo $APPLICATION

mkdir -p /home/$APPLICATION/.ssh
touch /home/$APPLICATION/.ssh/authorized_keys

cp /root/.ssh/authorized_keys /home/$APPLICATION/.ssh/authorized_keys
cp -r /root/deploy/ /home/$APPLICATION/
chown -R $APPLICATION:$APPLICATION /home/$APPLICATION/.ssh
chown -R $APPLICATION:$APPLICATION /etc/supervisor/
chown -R $APPLICATION:$APPLICATION /etc/nginx/sites-available/
chown -R $APPLICATION:$APPLICATION /deploy/


SECRET_KEY=$(python -c 'import random; print ("".join([random.choice("abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*") for i in range(50)]))')




echo "export DJANGO_SETTINGS_MODULE='config.settings.production'
export DJANGO_SECRET_KEY='$SECRET_KEY'
export DJANGO_ALLOWED_HOSTS='$IPADDRESS','$DOMAIN','www.$DOMAIN'
export DJANGO_ADMIN_URL='padmin'
export MAILGUN_API_KEY='key-e127c2a80065055cc6c99a7eaa636b88'
export MAILGUN_DOMAIN='$MAILGUN_DOMAIN'
export DJANGO_AWS_ACCESS_KEY_ID=''
export DJANGO_AWS_SECRET_ACCESS_KEY=''
export DJANGO_AWS_STORAGE_BUCKET_NAME=''
export DJANGO_SENTRY_DSN='$SENTRY_DSN'
export DJANGO_SENTRY_LOG_LEVEL='Debug'
export DJANGO_DEBUG=False
export IP_ADDRESS='$IPADDRESS'
export APPLICATION='$APPLICATION'
export DB_NAME='$DB_NAME'
export DB_USER='$DB_USER'
export DB_PASSWORD='$DB_PASSWORD'
export SITE_DOMAIN='$DOMAIN' 
export DJANGO_SECURE_SSL_REDIRECT='True'
export DJANGO_SECURE_HSTS_INCLUDE_SUBDOMAINS='True' 
export DATABASE_URL='postgres://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME'" > /home/$APPLICATION/.env

source  /home/$APPLICATION/.env

echo -e "${CYAN}####MOVING TO USER $APPLICATION####${NC}"



cd /home/$APPLICATION/

sudo su $APPLICATION


