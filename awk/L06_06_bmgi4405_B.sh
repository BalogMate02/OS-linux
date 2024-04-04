# nev: Balog Mate
# azonosito: bmgi4405

#A paraméterként megadott szöveges állományok mindegyikére külön-külön, és összesítve is határozzuk meg (egyetlen awk scriptet és asszociatív tömbö(ke)t használva), hogy hány ugyanolyan karakterrel kezdődő sor van. Azaz írjuk ki minden állományra külön-külön, hogy:
#         --------[allomany]---------
#         [karakter]: [sorok száma]
#majd végül
#         --------osszesen---------
#         [karakter]: [sorok száma]
#ahol az [allomany] helykitöltő helyére az állomány neve, a [karakter] és a [sorok száma] helykitöltők helyére a megfelelő karakter, illetve a soroknak az összesített száma kerül. Csak akkor írjunk ki egy adott karaktert, ha van legalább egy sor, ami azzal kezdődik.
#Az összes állományra vonatkozóan azt is határozzuk meg, hogy melyik karakterrel kezdődik a legtöbb sor.

#!/bin/bash

awk ' 
#BEGIN {print "-----" FILENAME "-----"}
{
if (FILENAME != filenev) {
       	filenev=FILENAME
	for (kar in szamol) {
   	 if (szamol[kar] > 0) {
	      print kar ": " szamol[kar]
	      vegszamol[kar] = vegszamol[kar]+szamol[kar]
	      szamol[kar]=0
	      #print kar ": " szamol[kar]
    }
  }
 print ("-----" FILENAME "-----")
}
	
elsokar=substr($0,1,1)
szamol[elsokar]++

#if (szamol[elsokar] > legtobb) {
#        legtobb = szamol[elsokar]
#        leggyakoribb = elsokar
#	}

}
END {
#print ("-----" FILENAME "-----")
for (kar in szamol) {
	if (szamol[kar] > 0) {
		print kar ": " szamol[kar]
		vegszamol[kar] = vegszamol[kar]+szamol[kar]
	}
}
print "-----osszesen-----"
  for (kar in vegszamol) {
    if (vegszamol[kar] > 0) {
      print kar ": " vegszamol[kar]
      if (vegszamol[kar] > legtobb) {
        legtobb = vegszamol[kar]
        leggyakoribb = kar
       }
    }
  }
  print "A legtobb sor a(z) \"" leggyakoribb "\" karakterrel kezdodik."
}
' "$@"

