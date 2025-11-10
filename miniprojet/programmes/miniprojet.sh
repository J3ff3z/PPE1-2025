

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

echo "<table><tr><th>Index</th><th>Link</th><th>Code</th><th>Encodage</th><th>Word Count</th><tr>" >> '../tableaux/tableau-fr.html'

while read -r line;
do
	RESPONSE=$(curl -s -L -D - "$line") # On fait notre magnifique requete avec redirection pour eviter les 301

	CODE=$(echo $RESPONSE | head -n 1 | cut -d$' ' -f2) # Premiere ligne, deuxieme colone pour lecode HTTP
	ENCODAGE=$(printf '%s' "$RESPONSE" | grep charset | cut -d$' ' -f3) #Chope le charset le page avec grep (print pour garder le /r/n) et troisieme colone pour recup que le charset et pas le content-type
	ENCODAGE=$(echo "${ENCODAGE:8}"| tr -d '\r\n') # On retire les 8 premier caractere "charset=" et le /r/n situe a la fin pour eviter les retours a la ligne

	BODY=$(echo "$RESPONSE" | awk 'BEGIN{RS="\r\n\r\n"} {body=$0} END{print body}') #On va chopper le moment ou il y a une ligne vide (Separation headers/body), et on prends jusqu'a la fin du doc
	WORDCOUNT=$(printf '%s' "$BODY" | lynx -dump -stdin -nolist | wc -w)
	echo '<tr><td>'$COUNT'</td><td>'${line}'</td><td>'$CODE'</td><td>'$ENCODAGE'</td><td>'$WORDCOUNT'</td></tr>' >> '../tableaux/tableau-fr.html' # Formatage de la ligne
	COUNT=$(($COUNT+1))
done < "$FILE"

echo "</table>" >> '../tableaux/tableau-fr.html'
