#!/bin/bash
chmod u+x
clear

echo " Welcome to my projet SYS"
echo " Choose the option to execute"
echo " a) User information registered 3 days ago"
echo " b) Aquisition and installation of the xamp environment"
echo " c) Archiving Personal Directory Items edit by sudoer 2 days ago"
echo " d) Disk usage information, memory, process, swap"
echo " quit (Q / Q) "
echo " last name and first name : GBETNKOM Emmanuel "
echo " Matricule: 12B209FS "
read -r choix
case $choix in 
	#list of the users
	'a') cut -d : -f 1 /etc/passwd>all_users
	
	#list of the /home repertorie  
	ls /home>user_foders
	
	while read line 
	do
		while read line1
		do	
		if [ $line == $line1 ] ; then 
		echo $line1>user1
		fi
		done<user_foders
	done<all_users
	find /home/* -type d -ctime 3 -print>userx

	while read line1
	do
	   while read user
	   do 
	      if [ $line1 == '/home/'$user ] ; then
		echo " $user who creat  after tree days ago">3days_user.txt
	      fi

	  done<user1 
	done<userx
	cat 3days_users.txt
 ;;
	'b') echo "Download of xampp"
	 wget https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.30/xampp-linux-x64-5.6.30-1-installer.run?from_af=true
	 echo " installing "
	 ./xampp-linux-x64-5.6.30-1-installer.run
	
	 sudo su
	#Stop of apache service 
	service apache2 stop
	#stop ftp service
	service proftpd stop
	#Starting xampp
	/opt/lampp/lampp start
;;
	'c') echo "archivage"
	#Archive file directory home edit by sudoer 2 days ago
	mkdir -p /home/ushi-deshi/archive
	find /home/ushi-deshi/ -type f -mtime 2 -print>/home/ushi-deshi/ficmodi
	while read line
	do
	cp $line archive
	done </home/ushi-deshi/ficmodi
	tar -czvf archive.tar.gz archive
	#mv archive.tar.gz /media/usb/*/archive.tar.gz
	mv archive.tar.gz /home/ushi-deshi/prof/archive.tar.gz
	;;
	'd') echo "Disk Usage Information :"
		df -h |grep /dev/sd
		echo "Information on the use of memory and swap :"
		free -h 
;;
	* )  exit 1 ;;
esac


