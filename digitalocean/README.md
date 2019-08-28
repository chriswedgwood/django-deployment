1) scp -r ./digitalocean/ root@<ipaddress>:/root/deploy
2) ssh root@<ipaddress>
3) cd deploy
3) ./ubuntu_dependencies.sh
4) ./security_configuration.sh
5) ./ssh_git_setup.sh
6) sudo ./setup_postgres.sh
7) ./deploy_production.sh


  systemctl status nginx.service . 
  sudo journalctl -xe    
  cat /var/log/nginx/access.log . 
  cat  /var/log/nginx/error.log    
  cat /home/<application>/logs/nginx-access.log;  
  cat /home/<application>/logs/nginx-error.log;  
  cat /home/<application>/logs/gunicorn-error.log . 
  sudo supervisorctl reread . 
  sudo supervisorctl update . 
  sudo supervisorctl status <application> . 
  sudo supervisorctl restart <application> . 

  sudo service nginx restart

  nginx -t && service nginx reload


 tail 
 
