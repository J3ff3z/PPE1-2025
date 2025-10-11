#!/usr/bin/bash

# Creer un script pour etablir un classement des lieux les plus cites. Prendre en argument l'année (Argument 1), le mois (Argument 2) et le nombre de lieux a afficher (Argument 3).
# Comme on fait pas de verif, si on veut chercher toutes les dates avec * , il faut le mettre entre ""
find . -name $(echo '*'$1'_'$2'*.ann') | xargs cat | grep "Location" | awk -F"\t" '{print $3}' | sort | uniq -c | sort -gr | head -n "$3"