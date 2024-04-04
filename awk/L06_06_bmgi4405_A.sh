#!/bin/bash

# Nev: Balog Mate
# Azonosito: bmgi4405

#A) Egy paraméterként megadott felhasználó esetén határozzuk meg azt a bejelentkezését, amikor a legtöbb ideig volt bejelentkezve. Írjuk ki az alábbi információkat:
#melyik nap (dátum: hónap és nap) történt ez a bejelentkezés
#melyik gépről jelentkezett be
#mennyi ideig volt bejelentkezve (percben)
#Megjegyzések:
#vegyük figyelembe, hogy olyan eset is lehetséges, hogy valaki több napon keresztül be volt jelentkezve
#a még aktív bejelentkezéseket (still logged in) nem kell feldolgozni.

if [ "$#" -ne 1 ]; then
	echo "egy parameter kell" >&1
	exit 1
fi

felh=$1
if ! id $felh ;then
	echo "$felh nem letezik"
	exit 1
fi

last $felh | awk '
BEGIN { FS=" " }
    $4 != "still" {
        #print $10
        bejelido = $10
        #print bejelido
        #print $9 " "$7
        #print (cut -c )
        #print (cut -c 5-6 $10)
	#datum = $5 " " $6 " " $7
	#print datum
	#bejelido = (${$9:0:2} - ${$7:0:2} * 60) + ${$9:3:2} - ${$7:3:2}
	#print bejelido
	#print $7 "   " $9
	#system(date -d "ido" '$bejelido' +%s) 
	ora = substr(bejelido, 2, 2)
	perc = substr(bejelido, 5, 2)
	ido=ora*60+perc
        if (bejelido > maxbejelido) {
            maxbejelido = bejelido
            maxbejeldatum = $5" "$6
            maxbejelhost = $3
            #maxbejelidot = $10
            #ora = system(cut -c 2-3 $10)
            #print ora
            #perc = system(cut -c 5-6 $10)
            #maxbejelidot = system(cut -c 2-3 $10) * 60 + system(cut -c 5-6 $10) #atalakitja percre
	    maxbejelido = ido
        }
    }
    END {
        print "Dátum: " maxbejeldatum
        print "Gép: " maxbejelhost
	print "Legtöbb ideig bejelentkezve: " maxbejelidot " percig"
    }
'

