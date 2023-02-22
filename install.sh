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
docker container run --name Registro -p 8081:80 -d webdevops/php-apache &>/dev/null
clear
echo "-------------------------------"
echo " "
echo "Preparando importacion de base de datos mariadb"
echo " "
echo "-------------------------------"
sudo apt install mariadb-server -y &>/dev/null
clear
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sql-maria >ip.txt
jamon=$(cat /home/admin/instaladordocker/ip.txt)
git clone https://github.com/keahi32/basededatos &>/dev/null
mysql -u root -h $jamon -p docker < /home/admin/instaladordocker/basededatos/docker.sql 
echo "-------------------------------"
echo " "
echo "Escriba nueva contraseña para root"
echo " "
echo "-------------------------------"
passwd root
clear
echo "-------------------------------"
echo " "
echo "Enhorabuena Docker + Portainer + MariaDB + Docker Login + Docker Registro + Base de datos Importada"
echo " "
echo "-------------------------------"
