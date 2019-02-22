#!/bin/bash

#convert ASCII table menjadi karakter
ascii2chr() {
	[ "$1" -lt 256 ] || return 1
	printf "\\$(printf '%03o' "$1")"
}
#convert karakter menjadi ASCII table
chr2ascii() {
	LC_CTYPE=C printf '%d' "'$1"
}

read sourcef
#echo"$sourcef"
#membaca jam dengan deteksi digit ke-2 (karena 1 digit)
if [[ ${sourcef:0:1} =~ ^[0-9]+$ ]]
	then
	jam="${sourcef:0:1}${sourcef:1:1}"
fi
echo "$jam"

smt=$(<"$sourcef")
#echo $smt
for (( i=0; i<${#smt}; i++));
do
	asc2=`chr2ascii ${smt:i:1};`

	#Untuk lower case
	if [ $asc2 -le 122 ] && [ $asc2 -ge 97 ]
		then
 	   	let "asc2=asc2-97"
 	  	let "asc2=asc2-jam"
 	  	echo "lol-$asc2"
		if [ $asc2 -lt 0 ]
			then
     		let "asc2=asc2+25"
    	fi
    	let "asc2=asc2+97"
    	process="$process`ascii2chr $asc2`"
    	echo "$asc2"

    #Untuk Upper Case
	elif [ $asc2 -le 90 ] && [ $asc2 -ge 65 ]
		then
		let "asc2=asc2-65"
		let "asc2=asc2-jam"
		if [ $asc2 -lt 0 ]
			then
      		let "asc2=asc2+25"
    	fi
    	let "asc2=asc2+65"
    	process="$process`ascii2chr $asc2`"

    #Untuk Non-Alpabhet
    else
    	process="$process${smt:i:1}"

	echo $process > "$sourcef""-decrypted".txt
	fi
done
#echo $process