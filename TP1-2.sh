#!/bin/sh

# Creation des variables date, les usr logger et le uptime
current_date=$(date "+%Y-%m-%d %H:%M:%S")
logged_in_users=$(who)
system_uptime=$(uptime)

# Chemin du fichier journal
log_file="/var/log/system_info.log"

# Ajouter le message au journal
echo "Date et heure : $current_date\nUtilisateurs connectés :\n$logged_in_users\nUptime du système :\n$system_uptime\n" >> $log_file

# Afficher le message
echo "Information système enregistrée dans le journal : $log_file"

