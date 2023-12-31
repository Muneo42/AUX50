#!/bin/bash

Green='\033[0;32m'
Red='\033[0;31m'
Blue='\033[0;34m'
Yellow='\033[0;33m'
Nc='\033[0m'

arg=${1:-/tmp/backup}

# Verification Root
if [ "$UID" -ne 0 ]
then
	echo -e "${Red}Vous devez etre root pour executer ce script.${Nc}"
	exit 2
fi

# Verification des arguments
if [ -z "$1" ]
then
	echo -e "${Yellow}The default path is $arg${Nc}"
	destination=$arg
else
	destination="$1"
fi

# Creation du dossier de sauvegarde s'il n'existe pas
if [ -f $destination ]
then
	mkdir -p $destination
fi

# Affichage de l'heure du debut de l'execution
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "${Green}Debut de l'execution du script a $start_time"

# Saivegarde des fichiers de configuration dans un sous-dossier
config_folder="$destination/config"
mkdir -p "$config_folder"
cp -v /etc/nginx/nginx.conf "$config_folder"
#echo "Fichier de configuration sauvegarde : /etc/nginx/nginx.conf"

#Sauvgare des donnees dans un sous-dossier
data_folder="$destination/data"
mkdir -p "$data_folder"
cp -rv "/var/www/html/"* "$data_folder"
cp -v "/etc/nginx/sites-available/"* "$data_folder"

# Affichage de l'heure de fin d'execution
end_time=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "Fin de l'execution du script a $end_time${Nc}"

# Creation de l'archive
archive_name="nginx_$(date "+%Y%m%d_%H%M%S").tar.gz"
tar -czf $destination/$archive_name -C $destination config data
rm -rf $destination/config $destination/data 

exit 0
