#!/bin/bash

# Verification Root
if [ "$UID" -ne 0 ]
then
	echo "Vous devez etre root pour executer ce script."
	exit 2
fi

# Verification des arguments
if [ "$#" -eq 0 ]
then
	echo "Usage: $0 <Destination>"
	exit 1
fi

# Dossier de destination
destination="$1"

# Creation du dossier de sauvegarde s'il n'existe pas
if [ -f $destination ]
then
	mkdir $destination
fi

# Affichage de l'heure du debut de l'execution
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Debut de l'execution du script a $start_time"

# Saivegarde des fichiers de configuration dans un sous-dossier
config_folder="$destination/config"
mkdir "$config_folder"
cp -v /etc/nginx/nginx.conf "$config_folder"
#echo "Fichier de configuration sauvegarde : /etc/nginx/nginx.conf"

#Sauvgare des donnees dans un sous-dossier
data_folder="$destination/data"
mkdir "$data_folder"
cp -rv "/var/www/html/"* "$data_folder"
cp -v "/etc/nginx/sites-available/"* "$data_folder"

# Affichage de l'heure de fin d'execution
end_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Fin de l'execution du script a $end_time"

# Creation de l'archive
archive_name="nginx_$(date "+%Y%m%d_%H%M%S").tar.gz"
tar -czf $destination/$archive_name -C $destination config data
rm -rf $destination/config $destination/data  
