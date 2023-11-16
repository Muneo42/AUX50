#!/bin/bash

Green='\033[0;32m'
Red='\033[0;31m'
Blue='\033[0;34m'
Yellow='\033[0;33m'
Nc='\033[0m'

# Verification Root
if [ "$UID" -ne 0 ]
then
	echo -e "${Red}Vous devez etre root pour executer ce script${Nc}"
	exit 2
fi

# Affichage de l'heure de debut de la restauration
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Debut de la restauration a $start_time"

# Recuperation du fichier de sauvegarde depuis /tmp/
backup_file="/tmp/backup/nginx_*.tar.gz"

# Verification de l'existance du fichier de sauvegarde
if [ ! -e  $backup_file ]
then
	echo -e "${Red}Erreur : Le fichier de sauvegarde n'a pas été trouvé dans /tmp/${Nc}"
	exit 1
else
	echo -e "${Green}$backup_file existe${Nc}"
fi

# Verification si les fichiers existent deja
if [ -e /etc/nginx/nginx.conf ] || [ -e /var/www/html ]
then
	echo -e "${Yellow}Attention : Les fichiers Existent deja. Voulez-vous les ecraser?${Nc} (y/n)" 	
	read overwrite
	if [ "$overwrite" != "y" ]
	then
		echo -e "${Red}Operation Canceled${Nc}"
		exit 1
	fi
fi


# Extraction des donnees dans les repertoires appropries
tar -xzf ${backup_file} -C /tmp/backup/
cp -vr /tmp/backup/config/* /etc/nginx/
cp -vr /tmp/backup/data/index.nginx-debian.html /var/www/html/
cp -vr /tmp/backup/data/default /etc/nginx/sites-available/
rm -rf /tmp/backup/data /tmp/backup/config

#Affichage de l'heure de fin de la restauration
end_time=$(date "+%Y%m%d %H:%M:%S")
echo -e "${Green}Fin de la restauration a $end_time${Nc}"
