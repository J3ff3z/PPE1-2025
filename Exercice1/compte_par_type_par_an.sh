#!/usr/bin/bash

# Ecrire un second script qui lance le script precedent trois fois, une fois pour chaque annees (2016 à 2018) en prenant le type d'entité (Argument 1) en argument. Ce sercond script produira un formatage semblable a celui du premier exercice

# Vous voulez check quoi sur l'argument du type ? Ca peut-etre tout et n'importe quoi, vu que c'est l'utilisateur qui recherche s'il existe des tags du type "Location", "Person", ou peut-etre "1255486". Aucun check logique pour moi

./compte_par_type.sh 2016 "$1"
./compte_par_type.sh 2017 "$1"
./compte_par_type.sh 2018 "$1"