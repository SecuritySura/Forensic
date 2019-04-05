#!/bin/bash

# This is written by @securitySura
# this is an acquisition tool for linux forensic artifacts
# need root access


echo "Dumping all the paths meta data (starting from /)"

echo "Access Date \t Access Time \t Modify Date \t Modify Time \t Create Date \t Create Time \t Permissions \t UID \t UserName \t GID \t GroupName \t Size \t File \n" >> file_meta_data.txt

find / -printf "%Ax \t %AT \t %Tx \t %TT \t %Cx \t %CT \t %m \t %U \t %u \t %G \t %g \t %s \t %p\n" >> files_meta_data.txt
echo "meta data collecting was done..!!!\n \n"

echo "\n --------------------------- dumping all users bash history ------------------------------------------------------- \n"
find /home -type f -regextype posix-extended -regex '/home/[a-zA-Z\.]+/\.bash_history' -exec echo -e "\n ---------------dumping {} ------------------- \n" \; -exec cat {} \; >> users_history.txt
echo "\n --------------------------- dumping root user bash history ------------------------------------------------------- \n" >> users_history.txt
find /root -maxdepth 1 -type f -regextype posix-extended -regex "/root/\.bash_history" -exec cat {} \; >> users_history.txt
echo "done..!!! \n"

echo "dumping password file \n"
cp /etc/passwd .
echo "done..!!! \n"

echo "dumping shadow file \n"
cp /etc/shadow .
echo "done..!!! \n"

echo "dumping network statistic \n"
netstat -panetu >> networkstatistic.txt
echo "done..!!! \n"

echo "dumping process statistic \n"
ps -aux >> processlist.txt
echo "done..!!! \n"

echo "dumping users crontab details \n"
cat /etc/passwd | cut -d ":" -f1 | while read users; do crontab -u $users -l;done >> userscrontab.txt
echo "done..!!! \n"

echo "dumping auto start services \n"
ls -all /etc/init.d/ /lib/systemd/system/ /etc/systemd/system/ >> autostartservices.txt
echo "done..!!! \n"

echo "coping /var/log folder ....!!! \n"
cp -r /var/log/ .
echo "log dump done..!!! \n"

