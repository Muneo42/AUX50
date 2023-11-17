#!/bin/bash

# Vérifier les permissions de l'utilisateur
if [ "$(id -u)" != "0" ]; then
    echo "Ce script doit être exécuté en tant que root. Utilisez sudo."
    exit 1
fi
 
# Chemin du journal de maintenance
maintenance_log="/var/log/maintenance.log"
 
# Vérifier si la commande 'mail' est installée
if ! command -v mail &> /dev/null; then
    echo "Le client de messagerie 'mail' n'est pas installé. Installez-le avant d'exécuter ce script."
    exit 1
fi
 
# Supprimer les fichiers non utilisés dans /tmp
find /tmp -type f -atime +1 -delete
echo "$(date '+%Y-%m-%d %H:%M:%S') - Suppression des fichiers non utilisés dans /tmp" >> "$maintenance_log"
 
# Archiver les fichiers du dossier /var/log plus vieux que 7 jours
find /var/log -type f -mtime +7 -name '*.log' -exec gzip {} \;
echo "$(date '+%Y-%m-%d %H:%M:%S') - Archivage des fichiers du dossier /var/log plus vieux que 7 jours" >> "$maintenance_log"


# Déplacer le fichier d'archive dans /backup
log_files="/var/log/*.log.gz"
 
# Vérifier s'il y a des fichiers à déplacer
if ls $log_files 1> /dev/null 2>&1; then
    archive_file="/backup/archive_$(date '+%Y%m%d%H%M%S').log.gz"
    mv $log_files "$archive_file"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Déplacement du fichier d'archive vers $archive_file" >> "$maintenance_log"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Aucun fichier à archiver dans /var/log" >> "$maintenance_log"
fi

# Vérification de l'utilisation des volumes
threshold=80

# Utilisation des volumes avec df -H, en excluant les systèmes de fichiers de type tmpfs
volumes=$(df -H --exclude=tmpfs | awk 'NR>1 && $5 > '$threshold' {print $6}')
 
# Vérifier si des volumes dépassent le seuil
if [ -n "$volumes" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Alerte : Les volumes suivants sont remplis à plus de $threshold% : $volumes" >> "$maintenance_log"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Aucun volume rempli à plus de $threshold%" >> "$maintenance_log"
fi
 
# Liste des utilisateurs avec un shell disponible
users_with_shell=$(getent passwd | awk -F: '{if ($7 != "/sbin/nologin" && $7 != "/usr/sbin/nologin" && $7 != "/bin/false") print $1}')
 
# Vérifier si des utilisateurs avec un shell sont présents
if [ -n "$users_with_shell" ]; then
    # Envoyer un e-mail local aux utilisateurs
    echo "Les tâches de maintenance suivantes ont été effectuées sur le serveur :
    - Suppression des fichiers non utilisés dans /tmp.
    - Archivage des fichiers du dossier /var/log plus vieux que 7 jours.
    - Déplacement du fichier d'archive vers /backup.
    - Vérification de l'utilisation des volumes (alerte si plus de 80%).
 
Consultez le journal de maintenance pour plus de détails : $maintenance_log" | mail -s "Maintenance effectuée sur le serveur" $users_with_shell
 
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Notification par e-mail envoyée aux utilisateurs avec shell" >> "$maintenance_log"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Aucun utilisateur avec shell n'a été trouvé pour la notification par e-mail" >> "$maintenance_log"
fi
