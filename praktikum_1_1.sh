#!bin/bash

nomor=1

for file in /home/bryan/sisop/Modul_1/no1/nature/*.jpg
  do
    base64 -d $file | xxd -r > /home/bryan/sisop/Modul_1/no1/hasil/"hasil"$nomor".jpg"
    let nomor++
  done
