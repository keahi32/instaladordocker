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
echo " "
echo "-------------------------------"
echo " "
echo "Haciendo update"
echo " "
echo "-------------------------------"
sudo apt-get update &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Haciendo upgrade"
echo " "
echo "-------------------------------"
sudo apt-get upgrade -y &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando Certificados"
echo " "
echo "-------------------------------"
sudo apt-get install ca-certificates -y &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando Curl"
echo " "
echo "-------------------------------"
sudo apt-get install curl -y &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando gnupg"
echo " "
echo "-------------------------------"
sudo apt-get install gnupg -y &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando Libreria"
echo " "
echo "-------------------------------"
sudo apt-get install lsb-release -y &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Descargando certificados de docker"
echo " "
echo "-------------------------------"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando Certificados de Docker"
echo " "
echo "-------------------------------"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Actualizando Sistema"
echo " "
echo "-------------------------------"
apt-get update &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando Docker y dependencias"
echo " "
echo "-------------------------------"
apt-get install docker-ce docker-ce-cli containerd.io -y &>/dev/null
docker volume create portainer_data &>/dev/null
docker run -d --name=portainer --hostname=portainer --network=host --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -e TZ='Europe/Madrid' portainer/portainer-ce &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando docker de MARIADB"
echo " "
echo "-------------------------------"
docker container run --name sql-maria -e MYSQL_ROOT_PASSWORD=12345 -e MYSQL_USER=username -e MYSQL_PASSWORD=12345 -e MYSQL_DATABASE=docker -p 3306:3306 -d mariadb:10 &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando docker de Login"
echo " "
echo "-------------------------------"
docker container run --name Login -p 8080:80 -d webdevops/php-apache &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando docker de Registro"
echo " "
echo "-------------------------------"
docker container run --name Registro -p 8081:80 -d webdevops/php-apache &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Preparando importacion de base de datos mariadb"
echo " "
echo "-------------------------------"
sudo apt install mariadb-server -y &>/dev/null
clear
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sql-maria >ip.txt
jamon=$(cat /var/www/html/instaladordocker/ip.txt)
git clone https://github.com/keahi32/basededatos &>/dev/null
mysql -u root -h $jamon -p docker < /var/www/html/instaladordocker/basededatos/docker.sql 
echo " "
echo "-------------------------------"
echo " "
echo "Instalando monitor de recursos"
echo " "
echo "-------------------------------"
sudo apt-get update -y &>/dev/null
sudo apt-get install apache2 php libapache2-mod-php -y &>/dev/null
apt -y install lsb-release apt-transport-https ca-certificates &>/dev/null
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg  &>/dev/null
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt update &>/dev/null
apt upgrade -y &>/dev/null
apt -y install php7.4 &>/dev/null
apt-get install php7.4-{bcmath,bz2,intl,gd,mbstring,mysql,zip} -y &>/dev/null
service apache2 restart &>/dev/null
sudo apt-get install php7.4-xml php7.4-json php7.4-gd php7.4-mbstring -y &>/dev/null
git clone https://github.com/keahi32/phpsysinfo &>/dev/null
sudo mv phpsysinfo/* /var/www/html &>/dev/null
sudo chown -R www-data:www-data /var/www/html/ &>/dev/null
sudo chmod -R 755 /var/www/html/ &>/dev/null
sudo cp /var/www/html/phpsysinfo.ini.new /var/www/html/phpsysinfo.ini &>/dev/null
rm /var/www/html/index.html &>/dev/null
service apache2 restart &>/dev/null
clear
echo " "
echo "-------------------------------"
echo " "
echo "Instalando Firewall"
echo " "
echo "-------------------------------"
ip a
echo "Copia la eth0 tienes 15 segundos"
sleep 15
sudo apt-get install snort -y
mkdir -p /home/admin/telegram
mv telegram.sh /home/admin/telegram/
mv local.rules /etc/snort/rules
sleep 2
clear
echo "-------------------------------"
echo " "
echo "Enhorabuena Has Instalado Docker + MariaDB + Docker Login + Docker Registro + Base de datos Importada + Sistema de Monitorizacion"
echo " "
echo "-------------------------------"
