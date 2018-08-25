#!/usr/bin/env bash


echo -e "${CYAN}####SETUP SSH FOR GITHUB CLONES####${NC}"
ssh-keygen -t rsa -b 4096 -C "wedgemail@gmail.com"
echo -e "${CYAN}####CHECK ssh-agent IS UP####${NC}"
eval $(ssh-agent -s)
