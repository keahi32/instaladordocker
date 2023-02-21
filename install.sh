#!/bin/bash

echo " "
echo "-------------------------------"
echo " "
echo "Instalacion Automatica de Docker."
echo "Developed by Jesus Dev and g0dsp."
echo " "
echo "-------------------------------"
echo " "
sleep 5
echo "-------------------------------"
echo " "
echo "Haciendo update"
echo " "
echo "-------------------------------"
sudo apt-get update &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Haciendo upgrade"
echo " "
echo "-------------------------------"
sudo apt-get upgrade -y &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando Certificados"
echo " "
echo "-------------------------------"
sudo apt-get install ca-certificates -y &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando Curl"
echo " "
echo "-------------------------------"
sudo apt-get install curl -y &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando gnupg"
echo " "
echo "-------------------------------"
sudo apt-get install gnupg -y &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando Libreria"
echo " "
echo "-------------------------------"
sudo apt-get install lsb-release -y &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Descargando certificados de docker"
echo " "
echo "-------------------------------"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 
clear
echo "-------------------------------"
echo " "
echo "Instalando Certificados de Docker"
echo " "
echo "-------------------------------"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
clear
echo "-------------------------------"
echo " "
echo "Actualizando Sistema"
echo " "
echo "-------------------------------"
apt-get update &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando Docker y dependencias"
echo " "
echo "-------------------------------"
apt-get install docker-ce docker-ce-cli containerd.io -y &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Creando Volumen de Portainer"
echo " "
echo "-------------------------------"
docker volume create portainer_data &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Lanzamos nuestro docker de Portainer"
echo " "
echo "-------------------------------"
docker run -d --name=portainer --hostname=portainer --network=host --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -e TZ='Europe/Madrid' portainer/portainer-ce &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando docker de MARIADB"
echo " "
echo "-------------------------------"
docker container run --name sql-maria -e MYSQL_ROOT_PASSWORD=12345 -e MYSQL_USER=username -e MYSQL_PASSWORD=12345 -e MYSQL_DATABASE=docker -p 3306:3306 -d mariadb:10 &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando docker de Login"
echo " "
echo "-------------------------------"
docker container run --name Login -p 8080:80 -d webdevops/php-apache &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando docker de Registro"
echo " "
echo "-------------------------------"
docker container run --name Login -p 8081:80 -d webdevops/php-apache &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Preparando importacion de base de datos mariadb"
echo " "
echo "-------------------------------"
wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb &>/dev/null
sudo apt install ./mysql-apt-config_0.8.13-1_all.deb
clear
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sql-maria >ip.txt &>/dev/null
ip = tail ip.txt
git clone https://github.com/keahi32/basededatos &>/dev/null
cd basededatos
mysql -u username -h $ip -p docker < docker.sql &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Instalando Webmin"
echo " "
echo "-------------------------------"
sudo apt-get install apt-transport-https gnupg2 -y curl &>/dev/null
sudo echo "deb https://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list
curl https://download.webmin.com/jcameron-key.asc | sudo apt-key add - &>/dev/null
sudo apt-get update &>/dev/null
sudo apt-get install webmin &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Escriba nueva contraseña para root"
echo " "
echo "-------------------------------"
passwd root
clear
echo "-------------------------------"
echo " "
echo "Enhorabuena Docker + Portainer + MariaDB + Docker Login + Docker Registro + Base de datos Importada + Webmin"
echo " "
echo "-------------------------------"
