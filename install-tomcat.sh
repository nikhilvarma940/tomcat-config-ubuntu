#!/bin/bash
ver=`curl --silent http://mirror.vorboss.net/apache/tomcat/tomcat-9/ | grep v9 | awk '{split($5,c,">v") ; split(c[2],d,"/") ; print d[1]}'`
echo $ver
version=`echo $ver | cut -d " " -f2`
echo $version
sudo apt update
sudo apt install -y default-jdk wget git
sudo cp -v context.xml /home/$USER/
sudo cp -v tomcat-users.xml /home/$USER/
cd /home/$USER/
sudo mkdir -p /opt/tomcat${version}
cd /home/$USER/opt/tomcat${version}
sudo wget https://downloads.apache.org/tomcat/tomcat-9/v${version}/bin/apache-tomcat-${version}.tar.gz
sudo tar -xvzf apache-tomcat-9.*
sudo rm -rf apache*.gz
sudo chmod -R 755 /home/$USER/opt/tomcat${version}/apache-tomcat-9.*
sudo rm -rfv /home/$USER/opt/tomcat${version}/apache-tomcat-9.*/webapps/manager/META-INF/context.xml
sudo rm -rfv /home/$USER/opt/tomcat${version}/apache-tomcat-9.*/webapps/host-manager/META-INF/context.xml
sudo rm -rfv /home/$USER/opt/tomcat${version}/apache-tomcat-9.*/conf/tomcat-users.xml
sudo cp -v /home/$USER/context.xml /home/$USER/opt/tomcat${version}/apache-tomcat-9.*/webapps/manager/META-INF/
sudo cp -v /home/$USER/context.xml /home/$USER/opt/tomcat${version}/apache-tomcat-9.*/webapps/host-manager/META-INF/
sudo cp -v /home/$USER/tomcat-users.xml /home/$USER/opt/tomcat${version}/apache-tomcat-9.*/conf/
sudo rm -rf /home/$USER/context.xml
sudo rm -rf /home/$USER/tomcat-users.xml
cd /home/$USER/opt/tomcat${version}/apache-tomcat-9.*
sudo sh bin/startup.sh
echo "username: admin"
echo "password: admin"
