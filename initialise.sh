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


sudo apt-get install python3 python-dev python3-dev python-pip

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
















