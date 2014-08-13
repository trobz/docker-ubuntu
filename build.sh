#!/bin/bash

NAME="basic"
DOCKER_TAG=${1:-14.04}

echo "build image for $NAME:$DOCKER_TAG"

cat Dockerfile.tmpl | sed -e "s/{DOCKER_TAG}/$DOCKER_TAG/g" > Dockerfile
sudo docker build ${@:2:${#@}} -t $NAME:$DOCKER_TAG .

