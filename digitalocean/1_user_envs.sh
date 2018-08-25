#!/usr/bin/env bash
# ssh -t username@host "$(cat example.sh)"


read -p "Application User:" APPLICATION
read -p "Droplet IP:" IPADDRESS
read -p "Database Name:" DB_NAME
read -p "Database user:" DB_USER
read -p "Database Password:" DB_PASSWORD
read -p "Domain:" DOMAIN



BLUE='\033[0;34m'

adduser $APPLICATION
gpasswd -a $APPLICATION sudo

mkdir -p /home/$APPLICATION/.ssh
touch /home/$APPLICATION/.ssh/authorized_keys

cp /root/.ssh/authorized_keys /home/$APPLICATION/.ssh/authorized_keys
chown $APPLICATION:$APPLICATION /home/$APPLICATION/.ssh
chown $APPLICATION:$APPLICATION /etc/supervisor/conf.d
chown $APPLICATION:$APPLICATION /etc/nginx/sites-available/


SECRET_KEY=$(python -c 'import random; print ("".join([random.choice("abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)") for i in range(50)]))')


echo "export DJANGO_SETTINGS_MODULE='config.settings.production'
export DJANGO_SECRET_KEY='$SECRET_KEY'
export DJANGO_ALLOWED_HOSTS='$IPADDRESS'
export DJANGO_ADMIN_URL='padmin'
export DJANGO_MAILGUN_API_KEY='key-e127c2a80065055cc6c99a7eaa636b88'
export MAILGUN_SENDER_DOMAIN='$DOMAIN'
export DJANGO_AWS_ACCESS_KEY_ID=''
export DJANGO_AWS_SECRET_ACCESS_KEY=''
export DJANGO_AWS_STORAGE_BUCKET_NAME=''
export DJANGO_SENTRY_DSN=''
export DJANGO_DEBUG=False
export IP_ADDRESS='$IPADDRESS'
export APPLICATION='$APPLICATION'
export DB_NAME='$DB_NAME'
export DB_USER='$DB_USER'
export DATABASE_URL='postgres://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME'" > /home/$APPLICATION/.env