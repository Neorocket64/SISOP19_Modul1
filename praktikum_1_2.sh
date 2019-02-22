#!/bin/bash

printf "soal 2a\nNegara dengan penjualan terbanyak ditahun 2012 : "
awk -F ',' '{if ($7 == 2012) {i[$1]+=$10;}} END {for (x in i) print i[x] "," x}' WA_Sales_Products_2012-14.csv | sort -nr | head -1 | awk -F ',' '{print $2}'
printf "\n"

#=============================================================================#

printf "soal 2b\nProduct line dengan penjualan terbanyak : \n"
IFS=$'\n'
arr=( $( awk -F ',' '{if ($7 == 2012 && $1 = $result ) {i[$4]+=$10;}} END {for (x in i) print i[x] "," x;}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F ',' '{print $2}' ) )
echo "${arr[0]}"
echo "${arr[1]}"
echo "${arr[2]}"
printf "\n"

#============================================================================#

printf "soal 2c\nProduct dengan penjualan terbanayak : \n"
awk -F ',' '{if ($1 == "United States" && $7 == 2012 && ($4 == "Personal Accessories" || $4 == "Camping Equipment" || $4 == "Outdoor Protection" )) {i[$6]+=$10;}} END {for (x in i) print i[x] "," x;}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F ',' '{print $2}'
printf "\n"

