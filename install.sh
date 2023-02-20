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
echo "Haciendo update"
sleep 1
sudo apt-get update
sleep 5
clear
echo "Haciendo upgrade"
sleep 1
sudo apt-get upgrade
sleep 5
clear
echo "Instalando Certificados"
sleep 1
sudo apt-get install ca-certificates
sleep 5
echo "Instalando Curl"
sleep 1
sudo apt-get install curl
sleep 5
echo "Instalando gnupg"
sleep 1
sudo apt-get install gnupg
sleep 5
echo "Instalando Libreria"
sleep 1
sudo apt-get install lsb-release
sleep 5
clear
echo "Descargando certificados de docker"
sleep 1
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 5

echo "Instalando Certificados de Docker"
sleep 1
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 3
echo "Actualizando Sistema"
sleep 1
apt-get update
sleep 5
clear
echo "Instalando Docker y dependencias"
sleep 1
apt-get install docker-ce docker-ce-cli containerd.io
sleep 5
echo "Dando permisos al script"
sleep 1
adduser jesus docker 
echo "Creando Volumen de Portainer"
sleep 1
docker volume create portainer_data
echo "Lanzamos nuestro docker de Portainer"
sleep 1
docker run -d --name=portainer --hostname=portainer --network=host --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -e TZ='Europe/Madrid' portainer/portainer-ce 
sleep 5
echo "Instalando docker de MARIADB"
sleep 1
docker container run --name sql-maria -e MYSQL_ROOT_PASSWORD=12345 -e MYSQL_USER=username -e MYSQL_PASSWORD=12345 -e MYSQL_DATABASE=docker -p 3306:3306 -d mariadb:10 (edited)
sleep 5

echo "Enhorabuena Docker + Portainer + MariaDB esta instalado"
