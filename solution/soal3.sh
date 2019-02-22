#no 3
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
				pass=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12`
			break
			fi
		done
		echo $pass > ~/modul1/pass/password$i.txt
		break
	fi
done
