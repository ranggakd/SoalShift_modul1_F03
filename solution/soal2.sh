#no2
echo -e "2a)"

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
