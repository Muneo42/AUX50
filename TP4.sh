#!/bin/bash

# Affichage de l'heure de debut de la restauration
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Debut de la restauration a $start_time"

# Verification si les fichiers existent deja
if [ -e /etc/nginx/nginx.conf ] || [ -e /var/www/html ]
then
	read -p "Attention : Les fichiers Existent deja. Voulez-vous les ecraser? (y/n)" overwrite
	if [ "$overwrite" != "y" ]
	then
		echo "Operation Canceled"
		exit 1
	fi
fi

# Recuperation du fichier de sauvegarde depuis /tmp/
backup_file="/tmp/backup/nginx_*.tar.gz"

# Verification de l'existance du fichier de sauvegarde
if [ ! -e  $backup_file ]
then
	echo "Erreur : Le fichier de sauvegarde n'a pas été trouvé dans /tmp/"
	exit 1
else
	echo "$backup_file existe"
fi

# Extraction des donnees dans les repertoires appropries
tar -xzf ${backup_file} -C /tmp/backup/
cp -vr /tmp/backup/config/* /etc/nginx/
cp -vr /tmp/backup/data/* /var/www/html/

#Affichage de l'heure de fin de la restauration
end_time=$(date "+%Y%m%d %H:%M:%S")
echo "Fin de la restauration a $end_time"
