# SISOP 2019 : Modul 1 [Soal Shift] Kelompok D8

## #1 Dekripsi file yang diekstrak

* Shellscript:

`
#!bin/bash

nomor=1

for file in /home/bryan/sisop/Modul_1/no1/nature/*.jpg
  do
    
    base64 -d $file | xxd -r > /home/bryan/sisop/Modul_1/no1/hasil/"hasil"$nomor".jpg"
    
    let nomor++
  
  done
`

* Crontab

`14 14 14 2 Fri /home/bryan/sisop/Modul_1/no1/Soal1.sh`

### Penjelasan
* base64 -d	: decoding

* xxd -r	: revert agar file bisa dibuka

* Variabel nomor akan digunakan untuk menamai file yang sudah didekripsi. Proses dekripsi memanfaatkan hexdump (xxd) dan base64. Tiap file yang ada di folder /home/bryan/sisop/Modul_1/no1/nature/*.jpg akan didecode dengan base64, kemudian dikembalikan dengan hexdump agar bisa dibuka, kemudian dimasukkan kedalam folder “hasil”.

## #2 Membuat Laporan
`
#!/bin/bash

printf "soal 2a\nNegara dengan penjualan terbanyak ditahun 2012 : "

awk -F ',' '{if ($7 == 2012) {i[$1]+=$10;}} END {for (x in i) print i[x] "," x}' WA_Sales_Products_2012-14.csv | sort -nr | head -1 | awk -F ',' '{print $2}'

printf "\n"

#======================================================================#

printf "soal 2b\nProduct line dengan penjualan terbanyak : \n"

IFS=$'\n'

arr=( $( awk -F ',' '{if ($7 == 2012 && $1 = $result ) {i[$4]+=$10;}} END {for (x in i) print i[x] "," x;}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F ',' '{print $2}' ) )

echo "${arr[0]}"

echo "${arr[1]}"

echo "${arr[2]}"

printf "\n"

#======================================================================#

printf "soal 2c\nProduct dengan penjualan terbanayak : \n"

awk -F ',' '{if ($1 == "United States" && $7 == 2012 && ($4 == "Personal Accessories" || $4 == "Camping Equipment" || $4 == "Outdoor Protection" )) {i[$6]+=$10;}} END {for (x in i) print i[x] "," x;}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F ',' '{print $2}'

printf "\n"
`

### Penjelasan
A. Memanfaatkan awk -F agar dapat menggunakan ‘,’ sebagai pemisah string.

Lalu data yang diambil hanya data dari tahun 2012 dengan if ($7 == 2012).

Tiap negara di kolom pertama, Quantitynya dijumlahkan. Lalu print jumlah i(x) dengan state (x).

B. Ditambahkan filter state dalam pemfilteran tahun if ($7 == 2012 && $1 = $result ) , agar hasilnya sesuai dengan poin a. 

Setiap Product Line ($4) dijumlahkan Quantitynya.

Print total i[x] dan product linenya.

Hasilnya diletakkan didalam array.

Lalu print 3 data di array pertama.

IFS digunakan agar data di array dapat disimpan perbarisnya.

C. Ditambahkan filter Product Line {if ($1 == "United States" && $7 == 2012 && ($4 == "Personal Accessories" || $4 == "Camping Equipment" || $4 == "Outdoor Protection" ))} untuk menyesuaikan dengar array di poin b.

Kemudian diurutkan dan diambil 3 paling atas.

## #3 Membuat file berisi random generated string
### Pembuatan
Pertama, generate random string sampai 12 karakter menggunakan;

`dd if=/dev/urandom|tr -dc A-Za-z0-9|head -c 12`

yang akan disimpan melalui sebuah variabel.

Kemudian, supaya jenis karakter; `lowercase, uppercase, dan angka` ada dalam string tersebut,
membuat variabel masing-masing jenis karakter.

Diperiksa seluruh karakter dalam string, setiap ada salah satu jenis dari 3 tersebut, maka value variabelnya bertambah

Setelah itu, masuk bagian cek string pada file lain. Untuk ini, menambah variabel pembanding yang mengambil nilai file lain dalam loop.

Loop ini berisi salah satu variabel, yaitu `i`, untuk menyimpan angka yang ditujukan pada file lain `text"i".txt` -> `text1.txt`. Jika tidak menemukan file dalam angka tersebut, maka akan dibuatkan file dengan angka tersebut.

### Kendala
Untuk kasus seperti berikut;

`f1 | [] | f3 | f4`

Karena ini, hanya akan diperiksa file sebelumnya (f1) dan kemudian membuat file yang belum ada (f2), tetapi tidak memeriksa file selanjutnya.

Untuk sekarang, tidak menemukan solusi

## #4 Logging, Encrypt, dan Decrypt
### Encrypt
Untuk konversi karakter menuju ASCII dan sebaliknya, menggunakan;

>ascii2chr() {
	[ "$1" -lt 256 ] || return 1
	printf "\\$(printf '%03o' "$1")"
}
chr2ascii() {
	LC_CTYPE=C printf '%d' "$1"
}

Ada 3 percabangan untuk selanjutnya,
* Jika alfabet lowercase
* Jika alfabet Uppercase
* Jika bukan alfabet

Khusus untuk 2 pertama, menggunakan variabel yang berisi hasil konversi `chr2ascii`;
1. Mengurangi value dengan (ascii alfabet pertama jenis tersebut - 1)
2. Value ditambah dengan jam saat logging
3. (sesuai syarat) Jika urutan alfabet sudah melebihi `z`, maka balik dari `a` (- 25)
4. Value ditambah lagi dengan (ascii alfabet pertama jenis tersebut - 1) 
5. Merubah kembali menjadi karakter menggunakan `ascii2chr`

Karakter akan dimasukkan menuju sebuah variabel.

Proses ini berlangsung hingga akhir dari file tersebut.

Setelah itu, variabel yang menyimpan hasil enkripsi akan dioutput di suatu folder

### Decrypt
Berbanding balik prosesnya dengan enkripsi pada jenis alfabet, menggunakan nama file sebagai acuan `jam`;
1. Mengurangi value dengan (ascii alfabet pertama jenis tersebut - 1)
2. Value dikurangi dengan value `jam` sesuai pada file tersebut
3. Jika urutan alfabet sudah kurang dari `a`, maka balik dari `z` (+ 25)
4. Value ditambah lagi dengan (ascii alfabet pertama jenis tersebut - 1) 
5. Merubah kembali menjadi karakter menggunakan 'ascii2chr'

### CRONTAB

`* 1 * * *`

### Kendala

Untuk konversi, menggunakan sumber lain yang belum dipelajari sepenuhnya kodingan tersebut.

### Sumber :
> https://unix.stackexchange.com/questions/92447/bash-script-to-get-ascii-values-for-alphabet

## #5 Pembatasan logging
### Pembuatan
* Menggunaan cat untuk memeriksa file log.
> cat /var/log/syslog
* Tidak memperlihatkan sudo, tapi memperlihatkan cron
> awk '!/sudo/' && '/cron/'
* Membatasi field setiap baris menggunakan NF
> awk 'NF < 13' >> /home/ugarpac/modul1

### CRONTAB

`2-30/6 * * * *`
