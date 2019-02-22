#no1
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
