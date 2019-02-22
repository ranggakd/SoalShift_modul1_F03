#no5a-c
awk '(/cron/ || /CRON/) && (!/sudo/) && (NF < 13)' /var/log/syslog  >> /home/rak/modul1/soalno5.log
