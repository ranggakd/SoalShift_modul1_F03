#no4 dekripsi

#Masukkan nama file yang dimaksud:
wkt=$1
jam=${wkt:0:2}
if [[ ${jam:0:1} =~ [0-9] ]] && [ ${jam:1:1} == ":" ]
then
        jam=${jam:0:1}
fi

up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
awk '{print}' "/home/rak/modul1/$wkt" | tr "${up:$jam:26}${lo:$jam:26}" "${up:0:26}${lo:0:26}" > "/home/rak/modul1/dekripsi/$wkt"
