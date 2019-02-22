# SoalShift_modul1_F03
Keperluan tugas laboratorium Sistem Operasi 2019

---
## NO 1

Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.  
Hint: Base64, Hexdump

**Jawaban**

1. Membuat file script di /home/rak dengan nama soal1.sh untuk decode file backup syslog yang berisikan ini:
    ```
    #crontab-step
    unzip ~/modul1/nature.zip -d ~/modul1
    mkdir ~/modul1/nature_dec

    #non-crontab step
    hasil=1
    for pic in ~/modul1/nature/*.jpg
    do
            base64 -d $pic | xxd -r > ~/modul1/nature_dec/$hasil.jpg
            hasil=$(($hasil+1))
    done
    chmod 777 ~/modul1/nature_dec/*.jpg
    ```
    Penjelasan:
    ```
    unzip ~/modul1/nature.zip -d ~/modul1
    mkdir ~/modul1/nature_dec
    ```
    untuk langkah ini zip folder nature didalam folder modul1 ke destinasi folder modul1  
    kemudian membuat direktori untuk kebutuhan dekripsi didalam folder modul1
    ```
    hasil=1
    for pic in ~/modul1/nature/*.jpg
    do
            base64 -d $pic | xxd -r > ~/modul1/nature_dec/$hasil.jpg
            hasil=$(($hasil+1))
    done
    ```
    variabel hasil berisi angka guna memberi nama file berupa nomor sesuai jumlah iterasi di for loop
    for loop dengan variabel iterasi pic menunjuk tiap file jpg didalam list file-file jpg didalam folder nature. Di setiap for loop, melakukan decode basis64 untuk tiap file yang outputnya dijadikan input untuk direvert menjadi binary. Hasil binary akan diredirect menjadi output kedalam folder nature_dec untuk disimpan menjadi file. Variabel hasil akan increment setiap loop dijalankan
    ```
    chmod 777 ~/modul1/nature_dec/*.jpg
    ```
    agar dapat dieksekusi, maka buka batasan eksekusi setiap file jpg didalam nature_dec

2. Untuk syarat mendekripsi isi folder pukul 14:14 pada tanggal 14 Februari atau hari jumat pada bulan Februari, dapat dilakukan dengan penjadwalan pada cron. Edit crontab dengan command `crontab -e`. Tambahkan di akhir file dengan syntax crontab  
    ```
    14 14 14 2 * /bin/bash ~/soal1.sh
    0 */1 * 2 5 /bin/bash ~/soal1.sh
    ```
    Penjelasan:
    ```
    14 14 14 2 * 
    ```
    pada jam 14 dan menit ke-14 pada tanggal 14 di bulan Februari
    ```
    /bin/bash ~/soal1.sh
    ```
    dengan format bash mengeksekusi file di path
    ```
    0 */1 * 2 5 
    ```
    setiap jam menit ke-0 pada hari Jumat setiap Februari
    ```
    /bin/bash ~/soal1.sh
    ```
    dengan format bash mengeksekusi file di path

---
## NO 2

Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:  
1. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.  
2. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin 1.  
3. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin 3.

**Jawaban**

1.
    ```
    echo -e "\n2a)"

    #2(a)
    awk -F "," '{if($7 == '2012') arr[$1]+=$10} END {for(res in arr) {print res}}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -nr | head -1

    echo -e "\n2b)"
    #2(b)
    awk -F  "," '{if($1 == "United States" && $7 == '2012') arr[$4]+=$10} END {for(res in arr) print arr[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR<=3) {print $2,$3}'

    echo -e "\n2c)"
    #2(c)
    echo -e "Personal Accessories:"
    awk -F "," '{if($1 == "United States" && $7 == '2012' && $4 == "Personal Accessories") arr[$6]+=$10} END {for(res in arr) print arr[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR <=3) {print $2, $3, $4}'
    echo -e "\nCamping Equipment:"
    awk -F "," '{if($1 == "United States" && $7 == '2012' && $4 == "Camping Equipment") arr[$6]+=$10} END {for(res in arr) print arr[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR <=3) {print $2, $3, $4}'
    echo -e "\nOutdoor Protection:"
    awk -F "," '{if($1 == "United States" && $7 == '2012' && $4 == "Outdoor Protection") arr[$6]+=$10} END {for(res in arr) print iter[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR <=3) {print $2, $3, $4}'
    ```
    Penjelasan:
    ```
    awk -F "," '{if($7 == '2012') arr[$1]+=$10} END {for(res in arr) {print res}}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -nr | head -1
    ```
    -F untuk separator untuk memisahkan "," diantara kolom. Jika kolom ke tujuh bernilai 2012, lalu array dengan key arg ke-1 diisi sum arg ke-10. Pada eof, lakukan for loop dalam array kemudian print. Lalu sorting secara numerik dan dibalik dan diambil hanya teratas
    ```
    awk -F  "," '{if($1 == "United States" && $7 == '2012') arr[$4]+=$10} END {for(res in arr) print arr[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR<=3) {print $2,$3}'
    ```
    -F untuk separator untuk memisahkan "," diantara kolom. Jika kolom ke pertama bernilai "United State" dan kolom ke tujuh bernilai 2012, lalu array dengan key arg ke-4 diisi sum arg ke-10. Pada eof, lakukan for loop dalam array kemudian print isi array ke-"res" dan res. Lalu sorting secara numerik dan dibalik. Kemudian batasi hanya 3 baris saja yang keluar dan print arg ke-2 dan ke-3
    ```
    echo -e "Personal Accessories:"
    awk -F "," '{if($1 == "United States" && $7 == '2012' && $4 == "Personal Accessories") arr[$6]+=$10} END {for(res in arr) print arr[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR <=3) {print $2, $3, $4}'
    echo -e "\nCamping Equipment:"
    awk -F "," '{if($1 == "United States" && $7 == '2012' && $4 == "Camping Equipment") arr[$6]+=$10} END {for(res in arr) print arr[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR <=3) {print $2, $3, $4}'
    echo -e "\nOutdoor Protection:"
    awk -F "," '{if($1 == "United States" && $7 == '2012' && $4 == "Outdoor Protection") arr[$6]+=$10} END {for(res in arr) print iter[res], res}' ~/modul1/WA_Sales_Products_2012-14.csv | sort -rn | awk '(NR <=3) {print $2, $3, $4}'
    ```
    untuk Personal Accesories:  
    -F untuk separator untuk memisahkan "," diantara kolom. Jika kolom ke pertama bernilai "United State" dan kolom ke tujuh bernilai 2012 dan kolom ke empat bernilai Personal Accesories, lalu array dengan key arg ke-6 diisi sum arg ke-10. Pada eof, lakukan for loop dalam array kemudian print isi array ke-"res" dan res. Lalu sorting secara numerik dan dibalik. Kemudian batasi hanya 3 baris saja yang keluar dan print arg ke-2 dan ke-3 dan ke-4  
    untuk Camping Equipment:  
    -F untuk separator untuk memisahkan "," diantara kolom. Jika kolom ke pertama bernilai "United State" dan kolom ke tujuh bernilai 2012 dan kolom ke empat bernilai Camping Equipment, lalu array dengan key arg ke-6 diisi sum arg ke-10. Pada eof, lakukan for loop dalam array kemudian print isi array ke-"res" dan res. Lalu sorting secara numerik dan dibalik. Kemudian batasi hanya 3 baris saja yang keluar dan print arg ke-2 dan ke-3 dan ke-4  
    untuk Outdoor Protection:  
    -F untuk separator untuk memisahkan "," diantara kolom. Jika kolom ke pertama bernilai "United State" dan kolom ke tujuh bernilai 2012 dan kolom ke empat bernilai Outdoor Protection, lalu array dengan key arg ke-6 diisi sum arg ke-10. Pada eof, lakukan for loop dalam array kemudian print isi array ke-"res" dan res. Lalu sorting secara numerik dan dibalik. Kemudian batasi hanya 3 baris saja yang keluar dan print arg ke-2 dan ke-3 dan ke-4  

2. Lakukan command `bash soalno2.sh`

---
## NO 3

Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:  
1. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt  
2. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.  
3. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.
4. Password yang dihasilkan tidak boleh sama.

**Jawaban**

1. Membuat file script di /home/rak dengan nama soal3.sh untuk enkripsi file backup syslog yang berisikan ini:  

    ```
    #untuk bukti unik
    x=1
    folder="/home/rak/modul1/pass/"

    if [ "$(ls -A $folder)" ]
    then
            for files in ~/modul1/pass/password*.txt
            do
                    proof[x]=`cat $files`
                    x=$(($x+1))
            done
    fi

    #generate password
    for ((i=1; i<=x; i++))
    do
            if [ ! -f ~/modul1/pass/password$i.txt ]
            then
                    pass=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12`
                    for j in proof
                    do
                            if [ "$pass" == "${proof[j]}" ]
                            then
                                    pass=`head /dev/urandom | tr -dc A-Za-z0-9 | head $                        break
                            fi
                    done
                    echo $pass > ~/modul1/pass/password$i.txt
                    break
            fi
    done
    ```
    Penjelasan:
    ```
    x=1
    folder="/home/rak/modul1/pass/"
    ```
    variabel x untuk iterasi array proof bukti unik password dan sebagai batas iterasi  
    variabel folder untuk menyimpan kondisi apakah folder itu kosong atau tidak
    ```
    if [ "$(ls -A $folder)" ]
    then
            for files in ~/modul1/pass/password*.txt
            do
                    proof[x]=`cat $files`
                    x=$(($x+1))
            done
    fi
    ```
    jika folder berisi suatu file, maka lakukan for loop untuk menyimpan list password dari semua file yang ada di folder  
    variabel x increment setiap for loop
    ```
    for ((i=1; i<=x; i++))
    do
            if [ ! -f ~/modul1/pass/password$i.txt ]
            then
                    pass=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12`
                    for j in proof
                    do
                            if [ "$pass" == "${proof[j]}" ]
                            then
                                    pass=`head /dev/urandom | tr -dc A-Za-z0-9 | head $                        break
                            fi
                    done
                    echo $pass > ~/modul1/pass/password$i.txt
                    break
            fi
    done
    ```
    for loop untuk meng-generate password. Jika suatu file password tidak ada, maka buat password baru dari /dev/urandom/ dengan regex [A-Za-z0-9] dan max character 12  
    kemudian lakukan for loop untuk mengecek apakah password yang digenerate barusan bernilai sama dengan password yang pernah ada dengan komparasi pada array proof. Jika tidak, maka langsung redirect menjadi file password baru

2. Lakukan command `bash soal3.sh` dan cek di folder dengan `ls /modul1/pass/`

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

1. Membuat file script di /home/rak dengan nama soal4.sh untuk enkripsi file backup syslog yang berisikan ini:  
    ```
    jam=`date +"%H"`
    nama=`date +"%H:%M %d-%m-%y"`

    up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
    lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
    awk '{print}' /var/log/syslog | tr "${up:0:26}${lo:0:26}" "${up:$jam:26}${lo:$jam:26}" > "/home/rak/modul1/$nama"
    ```
    Penjelasan:
    ```  
    jam=`date +"%H"`
    nama=`date +"%H:%M %d-%m-%y"`
    ```
    variabel jam mengambil nilai jam dari command date  
    variabel nama mengambil nilai waktu-tanggal dari command date untuk format penamaan file
    ```
    up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
    lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
    ```
    variabel up berisi string alphabet double untuk string manipulation uppercase  
    variabel lo berisi string alphabet double untuk string manipulation lowercase
    ```
    awk '{print}' /var/log/syslog
    ```
    command awk sebagai text processor menampilkan file dari input path
    ```
    | tr "${up:0:26}${lo:0:26}" "${up:$jam:26}${lo:$jam:26}"
    ```
    output dari command sebelumnya menjadi input untuk command tr mengganti serangkaian alphabet urutan normal menjadi serangkaian alphabet urutan modifikasi dari jumlah jam, baik dalam uppercase ataupun lowercase
    ```
     > "/home/rak/modul1/$nama"
    ```
    redirection ke file yang menjadi output

2. Pastikan service rsyslog sedang berjalan dengan command  `service rsyslog status` jika mengembalikan selain `* rsyslogd is running` , maka aktifkan dengan command `sudo service rsyslog start`

3. Buat direktori modul1 di `/home/rak` dengan command `mkdir modul1`

4. Pastikan service cron sedang berjalan dengan command `service cron status` . Jika mengembalikan selain `* cron is running`, maka aktifkan dengan command `sudo service cron start`

5. Edit crontab dengan command `crontab -e`. Tambahkan di akhir file dengan syntax crontab  
    ```
    0 */1 * * * /bin/bash ~/soal4.sh
    ```
    Penjelasan:  
    ```
    0 */1 * * *
    ```
    setiap satu jam menit ke-0
    ```
    /bin/bash ~/soal4.sh
    ```
    dengan format bash mengeksekusi file di path

6. Tunggu hingga waktu sesuai dengan crontab. Cek hasil file dengan command `cat /home/rak/modul1/{jam:menit tgl-bulan-tahun}`

7. Membuat file script di /home/rak dengan nama soal4desc.sh untuk dekripsi file backup syslog yang berisikan ini:  
    ```
    wkt=$1
    jam=${wkt:0:2}

    up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
    lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
    awk '{print}' "/home/rak/modul1/$wkt" | tr "${up:$jam:26}${lo:$jam:26}" "${up:0:26}${lo:0:26}" > "/home/rak/modul1/dekripsi/$wkt"
    ```
    Penjelasan:
    ```
    wkt=$1
    jam=${wkt:0:2}
    ```
    variabel wkt berisi argumen ke-1 nama file yang diinputkan  
    variabel jam berisi nilai kedua dari variabel string wkt yang menyatakan nilai jam
    ```
    up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
    lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
    ```
    variabel up berisi string alphabet double untuk string manipulation uppercase  
    variabel lo berisi string alphabet double untuk string manipulation lowercase
    ```
    awk '{print}' "/home/rak/modul1/$wkt"
    ```
    command awk sebagai text processor menampilkan file dari input path berdasarkan variabel waktu
    ```
    | tr "${up:$jam:26}${lo:$jam:26}" "${up:0:26}${lo:0:26}"
    ```
    output dari command sebelumnya menjadi input untuk command tr mengganti serangkaian alphabet urutan modifikasi dari jumlah jam menjadi serangkaian alphabet urutan normal, baik dalam uppercase ataupun lowercase
    ```
    > "/home/rak/modul1/dekripsi/$wkt"
    ```
    redirection ke file yang menjadi output berdasarkan variable wkt

8. Lakukan dekripsi dengan command dan argumentasi nama file untuk dekripsi
    ```
    bash soal4desc.sh "{jam:menit tgl-bulan-tahun}"
    ```

---
## NO 5

Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:  
- Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.
- Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
- Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.
- Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

**Jawaban**

1. Membuat file script di /home/rak dengan nama soal5.sh berisikan ini:  
    ```
    awk '(/cron/ || /CRON/) && (!/sudo/) && (NF < 13)' /var/log/syslog  >> /home/rak/modul1/soalno5.log  
    ```
    Penjelasan:  
    ```
    awk '...'  
    ```
    command awk sebagai text processor  
    ```
    (/cron/ || /CRON/) && (!/sudo/)
    ```
    mengembalikan benar jika pola 'cron' atau 'CRON' dan selain 'sudo'  
    ```
    && (NF < 13)
    ```
    dan mengembalikan benar jika number of field kurang dari 13  
    ```
    /var/log/syslog
    ```
    path file yang menjadi input  
    ```
    >> /home/rak/modul1/soalno5.log
    ```
    redirection dengan append data di akhir file yang menjadi output

2. Pastikan service rsyslog sedang berjalan dengan command  `service rsyslog status` jika mengembalikan selain `* rsyslogd is running` , maka aktifkan dengan command `sudo service rsyslog start`

3. Buat direktori modul1 di `/home/rak` dengan command `mkdir modul1`

4. Pastikan service cron sedang berjalan dengan command `service cron status` . Jika mengembalikan selain `* cron is running`, maka aktifkan dengan command `sudo service cron start`

5. Edit crontab dengan command `crontab -e`. Tambahkan di akhir file dengan syntax crontab  
    ```
    2-30/6 * * * * /bin/bash ~/soal5.sh
    ```
    Penjelasan:  
    ```
    2-30/6 * * * *
    ```
    setiap 6 menit dari menit ke-2 hingga menit ke-30
    ```
    /bin/bash ~/soal5.sh
    ```
    dengan format bash mengeksekusi file di path

6. Tunggu hingga waktu sesuai dengan crontab. Cek hasil file dengan command `cat /home/rak/modul1/soalno5.log`