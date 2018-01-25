#!/usr/bin/env bash
#scp -r /path/to/my/files root@0.0.0.0:/path/on/remote/droplet
    #wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/chriswedgwood/django-deployment/master/initialise.sh
BLUE='\033[0;34m'
echo "I need some info to perform the deployment:"

read -p "Database name:" DB_NAME
read -p "Database username:" DB_USERNAME
read -p "Database password:" DB_PASSWORD
read -p "Application user:" APPLICATION_USER
read -p "Server IP:" IPADDRESS


#initial dependencies
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential libpq-dev python-dev
sudo apt-get -y install postgresql postgresql-contrib
sudo apt-get install virtualenv

#nginx
sudo apt-get -y install nginx

#supervisor
sudo apt-get -y install supervisor
sudo systemctl enable supervisor
sudo systemctl start supervisor
sudo apt-get -y install emacs


sudo echo -e "
CREATE DATABASE $DB_NAME;
CREATE USER $DB_USERNAME WITH PASSWORD '$DB_PASSWORD';
ALTER ROLE $DB_USERNAME SET client_encoding TO 'utf8';
ALTER ROLE $DB_USERNAME SET default_transaction_isolation TO 'read committed';
ALTER ROLE $DB_USERNAME SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USERNAME;
" > create.sql

sudo -u postgres psql -f create.sql
rm create.sql


adduser $APPLICATION_USER
usermod -aG sudo $APPLICATION_USER

echo -e "${BLUE}RUN THESE NEXT...."
echo -e "${BLUE}mkdir .ssh"
echo -e "${BLUE}touch .ssh/authorized_keys"
echo -e "${BLUE}chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"



su - $APPLICATION_USER

echo -e "${BLUE}#################################################################################"
echo -e "${BLUE}run exit"
echo -e "${BLUE}NOW RUN cat ~/.ssh/id_rsa.pub locally on your laptop"
echo -e "${BLUE}THEN LOGIN with root - ssh root@$IPADDRESS"
echo -e "${BLUE}su - $APPLICATION_USER"
echo -e "${BLUE}emacs .ssh/authorized_keys"
echo -e "${BLUE}PASTE CONTENTS OF CLIPBOARD INTO FILE"
echo -e "${BLUE}CTR-x CTR-s CTR-z"
echo -e "${BLUE}TRY ssh with $APPLICATION_USER - ssh $APPLICATION_USER@$IPADDRESS"














