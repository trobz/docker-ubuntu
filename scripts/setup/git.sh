#!/bin/bash

echo "Install the latest git version"
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install git -y
rm -rf /var/lib/apt/lists/*
