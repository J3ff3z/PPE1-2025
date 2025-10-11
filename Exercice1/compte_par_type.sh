#!/usr/bin/bash

# Ecrire un script qui compte les entites pour une annee (Argument 1) un type d'entite (Argument 2) donnes en argument du programme. Son resuiltat est simplement un nombre, rien d'autre.

# Modification pour verification des arguments :
if ! [[ $1 =~ ^[0-9]+$ ]]; 
then
	echo "Error: Invalid Arguments. The year must be a number"
	exit 1
fi
if [ $1 -lt 2016 ] || [ $1 -gt 2018 ]; 
then
	echo "Error: Year must be between 2016 and 2018"
	exit 1
fi

# Pas de check sur le type d'entites, c'est a l'utilisateur d'etre certains que le type qu'il recherche existe.


find . -name $(echo '*'$1'*.ann') | xargs cat | grep "$2" | wc -l 