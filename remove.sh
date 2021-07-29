#! /bin/sh
# To kill all the running containers
docker kill $(docker ps -q)
# To clean all the stopped containers
docker rm $(docker ps -a -q)
# To remove all the container images
docker rmi $(docker image ls -q)
