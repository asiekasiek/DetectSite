#!/bin/bash

#Zmienna do obliczenia wskaźnika bezpieczeństwa strony

security=0

#Wczytanie adresu URL

echo "Wprowadź adres URL: "
read URL

#1. Sprawdzenie czy strona jest szyfrowana
#Jeśli jest szyfrowana to zmienna security zwiąksza się o 1
#jeśli strona nie jest szyfrowana zmienna security się nie zmienia

URL_wyc=${URL:0:5};

if [ "https" == "$URL_wyc" ]; then
	echo "Bezpieczna strona - https"
	let security=$security+1
else
	echo "Zagrożenie - brak https"
fi

#2. Porównanie URL z bazą adresów URL, które są bezpieczne

baza_bezpieczna=(
https://www.pkobp.pl/
https://www.pekao.com.pl/
https://www.aliorbank.pl/
https://www.getinbank.pl/
https://www.pocztowy.pl/
https://www.santander.pl/
https://www.ing.pl/
https://www.mbank.pl/
https://www.bnpparibas.pl/
https://www.bankmillennium.pl/
https://www.credit-agricole.pl/
https://facebook.com/
https://gmail.com
https://www.gaz-system.pl/pl
https://www.lotos.pl/
https://www.orlen.pl/pl
https://www.gkpge.pl/
https://pgnig.pl/
https://www.revolut.com/pl-PL/
https://www.tauron.pl/dla-domu
https://www.tesla.com/pl_pl)
##echo $baza_bezpieczna[3]

element_tablicy=1
echo $baza_bezpieczna[$element_tablicy]

if [ "$URL" == "$baza_bezpieczna[$element_tablicy" ]; then
        echo "Strona jest w bazie bezpiecznych adresów"
        let security=$security+1
else
        echo "Zagrożenie - nie ma strony w bazie bezpiecznych adresów"
fi

echo $security

#3. Sprawdzanie czy w URL występuje "wp_content"

wp_content="wp_content"

if [[ $URL = *$wp_content* ]]; then
        echo "Strona niebezpieczna - zawiera wp_content"
else
        echo "Strona bezpieczna - nie zawiera wp_content"
	let security=$security+1
fi

echo $security

#4. Sprawdzanie czy w URL występuje ".ru lub

ru=".ru"

if [[ $URL = *$ru* ]]; then
        echo "Strona niebezpieczna - zawiera domenę .ru"
else
        echo "Strona bezpieczna - nie zawiera domeny .ru"
        let security=$security+1
fi

echo $security

#5. Sprawdzanie czy w URL występuje ".cn lub

cn=".cn"

if [[ $URL = *$cn* ]]; then
        echo "Strona niebezpieczna - zawiera domenę .cn"
else
        echo "Strona bezpieczna - nie zawiera domeny .cn"
        let security=$security+1
fi

echo $security

#6. Sprawdzanie whois url

URLskrocony=${URL#*.};
echo $URLskrocony
#whois=whois ${URLskrocony}
#echo $whois
echo | whois ${URLskrocony}
echo "Czy uważasz, że informacje podane powyżej świadczą o tym, że strona jest bezpieczna?"
echo "Jeśli tak, wciśniej T, jeśli nie, wciśnij N "
read TlubN

if [[ $TlubN = "T" ]]; then
        echo "Strona bezpieczna - ocena whois"
	let security=$security+1
elif [[ $TlubN = "N" ]]; then
	echo "Strona niebezpieczna - ocena whois"
else
        echo "Błąd podczas wprowadzania odpowiedzi"
fi

echo $security

#7. Obliczenie współczynnika bezpieczeństwa strony

let wspolczynnik=($security*100/6)
echo $wspolczynnik "% - współczynnik bezpieczeństwa strony"

if [[ $wspolczynnik > 50 ]]; then
        echo "Strona bezpieczna - interpretacja końcowa"
        let security=$security+1
else
        echo "Strona niebezpieczna - ocena whois"
fi

