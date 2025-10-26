#!/usr/bin/bash

# Creer un script pour etablir un classement des lieux les plus cites. Prendre en argument l'année (Argument 1), le mois (Argument 2) et le nombre de lieux a afficher (Argument 3).

# Comme on fait pas de verif via la maniere dont shell interprete *, si on veut chercher toutes les dates avec * , il faut le mettre entre ""

# Modification pour verification des arguments :
if ! [[ "$1" =~ ^[0-9\*]+$ ]]; 
then
	echo "Error: Invalid Arguments. The year must be a number or \"*\""
	exit 1
fi
if [[ "$1" =~ ^[0-9]+$ ]];
then
	if [ "$1" -lt 2016 ] || [ "$1" -gt 2018 ]; 
	then
		echo "Error: Year must be between 2016 and 2018"
		exit 1
	fi
fi

if ! [[ "$2" =~ ^[0-9\*]+$ ]]; 
then
	echo "Error: Invalid Arguments. The month must be a number or \"*\""
	exit 1
fi
if [[ "$2" =~ ^[0-9]+$ ]];
then
	if [ "$2" -lt 1 ] || [ "$2" -gt 12 ]; 
	then
		echo "Error: Month must be between 1 and 12"
		exit 1
	fi
fi
if ! [[ "$3" =~ ^[0-9\*]+$ ]]; 
then
	echo "Error: Invalid Arguments. The number of line shown must be a number"
	exit 1
fi

find . -name $(echo '*'$1'_'$2'*.ann') | xargs cat | grep "Location" | awk -F"\t" '{print $3}' | sort | uniq -c | sort -gr | head -n "$3"