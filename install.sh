#!/bin/bash

echo " "
echo "-------------------------------"
echo " "
echo "Instalacion Automatica de Docker."
echo "Developed by Jesus Dev."
echo " "
sleep 1
echo "-------------------------------"
echo " "
sleep 1
echo "-------------------------------"
echo " "
echo "Haciendo update"
echo " "
echo "-------------------------------"
sleep 1
sudo apt-get update
sleep 5
clear
echo "-------------------------------"
echo " "
echo "Haciendo upgrade"
echo " "
echo "-------------------------------"
sleep 1
sudo apt-get upgrade
sleep 5
clear
echo "-------------------------------"
echo " "
echo "Instalando Certificados"
echo " "
echo "-------------------------------"
sleep 1
sudo apt-get install ca-certificates
sleep 5
echo "-------------------------------"
echo " "
echo "Instalando Curl"
echo " "
echo "-------------------------------"
sleep 1
sudo apt-get install curl
sleep 5
echo "-------------------------------"
echo " "
echo "Instalando gnupg"
echo " "
echo "-------------------------------"
sleep 1
sudo apt-get install gnupg
sleep 5
echo "-------------------------------"
echo " "
echo "Instalando Libreria"
echo " "
echo "-------------------------------"
sleep 1
sudo apt-get install lsb-release
sleep 5
clear
echo "-------------------------------"
echo " "
echo "Descargando certificados de docker"
echo " "
echo "-------------------------------"
sleep 1
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 5
echo "-------------------------------"
echo " "
echo "Instalando Certificados de Docker"
echo " "
echo "-------------------------------"
sleep 1
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 3
echo "-------------------------------"
echo " "
echo "Actualizando Sistema"
echo " "
echo "-------------------------------"
sleep 1
apt-get update
sleep 5
clear
echo "-------------------------------"
echo " "
echo "Instalando Docker y dependencias"
echo " "
echo "-------------------------------"
sleep 1
apt-get install docker-ce docker-ce-cli containerd.io
sleep 5
echo "-------------------------------"
echo " "
echo "Creando Volumen de Portainer"
echo " "
echo "-------------------------------"
sleep 1
docker volume create portainer_data
echo "-------------------------------"
echo " "
echo "Lanzamos nuestro docker de Portainer"
echo " "
echo "-------------------------------"
sleep 1
docker run -d --name=portainer --hostname=portainer --network=host --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -e TZ='Europe/Madrid' portainer/portainer-ce 
sleep 5
echo "-------------------------------"
echo " "
echo "Instalando docker de MARIADB"
echo " "
echo "-------------------------------"
sleep 1
docker container run --name sql-maria -e MYSQL_ROOT_PASSWORD=12345 -e MYSQL_USER=username -e MYSQL_PASSWORD=12345 -e MYSQL_DATABASE=docker -p 3306:3306 -d mariadb:10
sleep 5
echo "-------------------------------"
echo " "
echo "Enhorabuena Docker + Portainer + MariaDB esta instalado"
echo " "
echo "-------------------------------"
