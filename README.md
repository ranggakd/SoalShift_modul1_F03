# SoalShift_modul1_F03
Keperluan tugas laboratorium Sistem Operasi 2019

---
## NO 4

 Lakukan backup file syslog setiap jam dengan format nama file
“jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:  
- Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.
- Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya. 
- Setelah huruf z akan kembali ke huruf a
- Backup file syslog setiap jam.
- Dan buatkan juga bash script untuk dekripsinya.

**Jawaban**


---
## NO 5

Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:  
- Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.
- Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
- Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.
- Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

**Jawaban**

1. Membuat file script di /home/rak dengan nama soal5.sh  
`awk '(/cron/ || /CRON/) && (!/sudo/) && (NF < 13)' /var/log/syslog  >> /home/rak/modul1/soalno5.log`  
Penjelasan:  
`awk '...'`  
command awk sebagai text processor  
`(/cron/ || /CRON/)`  
mengembalikan benar jika pola 'cron' atau 'CRON'  
`&&`  
operator dan  
`(!/sudo/)`  
mengembalikan benar jika pola selain 'sudo'  
`&&`  
operator dan  
`(NF < 13)`  
mengembalikan benar jika number of field kurang dari 13  
`/var/log/syslog`  
path file yang menjadi input  
`>>`  
redirection dengan append data di akhir file  
`/home/rak/modul1/soalno5.log`  
path file yang menjadi output

2. Pastikan service rsyslog sedang berjalan dengan command  `service rsyslog status` jika mengembalikan selain `* rsyslogd is running` , maka aktifkan dengan command `sudo service rsyslog start`

3. Buat direktori modul1 di `/home/rak` dengan command `mkdir modul1`

4. Pastikan service cron sedang berjalan dengan command `service cron status` . Jika mengembalikan selain `* cron is running`, maka aktifkan dengan command `sudo service cron start`

5. Edit crontab dengan command `crontab -e`. Tambahkan di akhir file dengan syntax crontab `2-30/6 * * * * /bin/bash ~/soal5.sh`  
Penjelasan:  
`2-30/6 * * * *`  
setiap 6 menit dari menit ke-2 hingga menit ke-30

6. Tunggu hingga waktu sesuai dengan crontab. Cek hasil file dengan command `cat /home/rak/modul1/soalno5.log`