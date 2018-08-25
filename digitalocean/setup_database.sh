#!/usr/bin/env bash


echo -e "${CYAN}####DATABASE SETUP STARTING####${NC}"

sudo echo -e "
CREATE DATABASE $DB_NAME;
CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
ALTER ROLE $DB_USER SET client_encoding TO 'utf8';
ALTER ROLE $DB_USER SET default_transaction_isolation TO 'read committed';
ALTER ROLE $DB_USER SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
" > create.sql

sudo -u postgres psql -f create.sql
rm create.sql
echo -e "${CYAN}####DATABASE SETUP OVER####${NC}"