#!/bin/bash

error=0
Green='\033[0;32m'
Red='\033[0;31m'
Blue='\033[0;34m'
Yellow='\033[0;33m'
Nc='\033[0m'
re='^[0-9]+$'

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

# List les backup dispo
echo -e "${Green}Voici les backup disponible :"
ls $backup_file

# Demande de choisir au User quel backup
echo -e "${Yellow}Veuillez entre le chiffre correspondant au backup souhaité${Nc}"
read choice

# Parsing de l'input
#if [[ $choice =~ $re ]]
#then
#	echo -e "${Red}Choix impossible.${Nc}"
#	exit 1
#fi

# Fichier selectionnée
selected_file=$(ls $backup_file | sed -n "${choice}p")

# Check si choix existe
if [ -z "$selected_file" ]
then
	echo -e "${Red}Choix n'existe pas"
	exit 1
fi

echo -e "${Green}Choix valide! : ${selected_file}"

# Verification de l'existance du fichier de sauvegarde
if [ ! -e  $selected_file ]
then
	echo -e "${Red}Erreur : Le fichier de sauvegarde n'a pas été trouvé dans /tmp/${Nc}"
	exit 1
else
	echo -e "${Green}$selected_file existe${Nc}"
fi

# Extraction des fichiers
tar -xzf ${selected_file} -C /tmp/backup/


# Vérification si les fichiers existent déjà
if [ -e /etc/nginx/nginx.conf ]
then
	echo -e "${Yellow}Le fichier /etc/nginx/nginx.conf existe déjà.${Nc}"
	echo -e "${Yellow}Voulez-vous écraser les fichiers existants?${Nc} (y/n)"
	read overwrite
	if [ "$overwrite" == "y" ]
	then
		cp -vr /tmp/backup/config/* /etc/nginx/	
	else
    		echo -e "${Red}Opération annulée (Overrwite)${Nc}"
	fi	
fi
 
if [ -e /var/www/html/index.nginx-debian.html ]
then
	echo -e "${Yellow}Le fichier /var/www/html/index.nginx*.html existe déjà.${Nc}"
	echo -e "${Yellow}Voulez-vous écraser les fichiers existants?${Nc} (y/n)"
	read overwrite
	if [ "$overwrite" == "y" ]
	then
		cp -vr /tmp/backup/data/index.nginx-debian.html /var/www/html/
	else
    		echo -e "${Red}Opération annulée (Overrwite)${Nc}"
	fi
fi
if [ -e /etc/nginx/sites-available/default ]
then
	echo -e "${Yellow}Le fichier /etc/nginx/sites-available/default existe déjà.${Nc}"
	echo -e "${Yellow}Voulez-vous écraser les fichiers existants?${Nc} (y/n)"
	read overwrite
	if [ "$overwrite" == "y" ]
	then
		cp -vr /tmp/backup/data/default /etc/nginx/sites-available/	
	else
    		echo -e "${Red}Opération annulée (Overrwite)${Nc}"
	fi
fi
 
# Regement apres les copies
rm -rf /tmp/backup/data /tmp/backup/config

# Extraction des donnees dans les repertoires appropries
tar -xzf ${selected_file} -C /tmp/backup/
cp -nvr /tmp/backup/config/* /etc/nginx/
cp -nvr /tmp/backup/data/index.nginx-debian.html /var/www/html/
cp -nvr /tmp/backup/data/default /etc/nginx/sites-available/
rm -rf /tmp/backup/data /tmp/backup/config

#Affichage de l'heure de fin de la restauration
end_time=$(date "+%Y%m%d %H:%M:%S")
echo -e "${Green}Fin de la restauration a $end_time${Nc}"
exit 0
