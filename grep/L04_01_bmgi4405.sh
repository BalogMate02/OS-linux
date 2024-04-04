#Nev: Balog Mate
#azonosito: bmgi4405

#Írassa ki a paraméterként megadott katalógusban és annak alaktalógusaiban szereplő szöveges állományok . karakterrel vagy számjeggyel kezdődő sorait. A találatok kiírásánál írjuk ki az állomány nevét, alája az illeszkedő sorokat, a következő módon:
#[allomany1]
#1sor
#.sor
#2sor
#--------------------
#[allomany2]
#.sor1
#.sor2
#.sor3
#A különböző állományokra kiírt információkat válasszuk el egymástól egy -------------------- sor használatával.

#!/bin/bash

if [ ! -d "$1" ];then
	exit 1
fi

fileok=$(find "$1" -type f)
#fileok=$(file -b "$1")
#echo "$fileok"

for file in $fileok;do
	if file -b $file | grep -q text; then

		eredmeny=$(grep '^[0-9.]' "$file")
		#echo "$eredmeny"
		if [ "$eredmeny" != "" ];then
			echo "$(basename "$file")" #nem irja ki az utvonalat
			#echo "$file"
			echo "$eredmeny"
			echo "-------------------"
		eredmeny=""
		fi
	fi
done
