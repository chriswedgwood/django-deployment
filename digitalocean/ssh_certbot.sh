#!/usr/bin/env bash


sudo apt-get update
sudo apt-get install python-certbot-nginx
sudo nginx -t
sudo systemctl reload nginx
sudo ufw disable
sudo ufw enable
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw status

sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot python-certbot-nginx 
sudo certbot --nginx -d golfcapture.co.uk -d www.golfcapture.co.uk