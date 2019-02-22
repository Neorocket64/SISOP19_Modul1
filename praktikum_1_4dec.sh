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
if [[ ${sourcef:2:1} =~ [0-9]+$ ]]
then
	jam="${sourcef:1:1}${sourcef:2:1}"
fi

smt=$(<$sourcef)
#echo $smt
for (( i=0; i<${#smt}; i++));
do
	asc2=`chr2ascii ${smt:i:1};`

	#Untuk lower case
	if [ $asc2 -le 122 ] && [ $asc2 -ge 97 ] then
 	   	let "asc2=asc2-96"
 	  	let "asc2=asc2-jam"
		if [ $asc2 -lt 0 ] then
     		let "asc2=asc2+25"
    	fi
    	let "asc2=asc2+96"
    	deproc="$deproc`ascii2chr $asc2`"

    #Untuk Upper Case
	elif [ $asc2 -le 90 ] && [ $asc2 -ge 65 ] then
		let "asc2=asc2-64"
		let "asc2=asc2-jam"
		if [ $asc2 -lt 0 ] then
      		let "asc2=asc2+25"
    	fi
    	let "asc2=asc2+64"
    	deproc="$deproc`ascii2chr $asc2`"

    #Untuk Non-Alpabhet
    else
    	deproc="$deproc${smt:i:1};"

	echo $deproc > "decrypted".txt
	fi
done
#echo $deproc