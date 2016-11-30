#!/bin/bash
sudo wget https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
sudo cp confd-0.11.0-linux-amd64 /usr/local/bin/confd
sudo chmod 777 /usr/local/bin/confd

sudo mkdir -p /etc/confd/{conf.d,templates}

sudo cp php.tmpl /etc/confd/templates/php.tmpl
sudo cp php.toml /etc/confd/conf.d/php.toml

sudo cp virtualHost.tmpl /etc/confd/templates/virtualHost.tmpl 
sudo cp virtualHost.toml /etc/confd/conf.d/virtualHost.toml

