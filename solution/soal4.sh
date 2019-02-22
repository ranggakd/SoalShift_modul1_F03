#no4 enkripsi

jam=`date +"%H"`
nama=`date +"%H:%M %d-%m-%y"`

up="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
lo="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
awk '{print}' /var/log/syslog | tr "${up:0:26}${lo:0:26}" "${up:$jam:26}${lo:$jam:26}" > "/home/rak/modul1/$nama"
