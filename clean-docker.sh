#!/bin/sh

# Stop Docker Compose in case its running
docker-compose stop

# Ensure LAAWS containers are stopped and remove them
docker ps -a | grep laaws | awk '{print $1}' | xargs docker stop
docker ps -a | grep laaws | awk '{print $1}' | xargs docker rm

# Remove LAAWS images
docker images | grep laaws | awk '{print $3}' | xargs docker rmi --force
