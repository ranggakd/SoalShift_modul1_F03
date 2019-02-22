#no4 dekripsi

#Masukkan nama file yang dimaksud:
wkt=$1
jam=${wkt:0:2}

up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
awk '{print}' "/home/rak/modul1/$wkt" | tr "${up:$jam:26}${lo:$jam:26}" "${up:0:26}${lo:0:26}" > "/home/rak/modul1/dekripsi/$wkt"
