#!/bin/bash

# Verification Root
if [ "$UID" -ne 0 ]
then
echo "Vous devez etre root pour executer ce script"
exit 2
fi

# Configuration du journal
LOG_FILE="/var/log/actions.log"

# Fonction pour créer un utilisateur
creer_utilisateur()
{
	read -p "Entrez le nom d'utilisateur : " nom_utilisateur
	read -p "Entrez le mot de passe : " mot_de_passe
	# Vérifier si l'utilisateur existe déjà
	if id "$nom_utilisateur" &>/dev/null; then
		echo "L'utilisateur existe déjà."
	else
		# Créer l'utilisateur avec useradd
		useradd -m "$nom_utilisateur"
		# Changer le mot de passe avec passwd
		echo -e "$mot_de_passe\n$mot_de_passe" | passwd "$nom_utilisateur"
		echo "L'utilisateur $nom_utilisateur a été créé avec succès."
		echo "$(date) - Création de l'utilisateur $nom_utilisateur" >> "$LOG_FILE"
	fi
}

# Fonction pour changer le mot de passe d'un utilisateur
changer_mdp_utilisateur()
{
	read -p "Entrez le nom d'utilisateur : " nom_utilisateur
	read -p "Entrez le nouveau mot de passe : " mot_de_passe
	# Vérifier si l'utilisateur existe
	if id "$nom_utilisateur" &>/dev/null; then
		# Changer le mot de passe avec passwd
		echo -e "$mot_de_passe\n$mot_de_passe" | passwd "$nom_utilisateur"
		echo "Le mot de passe de l'utilisateur $nom_utilisateur a été changé avec succès."
		echo "$(date) - Changement du mot de passe de l'utilisateur $nom_utilisateur" >> "$LOG_FILE"
	else
		echo "L'utilisateur n'existe pas."
	fi
}

# Fonction pour bloquer le mot de passe d'un utilisateur
bloquer_mdp_utilisateur()
{
	read -p "Entrez le nom d'utilisateur : " nom_utilisateur
	# Vérifier si l'utilisateur existe
	if id "$nom_utilisateur" &>/dev/null; then
		# Verrouiller le compte avec passwd
		passwd -l "$nom_utilisateur"
		echo "Le mot de passe de l'utilisateur $nom_utilisateur a été bloqué avec succès."
		echo "$(date) - Blocage du mot de passe de l'utilisateur $nom_utilisateur" >> "$LOG_FILE"
	else
		echo "L'utilisateur n'existe pas."
	fi
}

# Fonction pour sauvegarder le dossier d'un utilisateur
sauvegarder_dossier_utilisateur()
{
	read -p "Entrez le nom d'utilisateur : " nom_utilisateur
	# Vérifier si l'utilisateur existe
	if id "$nom_utilisateur" &>/dev/null; then
		# Copier le dossier de l'utilisateur vers un emplacement de sauvegarde
		dossier_sauvegarde="sauvegarde_$nom_utilisateur"
		cp -r "/home/$nom_utilisateur" "$dossier_sauvegarde"
		echo "Le dossier de l'utilisateur $nom_utilisateur a été sauvegardé avec succès."
		echo "$(date) - Sauvegarde du dossier de l'utilisateur $nom_utilisateur" >> "$LOG_FILE"
	else
		echo "L'utilisateur n'existe pas."
	fi
}

# Menu interactif
while true; do
echo "Menu interactif :"
echo "1. Créer un utilisateur"
echo "2. Changer le mot de passe d'un utilisateur"
echo "3. Bloquer le mot de passe d'un utilisateur"
echo "4. Sauvegarder le dossier d'un utilisateur"
echo "5. Quitter"
read -p "Choisissez une option : " choix

case $choix in
1) creer_utilisateur;;
2) changer_mdp_utilisateur;;
3) bloquer_mdp_utilisateur;;
4) sauvegarder_dossier_utilisateur;;
5) echo "Au revoir !"; exit 0;;
*) echo "Option invalide. Veuillez choisir une option valide.";;
esac
done
