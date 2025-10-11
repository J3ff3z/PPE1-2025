#!/usr/bin/bash

# Ecrire un script qui compte les entites pour une annee (Argument 1) un type d'entite (Argument 2) donnes en argument du programme. Son resuiltat est simplement un nombre, rien d'autre.
find . -name $(echo '*'$1'*.ann') | xargs cat | grep "$2" | wc -l 