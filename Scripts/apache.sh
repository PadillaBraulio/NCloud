
#!/bin/bash
sudo apt-get install apache2 -y
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql -y
sudo apt-get install php7.0-curl -y
sudo wget https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
sudo cp confd-0.11.0-linux-amd64 /usr/local/bin/confd
sudo chmod 777 /usr/local/bin/confd
