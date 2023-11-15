# AUX050 - TP1

### Scripts d’administration UNIX/Linux - TP1 : Exercices préliminaires

### Questions

### 1. Les administrateurs système écrivent souvent des scripts pour automatiser certaines tâches. Donnez deux exemples où de tels scripts sont utiles.
> Pour faire les sauvegarde et pour faire les MAJ.
### 2. Écrivez un script qui, lors de son exécution, donne la date et l’heure, la liste de tous les utilisateurs connectés et le temps passé depuis le lancement du système (uptime) du système. Enfin, le script doit sauvegarder cette information dans un journal.
> Fichier "TP1-2"

# AUX050 - TP2

### Scripts d’administration UNIX/Linux - TP2 : Exercices préliminaires

### Questions

### Créez une boucle qui compte de 0 à 10.
> Fichier "TP2-1"
### En partant de la boucle précédente, affichez seulement les nombres impairs.
> Fichier "TP2-2"

# Scripts d’administration UNIX/Linux - TP3

### Un serveur web tourne sur votre poste, consulter le site à l’adresse localhost:8080 sur la navigateur de la machine IPI. La machine virtuelle contient ces données du site et la configuration nginx.

### Setup

### Depuis le terminal, installez nginx : sudo apt install nginx -y

### Questions

### Créez un script qui sauvegarde le fichier de configuration du site nginx et les données de ce dernier, dans une archive nginx.tar.gz. Assurez-vous de :
### afficher l’heure du début d’éxécution du script,
### afficher les copies de fichiers effectuées,
### variabiliser la destination (le dossier) de la sauvegarde,
### séparer en sous-dossier les données et les fichiers de configuration,
### afficher l’heure de fin d’éxécution du script.

### Bonus

### Veillez à bien vérifier vos commandes avec des tests préalables, et prévoir des codes d’erreurs / de sorties.
### Sauvegardez le strict minimum, inutile de remplir notre espace de stockage avec des fichiers présent par défaut.
### Ajoutez une option dans le script pour accepter un argument qui serait la nouvelle destination du fichier de sauvegarde.
### Attention dernier point, celui-ci ne dispose pas de retour en arrière : quand vous avez confiance en votre script de sauvegarde, supprimer les configurations nginx de la façon suivantes :
### sudo rm -fr /var/www/
### sudo rm /etc/nginx/sites-available/default
### Restaurez les fichiers de configuration depuis le backup, et faites en sorte de pouvoir accéder au site http://localhost:8080 à nouveau.
