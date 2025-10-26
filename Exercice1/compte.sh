#!/usr/bin/bash

for YEAR in 2016 2017 2018
do
	echo "Annee $YEAR"
	find . -name $(echo '*'$YEAR'*.ann') | xargs cat | grep "Location" | wc -l 
done