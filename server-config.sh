#! /bin/bash
sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install git -y
sudo yum install maven -y

if [ -d "addressbook" ]
then
    echo "repo is cloned and exist"
    cd /home/ec2-user/addressbook
    git pull origin master
else
    git clone https://github.com/akshaysoumyajain/addressbook.git
    cd /home/ec2-user/addressbook
fi
mvn package