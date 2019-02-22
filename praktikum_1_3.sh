#!/bin/bash
loop=1
#folder password di /home/ugarpac/Documents/sisopfile/one/pw
#flag loop berfungsi untuk infinite loop
while [ $loop -gt 0 ]
do
	while
		pwd="$(dd if=/dev/urandom|tr -dc A-Za-z0-9|head -c 12)"
		#do random, translate within non-unicode, sampai 12
		#echo "$pwd"
		agk=0 lo=0 up=0 
		for (( i=0; i<${#pwd}; i++));
		do
			#menghitung jenis karakter dalam 1 string
			if [[ ${pwd:i:1} =~ [0-9]+$ ]] then
				let agk=$agk+1
			fi

			if [[ ${pwd:i:1} =~ [a-z]+$ ]] then
				let lo=$lo+1
			fi

			if [[ ${pwd:i:1} =~ [A-Z]+$ ]] then
				let up=$up+1
			fi
		done
		#echo "$agk $lo $up"
		#cek jika semua elemen sudah ada (lowercase, uppercase, dan angka)
		[ $agk -lt "1" ] || [ $lo -lt "1" ] || [ $up -lt "1" ]
	do :;
	done

	#cek isi file sebelumnya
	i=1
	flag=0
	file=/home/ugarpac/Documents/sisopfile/one/password
	while [ -s "$file$i.txt" ]
	do
		banding=$(<$file$i.txt)
		if test "$banding" = "$pwd" then
			flag=1
			break
		fi
		let i=$i+1
	done
	if [[ flag = 1 ]] then 
		echo "generated ini sama dengan file$i !"
		continue
	fi
	break
done
#buat file berisi variabel "pwd"
echo "$pwd" > $file$i.txt