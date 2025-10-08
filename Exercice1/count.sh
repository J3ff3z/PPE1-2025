#!/usr/bin/bash

CHEMIN=$1
for d in $CHEMIN; do
	echo "Location "$(echo $(basename "$d")| cut -d'/' -f 1)":"
	find . -name $(echo '*'$(basename "$d")'*.ann') | xargs cat | grep Location | wc -l 
done;
