#no4 enkripsi

jam=`date +"%H"`
if [ ${jam:0:1} == 0 ]
then
        jam=${jam:1:1}
fi
nama=`date +"%H:%M %d-%m-%y"`
if [ ${nama:0:1} == 0 ]
then
        nama=${nama:1}
fi

up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
awk '{print}' /var/log/syslog | tr "${up:0:26}${lo:0:26}" "${up:$jam:26}${lo:$jam:26}" > "/home/rak/modul1/$nama"
