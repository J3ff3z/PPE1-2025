

if [[ $# -ne 1 ]]; then
	echo "Need one argument"
	exit
fi

FILE=$1

if [[ -f $FILE ]]; then
	FILE=$FILE
else
	echo "Please add a file in argument"
	exit
fi

COUNT=0

while read -r line;
do
	HEADER=$(curl -s -I ${line})
	CODE=$(echo $HEADER | head -n 1 | cut -d$' ' -f2)
	ENCODAGE=$(curl -I ${line} | head -n 8)
	echo $ENCODAGE
	echo $COUNT'	'${line}'	'$CODE;
	COUNT=$(($COUNT+1))
done < "$FILE"
