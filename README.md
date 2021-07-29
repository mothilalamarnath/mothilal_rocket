# mothilal_rocket
                                        Procedure to SETUP THE ENVIRONMENT@AWS
                                        
                                        
1)	Create free account on AWS
2)	Create AWS EC2 instances with the below requirements.

Requirements and steps:
----------------------

Step1:
-----

choose Amazon Linux 2 AMI (HVM), SSD Volume(64 bit)
(Or)
Either ubuntu server 64bit x86

Step 2: 
-------

Adjust the instance as per the need( for test purpose I chosen “t.micro” and default settings)

step 3 configure instance details:
----------------------------------

Go to Advance details section and “User data” field select “as text” option
Inside the text box enter the details below mentioned

----------------------------------------

#! /bin/sh 
yum update -y

amazon-linux-extras install docker 

service docker start

usermod -a -G docker ec2-user

chkconfig docker on

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo mkdir -p /opt/docker/rocket.chat/data/runtime/db

sudo mkdir -p /opt/docker/rocket.chat/data/dump

cd /opt/docker/rocket.chat

curl -L https://raw.githubusercontent.com/mothilalamarnath/mothilal_rocket/main/docker-compose.yml -o /opt/docker/rocket.chat/docker-compose.yml

curl -L https://raw.githubusercontent.com/mothilalamarnath/mothilal_rocket/main/remove.sh -o /opt/docker/rocket.chat/remove.sh

chmod -R 777 /opt/docker/rocket.chat/docker-compose.yml

chmod -R 777 /opt/docker/rocket.chat/remove.sh

sudo docker-compose up -d

----------------------------------------

Step 4:
-------

Storage size of the instance has been chosen 8GiB

Step 5:
-------

Add Tag with “NAME” and assign values ex: Name as “Name and Value as “mothirocket”

Step 6:
-------

Allow the following ports “80”,”3000”,”443”,”22” for access and communication in the security group configuration, proceed with "Review and Launch"

Step 7:
-------

Use existing KEY-PAIR else create a new KEY-PAIR (I have created new one as “mothilal.pem” and click LAUNCH.

Result:
-------

Check the instance state as “RUNNING with Green Light” and status check as “2/2checks.”

3)	Log in to the instance created by using any one method.

Options:
--------

ssh -i "mothilal.pem" ec2-user@3.128.xxx.xxx (ip address).


                                            
                                            How to run deployment
                                            ---------------------
                                              
                                              
INSTALL DOCKER CONTAINERS of Rocket chat and Mongo DB

NOTE:
-----

We no need to run the below steps, the execution would happen Automatically while creating AWS EC2,Explanation for “User data” file above mentioned while creating AWS EC2 instance.

**Installing DOCKER at EC2 instance:**

#! /bin/sh

yum update -y

amazon-linux-extras install docker

service docker start

usermod -a -G docker ec2-user

chkconfig docker on

**Install Docker Compose:**

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


**Creating the required Directories for instances of Mango DB & Docker compose:**

sudo mkdir -p /opt/docker/rocket.chat/data/runtime/db

sudo mkdir -p /opt/docker/rocket.chat/data/dump

cd /opt/docker/rocket.chat


**pull from github docker-compose.yml file to perform auto deployment of rocketchat image as well mangodb images:**

curl -L https://raw.githubusercontent.com/mothilalamarnath/mothilal_rocket/main/docker-compose.yml -o /opt/docker/rocket.chat/docker-compose.yml


**pull from the github remove.sh file for “remove the deployment and cleanup all resources”:**

curl -L https://raw.githubusercontent.com/mothilalamarnath/mothilal_rocket/main/remove.sh -o /opt/docker/rocket.chat/remove.sh


**Give executable permissions of above pulled files and directories:**

chmod -R 777 /opt/docker/rocket.chat/docker-compose.yml

chmod -R 777 /opt/docker/rocket.chat/remove.sh


**Execute docker compose for automatic installation and manke the system up and running:**

sudo docker-compose up -d


**How to check the rocketchat:**

	
Check the result by clicking the following link --> http://3.21.92.71:3000/



                                        **How to remove the deployment and cleanup all resources created for it**
                                        ---------------------------------------------------------------------                                        
                                        
                                        
Steps:
------

1) Login to the EC2 instance

2) Check the existing running images

docker ps -a

Result:
------

[root@ip-172-31-39-219 ec2-user]# docker ps -a

CONTAINER ID   IMAGE                COMMAND                  CREATED       STATUS                   PORTS                    NAMES

a8182caa5acb   rocket.chat:latest   "bash -c 'for i in `…"   2 hours ago   Up 2 hours               0.0.0.0:3000->3000/tcp   rocketchat_rocketchat_1

3bacc07be712   mongo:4.0            "docker-entrypoint.s…"   2 hours ago   Exited (0) 2 hours ago                            rocketchat_mongo-init-replica_1

9dff51fd359c   mongo:4.0            "docker-entrypoint.s…"   2 hours ago   Up 2 hours               27017/tcp                rocketchat_mongo_1

3)	Check the running Images:

Result:
-------

[root@ip-172-31-39-219 ec2-user]# docker image ls

REPOSITORY    TAG       IMAGE ID       CREATED      SIZE

mongo         4.0       dabd28946bbb   2 days ago   430MB

rocket.chat   latest    41050a2486f4   6 days ago   834MB


4)	Go to the following directory

cd /opt/docker/rocket.chat

5)	Execute the following script which will stop and remove all the container and delete all the stopped container images.

./ remove.sh

6)	Check the container status by using below cmd:

docker ps -a

Result:
-------
No container is running

CONTAINER ID   IMAGE                COMMAND                  CREATED       STATUS                   PORTS                    NAMES

7)	Check the image status:

docker image ls

Result:
-------

REPOSITORY    TAG       IMAGE ID       CREATED      SIZE 

All the stopped container images are Deleted, and no images are available.

