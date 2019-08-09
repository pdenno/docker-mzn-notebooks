#!/bin/bash

docker run -it \
    --log-opt max-size=50m \
    -p 8888:8888 \
    -e DOCKER_USER=`id -un` \
    -e DOCKER_USER_ID=`id -u` \
    -e DOCKER_PASSWORD=`id -un` \
    -e DOCKER_GROUP_ID=`id -g` \
    -v `pwd`:/workdir \
    -v `dirname $HOME`:/home_host \
    mzn-notebook
