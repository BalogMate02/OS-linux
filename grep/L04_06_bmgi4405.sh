#nev: Balog Mate
#azonosito: bmgi4405

#Írassa ki a paraméterként megadott napon és gépről bejelentkezett felhasználók azonosítóját. A paraméterek sorrendje: nap hostname, ahol a nap az aktuális hónap egy napja, számmal írva, míg a hostname lehet IP cím vagy a gép host neve (pl. nessie.cs.ubbcluj.ro)
#Az eredményt lista formájában írjuk ki a képernyőre, a következő formában:
#[user1]
#[user2]
#...
#[userN]
#ahol a [user] helyett a megfelelő felhasználóneveket jelenítsük meg.

#!/bin/bash

#parameterek ellenorzese

if [ $# -ne 2 ]; then
	echo "helytelen parameterhasznalat" >&2
	exit 1
fi



nap=$1
honap=$(date +%m)
host=$2

#echo "$honap"
datum1=$(date +%Y-%m-$nap)
nap=$((nap + 1))
datum2=$(date +%Y-%m-$nap)
#echo $datum 
#felhasznalok=$(last -a -s $datum1 -t $datum2 | grep -o '^[A-Za-z0-9]\+' | cut -d' ' -f1 )
#felhasznalok=$(grep -o '^[A-Za-z0-9]\+' | sort -u)

felhasznalok=$(last -a -F -s $datum1 -t $datum2 | grep $host | grep -o '^[A-Za-z0-9]\+' | uniq)


echo "$felhasznalok"
#for user in $felhasznalok; do
	
	#if [[ $bejnap -eq $day ]];then
	#	echo "$felhasznalok"
	#fi
#done
