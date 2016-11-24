# NCloud
This is an exercise from NCloud, to create the ectd server, install mysql, an apache2, you need to create a ec2 machine in aws, with the ubuntu 16.04 ami, and run the file init.sh.

You need to asign an security group that has open the ports 8005,8006,8007,5005,5006,5007,80,22 in order to function correctly.

 Copy the public  ip of your ec2 instance and replace it in the etcd.sh, exaclty in export PUBLIC_IP= xxx.xxx.xxx.xxx, put your public ip.
you also need to replace your public ip in the index.php file, exactly in the curl_setopt part 


First executes the docker.sh

After executes the apache.sh

After executes the etcd.sh

At this moment you will have ah etcd cluster, an mysql in docker and apache server installed in your machine.
so, now you need to put some dummy data and grant permission to connetct in your mysql instance.


sudo docker exec -t -i mysql2 /bin/bash

mysql -u root -p         the password is 123

create database dummy; 

use dummy;

create table dummy ( dummy int );

insert into dummy values (1);  

insert into dummy values (2); 

insert into dummy values (3); 

insert into dummy values (4);  

GRANT ALL ON *.* to root@'%' IDENTIFIED BY '123';


copy the **index.php** in /var/www/html/ folder and restart the apache server with **sudo systemctl restart apache2**

launch the following command **curl -L -X PUT http://xxx.xxx.xxx.xxx:5005/v2/keys/message -d value="yyy.yyy.yyy.yyyy"** where the xxx represents your public ip and yyy represents the public ip of the mysql instance, in this case xxx and yyy are the same ip.

And for last, open your browser and put XXX.XXX.XXX.XXX/index.php where xxx are your public ip, and you will get an apache connected to mysql instance by the etcd server.

## What i make to solve it. 

This are the steps that I made in order to create a etcd cluster, mysql installation, apache2 and vhost configuration.

### Create ec2 machine.
I created a ec2 machine with **ubuntu 16.04 ami**, and t2.micro type, in the security group I opened all TCP ports, yes I know that it is bad thing, but as it is only an exercise, i thought it was acceptable.

### Install Docker.

After create the ec2 machine, I proceed to install docker, it was very straightforward, and only was needed a few lines in the console, and it was up

### Building an etcd cluster.

This to me, was the most interesting part of the tutorial,  cause I never was heard it before. So in order to create a cluster, I pull the quay.io/coreos/etcd image from docker and I launch an instance in daemon mode with the ports 8005 and 5005 opened for the instance.

Just as in this tutorial [running-etcd-in-containers](https://coreos.com/blog/Running-etcd-in-Containers/) 

In order to put an key in the etcd, I needed this command line : curl -L -X PUT http://54.191.254.133:8004/v2/keys/message -d value="54.191.254.133 , So this is the way to put the key and the value on etcd, the value of this string was up where the mysql server comes from. 

For update, delete the key this was the documentation that I used https://coreos.com/etcd/docs/latest/api.html

So, what I understood from the instructions was, that this key would be stored in the etcd (the key that contains the connection string), and the apache server will connect to the mysql server, from the value stored in the key .

### Installing Mysql.

To install mysql in docker I ran the following commands line.
	
	docker run -p 3306:3306  --name mysql -e MYSQL_ROOT_PASSWORD=123 -d mysql/mysql-server:5.6

after I enter to the command line interface and create the dummy database with dummy table, i put some random values in the table, to be consulted from apache server.


### Installing Apache server.

I installed apache server in my ec2 instance, so I didn’t  it in a docker image.
For connect to the mysql server I use the **prueba.php** file.

as you will see, the ip address of the mysql server is stored in the etcd, so in case of change the mysql server we willn’t be afraid to change the code  about the connection string,  because it reads from the etcd server.

### Vhost configuration.

To be honest, I dont get the sense of do this, so I only create an virtual host and put it in the server.

To create the virtual host configuration I follow this tutorial  https://www.digitalocean.com/community/tutorials/como-configurar-virtual-host-de-apache-en-ubuntu-14-04-lts-es
and it seems  work fine, but if you want try this, you need to modify the hosts file, and put a new entry with the public ip of the ec2  machine 54.191.254.133 and the hostname of www.exercise.com

