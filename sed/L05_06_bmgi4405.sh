#nev: Balog Mate
#Azonosito: bmgi4405

#A paraméterekként megadott állományokban szereplő minden nagybetűtől különböző karaktert cserélejen ki az első paraméterként megadott karakterre. A paraméterek sorrendje: karakter állományn(év/evek).

#!/bin/bash

if [ $# -lt 2 ]; then
        echo "nem megfelelo parameterezes"
        exit 1
fi

betu="$1"
shift

for file in "$@"; do
	if [ ! -f "$file" ]; then
                echo $file " nem szoveges allomany"
		continue
	fi
	sed -i 's/'[^A-Z]/$betu'/g' $file*
done
