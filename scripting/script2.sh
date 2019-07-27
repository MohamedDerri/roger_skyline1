#!/bin/sh

if [ ! -e fichier1.txt ]
then
	md5sum /etc/crontab | cut -d ' ' -f 1 > fichier1.txt
else
	md5sum /etc/crontab | cut -d ' ' -f 1 > fichier2.txt
	if [ $(cat fichier1.txt) != $(cat fichier2.txt) ]
	then
		echo "the crontab file has been modified" | mail -s "subject" root@localhost
		echo $(cat fichier2.txt) > fichier1.txt
	fi
fi


