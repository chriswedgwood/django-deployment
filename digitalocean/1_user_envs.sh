#!/usr/bin/env bash
# ssh -t username@host "$(cat example.sh)"


read -p "Application User:" APPLICATION
read -p "Droplet IP Address:" IPADDRESS
read -p "Site Domain:" DOMAIN
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
export DB_PASSWORD='$DB_PASSWORD'
export DATABASE_URL='postgres://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME'" > /home/$APPLICATION/.env


source  /home/$APPLICATION/.env

./2_setup_ubuntu_dependencies.sh




echo -e "${CYAN}####MOVING TO USER $APPLICATION####${NC}"
echo -e "${CYAN}####RUN /root/django-deployment/digitalocean/4_ssh_git_setp.sh NEXT ####${NC}"


cp ./4_ssh_git_setup.sh /home/$APPLICATION/4_ssh_git_setup.sh
cp ./3_setup_all.sh /home/$APPLICATION/3_setup_all.sh
cp ./setup_database.sh /home/$APPLICATION/setup_database.sh

cd /home/$APPLICATION/

sudo su $APPLICATION


