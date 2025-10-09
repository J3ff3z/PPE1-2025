#!/usr/bin/bash


YEAR=0
TYPE="*"


#
Help(){
	echo "help"
}


# Get the input options

while getopts "t:a:hc" option; do
	case $option in
		t) # Filtre selon le type donne en argument
			TYPE="$OPTARG"
			;;
		a) # Ordonne par annee
			YEAR="$OPTARG"
			if ! [[ $YEAR =~ ^[0-9]+$ ]]; then
				echo "Error: Invalid Arguments. The year must be a number"
				exit 1
			fi
			;;
		h) # help
			Help
			exit 1
			;;
		\?) # Invalid option
			echo "Error: Invalid option. Please use -h to see the help"
			exit;;
	esac
done


if [ "$YEAR" -eq 0 ]; then
	YEAR='*'
fi

echo "$TYPE $YEAR:"
if [ "$TYPE" != "*" ]
then
	find . -name $(echo '*'$YEAR'*.ann') | xargs cat | grep "$TYPE" | wc -l 
else
	find . -name $(echo '*'$YEAR'*.ann') | xargs cat | wc -l
fi
