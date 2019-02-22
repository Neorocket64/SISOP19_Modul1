#!/bin/bash
cat /var/log/syslog | awk '!/sudo/' && '/cron/' | awk 'NF < 13' >> /home/ugarpac/modul1
#cat untuk melihat isi dari suatu file (as long as readable)
#log tidak berisi command sudo, tapi berisi command cron
#NF (Number of Field), sesuai dengan keinginan
