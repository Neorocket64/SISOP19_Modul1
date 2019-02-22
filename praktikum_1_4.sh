#!/bin/bash

jam="`date +\"%H\"`"
menit="`date +\"%M\"`"
tanggal="`date +\"%d\"`"
bulan="`date +\"%m\"`"
tahun="`date +\"%Y\"`"

procfile="/home/ugarpac/Documents/sisopfile/one/$jam:$menit $tanggal-$bulan-$tahun"
#echo "$procfile"

#convert ASCII table menjadi karakter
ascii2chr() {
	[ "$1" -lt 256 ] || return 1
	printf "\\$(printf '%03o' "$1")"
}
#convert karakter menjadi ASCII table
chr2ascii() {
	LC_CTYPE=C printf '%d' "'$1"
}

isi=$(<'/var/log/syslog')
#echo $isi
for (( i=0; i<${#isi}; i++));
do
	#echo "${#isi}"
	asc2=`chr2ascii ${isi:i:1};`
	#echo "$asc2"

	#For lowercase
  	if [ $asc2 -le 122 ] && [ $asc2 -ge 97 ]
  		then
 	   	let "asc2=asc2-97"
 	   	let "asc2=asc2+jam"
 		#something similar happen
		if [ $asc2 -gt 25 ]
	 	then
	     		let "asc2=asc2-25"
	    fi
    	let "asc2=asc2+97"
    	enproc="$enproc`ascii2chr $asc2`"

	#For Uppercase
	elif [ $asc2 -le 90 ] && [ $asc2 -ge 65 ]
		then
		let "asc2=asc2-65"
		let "asc2=asc2+jam"
		#after z, back to a
	   	if [ $asc2 -gt 25 ]
	    	then
	      	let "asc2=asc2-25"
	    fi
		let "asc2=asc2+65"
    	enproc="$enproc`ascii2chr $asc2`"
  	
  	#For Non-Alpabhet
  	else
  		enproc="$enproc${isi:i:1}"

	echo $enproc > "$procfile".txt
	fi
done