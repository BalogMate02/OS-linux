#nev: Balog Mate
#azonosito bmgi4405
#Írjon shell script-et, amely paraméterként két filenevet kap. Az első felhasználóneveket, a második pedig egy tetszőleges szöveget tartalmaz. A script minden felhasználóra az első file-ból megnézi, hogy az illető be van-e jelentkezve. Amennyiben igen, küld neki egy üzenetet (write), amely a második file szövegét tartalmazza. Ha az illető nincs bejelentkezve, akkor egy
#levelet küld neki (mail), amely a második file szövegét tartalmazza, és az email tárgya (Subject) pedig Uzenet [user]-tol, ahol [user] helyére a saját felhasználónevünket írjuk.
#A képernyőre minden esetben írjuk ki, hogy:
#  [time] uzenetet kuldtunk [user] felhasznalonak
#    vagy
#  [time] levelet kuldtunk [user] felhasznalonak
#Ha nem helyes az első állomány, és talál olyan szót amelyik nem felhasználónév, akkor a kiírt szöveg:
#  [user] nem letezik
#ahol [user] helyére a megfelelő felhasználónév, míg a [time] helyére az aktuális rendszeridő kerüljön.
#Megyjegyzés! Amennyiben nemlétező felhasználónévvel találkozunk, az üzenet kiírása után folytatjuk a feladat végrehajtását a többi felhasználónév feldolgozásával.

#!/bin/bash

#parameterek ellenorzese

if [ "$#" -ne 2 ]; then
	echo "ket parametert kell megadni" >&2
	exit 1
fi

if [ ! -f "$1" ]; then
	echo "az elso fajl nem letezik" >&2
	exit 1
fi

uzenet=$(cat "$2")

pontosido=$(date "+%Y-%m-%d%H:%M:%S")

while read user; do
	bejelentkezve=false
	while read line; do
		felh=$(echo $line | cut -d " " -f1)
		if [[ "$felh" == "$user" ]];then
			bejelentkezve=true
			break
		fi
	done <<< "$(who)" #csak mert ifben nem akart mukodni
	#echo "$user"
	if id "$user">/dev/null 2>&1;then
		if [[ "$bejelentkezve" == true ]];then
			#echo "$uzenet" | mail -s "Uzenet $user-tol" "$user"
                	#echo "[$pontosido] levelet kuldtunk $user felhasznalonak"
			echo "$uzenet" | write "$user"
                        echo "[$pontosido] uzenetet kuldtunk $user felhasznalonak"
		else
			echo "$uzenet" | mail -s "Uzenet $user-tol" "$user"
                        echo "[$pontosido] levelet kuldtunk $user felhasznalonak"
			#echo "$uzenet" | write "$user"
                	#echo "[$pontosido] uzenetet kuldtunk $user felhasznalonak"
		fi
	else
			echo "$user nem letezik"
	fi
done <"$1"
exit 0
