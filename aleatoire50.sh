#!/bin/bash

Green='\033[0;32m'
Nc='\033[0m'
Bold='\e[1m'
None='\e[0m'
i=1

echo "Voici les 5 numeros:"
while [ $i -le 5 ]
do
	# Genere un nombre aléatoire entre 0 et 50
	random_number=$((RANDOM % 51))
 
	# Affiche le nombre aléatoire
	echo -e "\t${Bold}${Green}$random_number${Nc}${None}"
	i=$(($i+1))
done
echo "Bonne chance! :)"
exit 0
