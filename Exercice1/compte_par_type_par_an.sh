#!/usr/bin/bash

# Ecrire un second script qui lance le script precedent trois fois, une fois pour chaque annees (2016 à 2018) en prenant le type d'entité (Argument 1) en argument. Ce sercond script produira un formatage semblable a celui du premier exercice
./compte_par_type.sh 2016 "$1"
./compte_par_type.sh 2017 "$1"
./compte_par_type.sh 2018 "$1"