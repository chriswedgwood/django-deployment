#!/usr/bin/env bash


#locales http://smekalov.me/ubuntu-and-locales/

#virtualenv .
#source bin/activate

read -p "Server IP:" IPADDRESS

echo "export DJANGO_SETTINGS_MODULE='config.settings.production'
export DJANGO_SECRET_KEY=''
export DJANGO_ALLOWED_HOSTS='$IPADDRESS'
export DJANGO_ADMIN_URL='ysadmin'
export DJANGO_MAILGUN_API_KEY=''
export DJANGO_MAILGUN_SERVER_NAME=''
export DJANGO_MAILGUN_SENDER_DOMAIN=''
export DJANGO_AWS_ACCESS_KEY_ID=''
export DJANGO_AWS_SECRET_ACCESS_KEY=''
export DJANGO_AWS_STORAGE_BUCKET_NAME=''
export DATABASE_URL='postgres://youstayuk:Tw@ngers@pythonwedge-449.postgres.pythonanywhere-services.com:10449/youstayuk'"