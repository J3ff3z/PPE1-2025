#!/usr/bin/bash


YEAR=0
YEAREND=0
MONTH=1
MONTHEND=12
TYPE="*"
COUNT=10

HAVEYEAR=false
HAVEYEAREND=false
HAVEMONTH=false
HAVEMONTHEND=false
HAVECOUNT=false

#################################################################################

help(){
	# Help
	echo "NAME"
	echo ""
	echo "	count - count annotation from ann files in the directory and subdirectory"
	echo " "
	echo "SYNOPSIS"
	echo ""
	echo "	count [-t typeName] [-a year] [-b yearEnd] [-c topCount] [-h] [-m month] [-n monthEnd]"
	echo " "
	echo "DESCRIPTION"
	echo ""
	echo "	count the tags from all the .ann files in the directory and subdirectory."
	echo ""
	echo "	The -a option allow to check only files from the year specified in arguments. Paired with the -b options, it will check all the files from the year -a to the year -b. -b cannot be be specified without an -a options"
	echo ""	
	echo "	The -m and -n work like the options -a and -b, but for the months"
	echo ""
	echo "	Caution, .ann files must be of the format yyyy_mm_dd_*.ann to have to works with the options -abmn"
	echo " "
	echo "OPTIONS"
	echo ""
	echo "	-t"
	echo "		Filter to only count the typeName's type given in argument"
	echo "	-a"
	echo "		Filter to only count the tags from the file's year"
	echo "	-b"
	echo "		Can only be used paired with -a. Filter from year to yearEnd"
	echo "	-c"
	echo "		Output the first topCount tags duplicate count's"
	echo "	-h"
	echo "		Return the help menu"
	echo "	-m"
	echo "		Filter to only count the tags from the file's month"
	echo "	-n"
	echo "		Can only be used paired with -m. Filter from the month to monthEnd. If -a and/or -b or specified, will filter from year's month to yearEnd's monthEnd"
}


###############################################################################
# Get the input options

while getopts "t:a:b:hc:m:n:" option; do
	case $option in
		t) # Filtre selon le type donne en argument
			TYPE="$OPTARG"
			;;
		a) # Filtre par annee
			YEAR="$OPTARG"
			if ! [[ $YEAR =~ ^[0-9]+$ ]]; then
				echo "Error: Invalid Arguments. The year must be a number"
				exit 1
			fi
			HAVEYEAR=true
			;;
		b) # Filtre par annee
			YEAREND="$OPTARG"
			if ! [[ $YEAREND =~ ^[0-9]+$ ]]; then
				echo "Error: Invalid Arguments. The year must be a number"
				exit 1
			fi
			HAVEYEAREND=true
			;;
		c)
			COUNT="$OPTARG"
			if ! [[ $COUNT =~ ^[0-9]+$ ]]; then
				echo "Error: Invalid Arguments. The count must be a number"
				exit 1
			fi
			HAVECOUNT=true
			;;
		h) # help
			help
			exit 1
			;;
		m)
			MONTH="$OPTARG"
			if ! [[ $MONTH =~ ^[0-9]+$ ]]; then
				echo "Error: Invalid Arguments. The year must be a number"
				exit 1
			fi
			HAVEMONTH=true
			;;
		n)
			MONTHEND="$OPTARG"
			if ! [[ $MONTHEND =~ ^[0-9]+$ ]]; then
				echo "Error: Invalid Arguments. The year must be a number"
				exit 1
			fi
			HAVEMONTHEND=true
			;;
		\?) # Invalid option
			echo "Error: Invalid option. Please use -h to see the help"
			exit;;
	esac
done

###############################################################################
# Checks

if $HAVEYEAREND; then
	if ! $HAVEYEAR; then
		echo "Error: -a option must be specified if -b option is specified"
		exit 1
	fi
else
	YEAREND=$YEAR;
fi

if $HAVEMONTHEND; then
	if ! $HAVEMONTH; then
		echo "Error: -m option must be specified if -n option is specified"
		exit 1
	fi
fi



while [ "$YEAR" -le "$YEAREND" ]; do
	if [ "$YEAR" -eq 0 ]; then
		YEAR='*'
	fi

	echo "$TYPE $YEAR:"
	
	FINALANSWER=0
	
	if [ "$YEAR" = "$YEAREND" ]
	then
		if ! $HAVEMONTHEND
		then
			ME=$MONTH
		else
			ME=$MONTHEND
		fi
	else
		ME=12
	fi
	
	
	while [ "$MONTH" -le "$ME" ]; do
	
		if [ "$MONTH" -le "09" ]
		then 
			ANSWER=$(find . -name $(echo '*'$YEAR'_0'$MONTH'_*.ann') | xargs cat)
		else 
			ANSWER=$(find . -name $(echo '*'$YEAR'_'$MONTH'_*.ann') | xargs cat)
		fi
		
		if [ "$TYPE" != "*" ]
		then
			ANSWER=$(echo "${ANSWER}" | grep "$TYPE" | wc -l )
		else
			ANSWER=$(echo "${ANSWER}" | wc -l )
		fi
		FINALANSWER=$(($FINALANSWER+$ANSWER))
		((MONTH++))
	done
	MONTH=1
		
	echo "$FINALANSWER"
	
	if [ "$YEAR" = "*" ]; then
		YEAR=0
	fi
	((YEAR++))
done

