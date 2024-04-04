#nev Balog Mate
#azonosito: bmgi4405

#Írjunk felügyelő programot, amely egy másodpercekben adott időintervallumot (továbbiakban idő) és két állománynevet kap paraméterként: az első felhasználóneveket tartalmaz, a második pedig csupa * karaktereket tartalmazó sorokkal elválasztott 5 különböző szöveget. idő intervallumonként figyeljük a második paraméterként megadott állományban felsorolt felhasználókat (akik nincsenek bejelentkezve, azokat figyelmen kívül hagyjuk), hogy mennyi ideje "lazsálnak" (idle). Az alábbiakban az n jelentése: n perc. Ha valaki esetében
#1<=n<2, küldjük el neki üzenetként az első szövegrészt (a második paraméterként megadott állományból)
#2<=n<3, a második szövegrészt, és így tovább...
#az illető több, mint 5 perce lazsál, azaz n>=5, akkor az utolsó szövegrészt
#Megjegyzések:
#egy bizonyos személynek ne küldjük el egymásután kétszer ugyanazt a szöveget
#ha valaki több, mint egy ablakban is be van jelentkezve, azt vegyük figyelembe, amelyikben a legkevesebb ideje lazsál

#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Használat: $0 ido felhasznalok uzenet"
    exit 1
fi

if [[ ! $1 =~ ^[0-9]+$ ]]; then
        echo "$1 nem szam"
        echo "Használat: $0 ido felhasznalok uzenet"
   	exit 1
fi

if [ ! -f $2 ]; then
     
     	echo "$2 nem szoveges allomany"
        echo "Használat: $0 ido felhasznalok uzenet"
     	exit 1
fi

if [ ! -f $3 ]; then
        echo "$3 nem szoveges allomany"
	echo "Használat: $0 ido felhasznalok uzenet"
        exit 1
fi

ido=$1
felhasznalok=$2

if [ ! -f $felhasznalok ]; then
    echo "Hiba: $felhasznalok nem letezik"
    exit 1
fi

uzenetek=($(awk -v FS="[*]+" '{for (i=1;i<=NF;i++) print $i}' "$3"))
#for uzenet in "${uzenetek[@]}"
#do
#    echo $uzenet
#done

while true; do
    while read felhasznalok; do
        idle=`w -h | awk -v user=$felhasznalo '$1 == user {print $5}' | awk -F: '{print $1*60+$2}'`
        if [ -n "$idle" ]; then
            if (( idle >= 5*60 )); then
                    echo "${uzenetek[5]}" | write $felhasznalo
            elif (( idle >= 4*60 )); then
                    echo "${uzenetek[4]}" | write $felhasznalo
            elif (( idle >= 3*60 )); then
                    echo "${uzenetek[3]}" | write $felhasznalo
            elif (( idle >= 2*60 )); then
                    echo "${uzenetek[2]}" | write $felhasznalo
            elif (( idle >= 1*60 )); then
                    echo "${uzenetek[1]}" | write $felhasznalo
            fi
        fi
    done < $2

    sleep $1
done
