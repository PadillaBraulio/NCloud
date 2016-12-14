# DOCKERFILE TEST THE ECS INTEGRATION

FROM ubuntu:latest

LABEL version="1.0"

#Install github

RUN apt-get update -y

RUN /bin/bash -c 'source $HOME/.bashrc; \
apt-get -y install git'

RUN /bin/bash -c 'source $HOME/.bashrc; \
git clone https://github.com/PadillaBraulio/NCloud.git'
