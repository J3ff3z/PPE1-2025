# Journal de bord du projet encadré

## git-intro-exercices

####  Exercice 2.c

> Modifier le fichier "journal.md" **sur votre machine**
- [x] Done

#### Exercice Bash

Compter le nombre d'annotations par années :
find 2018/*/* | xargs cat | grep Location | wc -l >> ouput.txt

Fichier count.sh :
Normalement, il permet de faire tous les exercices, il suffit juste de rentrer les bonnes commandes
```
NAME

        count - count annotation from ann files in the directory and subdirectory

SYNOPSIS

        count [-t typeName] [-a year] [-b yearEnd] [-c topCount] [-h] [-m month] [-n monthEnd]

DESCRIPTION

        count the tags from all the .ann files in the directory and subdirectory.

        The -a option allow to check only files from the year specified in arguments. Paired with the -b options, it will check all the files from the year -a to the year -b. -b cannot be be specified without an -a options

        The -m and -n work like the options -a and -b, but for the months

        Caution, .ann files must be of the format yyyy_mm_dd_*.ann to have to works with the options -abmn

OPTIONS

        -t
                Filter to only count the typeName's type given in argument
        -a
                Filter to only count the tags from the file's year
        -b
                Can only be used paired with -a. Filter from year to yearEnd
        -c
                Output the first topCount tags duplicate count's
        -h
                Return the help menu
        -m
                Filter to only count the tags from the file's month
        -n
                Can only be used paired with -m. Filter from the month to monthEnd. If -a and/or -b or specified, will filter from year's month to yearEnd's monthEnd
```
Les commandes pour les exercices :
```
Exercice 1 : 
./count.sh -a 2016 -b 2018 -t Location
Exercice 2.a :
./count.sh -a xxxx -t yyyy 
	(Avec xxxx l'annee voulu, et yyyy le type voulu)
./count.sh -a xxxx -b yyyy -t zzzz 
	(Avec xxxx l'annee de depart voulu, yyyy l'annee de fin voulu et zzzz le type voulu)
Exercice 2.b :
./count.sh -a xxxx -m yy -t Location -c z
	(Avec xxxx l'annee voulu, yy le mois, et z le nombre de lieux a afficher)
```
Techniquement, le code peut probablement etre optimiser, et techniquement, j'ai pas autoriser l'utilisateur a utiliser \* pour indiquer qu'il voulait n'importe quelle annee, ou n'importe quel mois.
Il y a probablement des cas auxquels je n'ai pas pensé, mais c'etait drole a faire.

En bref, j'ai quand meme fait les fichiers compte.sh, compte_par_type.sh, compte_par_type_par_an.sh, et compte_lieux.sh
Pour la version de compte.sh. cela fonctionne ainsi :
```sh
for YEAR in 2016 2017 2018 # Rentre dans une boucle, permettant de definir la variable $YEAR comme successivement 2016, 2017 puis 2018
do
	echo "Annee $YEAR" # Affiche "Annee" suivi du numero de l'annee
	find . -name $(echo '*'$YEAR'*.ann') | xargs cat | grep "Location" | wc -l  # Recherche tous les fichiers qui ont l'annee dans leur nom, l'utilise comme arguments pour la commande cat, ne recupere que les tags "Location", et compte le nombre de ligne (Ce qui correspond au nombre de fois que le tag apparait)
done # Fin de la boucle
```


