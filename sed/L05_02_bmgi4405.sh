#nev: Balog Mate
#ayonosito bmgi4405

#A paraméterekként megadott állomány(ok)ból törölje ki azokat a sorokat, amelyek az első paraméterként megadott szóval kezdődnek. A paraméterek sorrendje: szó állományn(év/evek).

#!/bin/bash

if [ $# -lt 2 ]; then
	echo "nem megfelelo parameterezes"
	exit 1
fi

szo="$1"
shift

for file in "$@"; do
	if [ ! -f "$file" ]; then
		echo $file " nem szoveges allomany"
		continue
	fi
	sed -i '/^'$szo'/d' "$file"
done
