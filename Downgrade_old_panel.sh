#!/bin/bash
# -*- coding: utf-8 -*-
XC_VERSION="41 dOC4eVER v03"
PANEL_PATH="/home/xtreamcodes/iptv_xtream_codes"
#--- Display the 'welcome' splash/user warning info..
#test ok
 echo ""
    tput setaf 2 ; tput cuf 5;tput bold ;echo " ┌────────────────────────────────────────────────────────────────┐"; tput sgr0;
    tput setaf 2 ; tput cuf 5;tput bold ;echo " │    Welcome to the Official Xtream UI Restore the old Panel     │"; tput sgr0;
    tput setaf 2 ; tput cuf 5;tput bold ;echo " └────────────────────────────────────────────────────────────────┘"; tput sgr0;
 echo ""
    tput setaf 3 ;tput blink; tput bold ;tput cuf 20;echo "Xtream UI ◄۞ $XC_VERSION ۞►  installed"; tput sgr0;
 echo ""
 echo ""
 echo ""



 tput setaf 6 ;tput cuf 7; tput bold ;read -p "Restore the old Panel (Y/N)? " -n 1 -r; tput sgr0;
 echo ""
 echo ""
 echo ""
 

echo
case "$REPLY" in 
  y|Y )
    #! clear
    tput setaf 4 ;tput cuf 7;tput bold ;echo "Downgrading your old Panel, please wait..."; tput sgr0;
 echo ""
 echo ""
    apt-get install unzip e2fsprogs  python3-paramiko -y > /dev/null
    sleep 1	   
		
	rm -rf /home/xtreamcodes/iptv_xtream_codes/admin
	rm -rf /home/xtreamcodes/iptv_xtream_codes/pytools

    mv -iv /home/xtreamcodes/iptv_xtream_codes/old/admin.old /home/xtreamcodes/iptv_xtream_codes/admin
    mv -iv /home/xtreamcodes/iptv_xtream_codes/old/pytools.old /home/xtreamcodes/iptv_xtream_codes/pytools
	mv  -v /home/xtreamcodes/iptv_xtream_codes/old/start_services.sh.old  /home/xtreamcodes/iptv_xtream_codes/start_services.sh

    rmdir /home/xtreamcodes/iptv_xtream_codes/old

    chattr +i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
    chmod -R 0744 /home/xtreamcodes/iptv_xtream_codes/start_services.sh
    chmod -R 0777 /home/xtreamcodes/iptv_xtream_codes/nginx/sbin/nginx
    chmod -R 0777 /home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/nginx_rtmp
	#!clear
 echo ""
 echo ""
 echo ""

	tput setaf 2 ; tput cuf 7;tput bold ;echo "Downgrade is complete, you are back to the old Panel"; tput sgr0;;
 
	#tput setaf 2 ; tput cuf 7;tput bold ;echo " "tput sgr0;


n|N ) tput setaf 1 ;tput cuf 7; tput bold ;echo  "Please Wait ..."; tput sgr0; ;;
	
* ) tput setaf 1 ;tput cuf 7; tput bold ; echo "Answer with Y or N";tput sgr0; ;;
esac
 echo ""
 echo ""
 echo ""
    tput setaf 5; tput cuf 5;tput bold ;echo " ┌────────────────────────────────────────────┐"; tput sgr0;
    tput setaf 5; tput cuf 5;tput bold ;echo " │    Restart of Xtream codes in progress...  │"; tput sgr0;
    tput setaf 5; tput cuf 5;tput bold ;echo " └────────────────────────────────────────────┘"; tput sgr0;
    sudo /home/xtreamcodes/iptv_xtream_codes/start_services.sh > /dev/null
    sudo chattr -i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
    sudo chown -R xtreamcodes:xtreamcodes /home/xtreamcodes/
 echo ""
 echo ""
exit 0