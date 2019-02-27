#!/usr/bin/env bash
set -o pipefail  # trace ERR through pipes
set -o errexit   # same as set -e : exit the script if any statement returns a non-true return value

CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}####STARTING SETUP####${NC}"

cd 
source ~/.env

if [ ! -d "$APPLICATION" ] ; then
    git clone https://github.com/chriswedgwood/$APPLICATION $APPLICATION else
    cd "$APPLICATION"
    git pull https://github.com/chriswedgwood/$APPLICATION
fi