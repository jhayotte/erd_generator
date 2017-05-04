#!/bin/bash

# get all running docker container names
containers=$(docker ps -f name=pgsql | grep -w pgsql | awk '{print $NF}')
host=$(hostname)

export LOCALE_IP=$(echo `ipconfig getifaddr en0`)

# loop through all containers
for container in $containers
do 
  name=$(echo $container | cut -d'_' -f 2)
  port=$(docker inspect $container | grep HostPort | grep "[0-9]\+" | awk '{print $2}' | sed -e 's/^"//' -e 's/"$//')
    
  echo "generate db for $name $port"
  #$(docker run --rm -e IP=$(printenv LOCALE_IP) -v "$(PWD):$(PWD)" -w "$(PWD)" --entrypoint=/bin/sh jhayotte/erd_generator:latest -xec "eralchemy -i "postgresql+psycopg2://postgres:password@192.168.1.17:32844/article" -o erd_from_article.pdf")
done
