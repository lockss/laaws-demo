#!/bin/sh
docker ps -a -q | xargs docker stop
docker ps -a -q | xargs docker rm
docker images -q | xargs docker rmi --force
