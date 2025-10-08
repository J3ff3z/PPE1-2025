#!/usr/bin/bash

# TXT

for f in ./*.txt; do
	year=$(echo $(basename "$f")| cut -d'_' -f 1)
	month=$(echo $(basename "$f")| cut -d'_' -f 2)
	dir=$(echo './txt/'$year'/'$month'/')
	mkdir -p $dir
	mv $f $dir
done

# ANN

for f in ./*.ann; do
	year=$(echo $(basename "$f")| cut -d'_' -f 1)
	month=$(echo $(basename "$f")| cut -d'_' -f 2)
	dir=$(echo './ann/'$year'/'$month'/')
	mkdir -p $dir
	mv $f $dir
done

#IMG
mkdir -p ./img/Taipei ./img/Paris ./img/Tokyo ./img/Rome ./img/Washington ./img/Berlin ./img/Kyoto
mv *Berlin* ./img/Berlin
mv *Taipei* ./img/Taipei
mv *Paris* ./img/Paris
mv *Rome* ./img/Rome
mv *Tokyo* ./img/Tokyo
mv *Washington* ./img/Washington
mv *Kyoto* ./img/Kyoto
