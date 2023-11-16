# AUX050 - TP1

### Scripts d’administration UNIX/Linux - TP1 : Exercices préliminaires

## Questions

- Les administrateurs système écrivent souvent des scripts pour automatiser certaines tâches. Donnez deux exemples où de tels scripts sont utiles.
> Pour faire les sauvegarde et pour faire les MAJ.
- Écrivez un script qui, lors de son exécution, donne la date et l’heure, la liste de tous les utilisateurs connectés et le temps passé depuis le lancement du système (uptime) du système. Enfin, le script doit sauvegarder cette information dans un journal.
> Fichier "TP1-2"

# AUX050 - TP2

## Scripts d’administration UNIX/Linux - TP2 : Exercices préliminaires

## Questions

- Créez une boucle qui compte de 0 à 10.
> Fichier "TP2-1"
- En partant de la boucle précédente, affichez seulement les nombres impairs.
> Fichier "TP2-2"

# Scripts d’administration UNIX/Linux - TP3

## Un serveur web tourne sur votre poste, consulter le site à l’adresse localhost:8080 sur la navigateur de la machine IPI. La machine virtuelle contient ces données du site et la configuration nginx.

### Setup

### Depuis le terminal, installez nginx : 
> sudo apt install nginx -y

## Questions

- Créez un script qui sauvegarde le fichier de configuration du site nginx et les données de ce dernier, dans une archive nginx.tar.gz. Assurez-vous de :
- afficher l’heure du début d’éxécution du script,
- afficher les copies de fichiers effectuées,
- variabiliser la destination (le dossier) de la sauvegarde,
- séparer en sous-dossier les données et les fichiers de configuration,
- afficher l’heure de fin d’éxécution du script.

## Bonus

- Veillez à bien vérifier vos commandes avec des tests préalables, et prévoir des codes d’erreurs / de sorties.
- Sauvegardez le strict minimum, inutile de remplir notre espace de stockage avec des fichiers présent par défaut.
- Ajoutez une option dans le script pour accepter un argument qui serait la nouvelle destination du fichier de sauvegarde.
- Attention dernier point, celui-ci ne dispose pas de retour en arrière : quand vous avez confiance en votre script de sauvegarde, supprimer les configurations nginx de la façon suivantes :
- sudo rm -fr /var/www/
- sudo rm /etc/nginx/sites-available/default
- Restaurez les fichiers de configuration depuis le backup, et faites en sorte de pouvoir accéder au site http://localhost:8080 à nouveau.

# AUX050: TP4

## Scripts d’administration UNIX/Linux - TP4

## Vous avez réussi à créer un script de backup et à vous en servir pour rétablir un service. Maintenant il est temps d’automatiser le rétablissement de ce service, cela permettra un gain de temps dans la remise en marche de votre site. De plus, la sauvegarde de votre site n’est pas encore automatisée, il faut régler ce point également.

## Questions

- Créez un cronjob sur la machine virtuelle pour executer le script de backup toutes les heures, attention :
- le nom du fichier de backup devra contenir la date et l’heure à laquelle il a été fait,
- un message dans /var/log/backup.log doit apparaître pour informer le démarrage et la fin du backup.

## Questions

-Créez un script de restauration pour nginx, il doit :
- affichez l’heure du début de la restauration,
- vérifiez si les fichiers à restaurer sont déjà présents,
- si oui : affichez un warning et demander si on souhaite écraser l’existant – si oui : le faire en affichant la liste des fichiers copiés – si non : affichez un code de sortie Operation canceled
- si non, poursuivre le script
- récupérez le fichier nginx.tar.gz dans /tmp/
- arrangez-vous pour extraire les données du site dans leur bon répertoire de destination, en affichant la liste des fichiers copiés
- affichez l’heure de fin du script.

#AUX050: TP5

## Scripts d’administration UNIX/Linux - TP5

## Questions

## Créez un script qui, grâce à un menu interactif propose :
- de créer un utilisateur,
- de changer le mdp d’un utilisateur,
- de bloquer le mdp d’un utilisateur,
- de sauvegarder le dossier d’un utilisateur.
- Prévoyez une gestion des erreurs.
- Le script doit tracer les actions validées, en sortie standard mais également dans un journal.
