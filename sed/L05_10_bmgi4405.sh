#nev: Balog Mate
#azonosito: bmgi4405

#A paraméterekként megadott állományok soraiban cserélje fel az első és harmadik szót. A szavak csak betűket tartalmaznak, minden más karaktert elválasztó karakternek tekintünk.

#!/bin/bash
for file in "$@"; do
        if [ ! -f "$file" ]; then
                echo $file " nem szoveges allomany"
                continue
        fi

	#sed -i -E 's/^(\w+)\s+(\w+)\s+(\w+)/\3 \2 \1/' $file
	#sed -i -E 's/^([^a-zA-Z]*)([a-zA-Z]+)(.*[^a-zA-Z])([a-zA-Z]+)([^a-zA-Z]*)$/\1\4\3\2\5/' $file
	#sed -i -E 's/^([^a-zA-Z]*)([a-zA-Z]+)[^a-zA-Z]+([a-zA-Z]+)(.*)$/\1\3\2\4/' $file
	#sed -i -E 's/^([^a-zA-Z]*)([a-zA-Z]+)([^a-zA-Z]+)([a-zA-Z]+)([^a-zA-Z]*)$/\1\4\3\2\5/' $file
	#sed -i -E 's/^([^a-zA-Z]*)([a-zA-Z]+)[^a-zA-Z]+([a-zA-Z]+)(.*)$/\1\3\2\4/' $file
	#sed -i -E 's/^(\w+)(.*[^a-zA-Z])(\w+)(.*[^a-zA-Z])(\w+)/\3 \2 \1/' $filev #a , és a - is elválasztónak minősül
	sed -i -E 's/^([a-zA-Z]*)([^a-zA-Z]+[a-zA-Z]+[^a-zA-Z]+)([a-zA-Z]*)(.*)/\3\2\1\4/g' $file	

done
