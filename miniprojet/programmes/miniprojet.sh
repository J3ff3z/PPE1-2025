

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

echo "<html data-theme=\"dark\">  <head>    <meta charset=\"UTF-8\" />    <title>Programmation et Projet Encadré</title>    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css\">  </head>  <body>    <section class=\"section\">      <div class=\"container\">        <div class=\"hero has-text-centered\">          <div class=\"hero-body\">            <h1 class=\"title\">              Programmation et Projet Encadré              <br />              <br />              <img src=\"/PPE1-2025/images/plurital-logo.jpg\" />            </h1>          </div>        </div>        <div class=\"columns\">          <div class=\"column is-2 is-sidebar-menu\">            <aside class=\"menu\">              <ul class=\"menu-list\">                <li class=\"is-active\"><a href=\"/PPE1-2025/\">Accueil</a></li>                <li><a href=\"/PPE1-2025/miniprojet/tableaux/tableau-fr.html\">Tableaux</a></li>              </ul>            </aside>          </div>          <div class=\"column is-main-content box has-background-grey-darker\">            <div class=\"columns is-centered\">              <div class=\"column is-half\">                <div class=\"block content\"><table class=\"table\"" >> '../tableaux/tableau-fr.html'

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

echo "</table></div></div></div></div></div></div></section></body></html>" >> '../tableaux/tableau-fr.html'
