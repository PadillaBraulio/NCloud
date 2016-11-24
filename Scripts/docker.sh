#!/bin/bash
sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58$
echo deb https://apt.dockerproject.org/repo ubuntu-xenial main | sudo tee /etc/$
sudo apt-get update
sudo apt-get install -y docker-engine
sudo apt-get install -y docker.io
sudo service docker start


