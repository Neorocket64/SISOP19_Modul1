# SISOP 2019 : Modul 1 [Soal Shift]

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