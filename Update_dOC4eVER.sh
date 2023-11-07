!/bin/bash
# -*- coding: utf-8 -*-
XC_VERSION="41 dOC4eVER v03"
PANEL_PATH="/home/xtreamcodes/iptv_xtream_codes"
#--- Display the 'welcome' splash/user warning info..
#test ok
 echo ""
    tput setaf 2 ; tput cuf 5;tput bold ;echo " ┌────────────────────────────────────────────────────────────────┐"; tput sgr0;
    tput setaf 2 ; tput cuf 5;tput bold ;echo " │    Welcome to the Official Xtream UI Update $XC_VERSION    │"; tput sgr0;
    tput setaf 2 ; tput cuf 5;tput bold ;echo " └────────────────────────────────────────────────────────────────┘"; tput sgr0;
 echo ""
    tput setaf 3 ;tput blink; tput bold ;tput cuf 20;echo "Xtream UI ◄۞ $XC_VERSION ۞► "; tput sgr0;
 echo ""
 echo ""
 echo ""



 tput setaf 6 ;tput cuf 7; tput bold ;read -p "Update dOC4eVER_V03 (Y/N)? " -n 1 -r; tput sgr0;
 echo ""
 echo ""
 echo ""
 

echo
case "$REPLY" in 
  y|Y )
    #! clear
    tput setaf 4 ;tput cuf 7;tput bold ;echo "Downloading and updating"; tput sgr0;
 echo ""
 echo ""
    apt-get install unzip e2fsprogs  python3-paramiko -y > /dev/null

    mkdir /home/xtreamcodes/iptv_xtream_codes/old
    chmod 0777 /home/xtreamcodes/iptv_xtream_codes/old

    sudo chattr -i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb

    mv -iv /home/xtreamcodes/iptv_xtream_codes/admin /home/xtreamcodes/iptv_xtream_codes/old/admin.old
	rm -rf /home/xtreamcodes/iptv_xtream_codes/admin

    mv -iv /home/xtreamcodes/iptv_xtream_codes/pytools /home/xtreamcodes/iptv_xtream_codes/old/pytools.old
	rm -rf /home/xtreamcodes/iptv_xtream_codes/pytools

    mv -iv /home/xtreamcodes/iptv_xtream_codes/start_services.sh /home/xtreamcodes/iptv_xtream_codes/old/start_services.sh.old

    wget https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/update.zip -O /tmp/update.zip -o /dev/null

    wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/start_services.sh -O /tmp/start_services.sh -o /dev/null
    #! clear
 echo ""
 echo ""
    tput setaf 4 ;tput cuf 7;tput bold ;echo "Installing updates"; tput sgr0;
 echo ""
 echo ""
    sleep 1
    unzip /tmp/update.zip -d /tmp/update/
    cp -rf /tmp/update/XtreamUI-master/* /home/xtreamcodes/iptv_xtream_codes/
    mv  /tmp/start_services.sh /home/xtreamcodes/iptv_xtream_codes/
    #! clear
 echo ""
    tput setaf 4 ;tput cuf 7; tput bold ;echo "Deleting temporary files"; tput sgr0;
 echo ""
 echo ""
    sleep 1
    rm -rf /tmp/update/XtreamUI-master
    rm /tmp/update.zip
    rm -rf /tmp/update
    chattr +i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb

    chmod -R 0744 /home/xtreamcodes/iptv_xtream_codes/start_services.sh

    chmod -R 0777 /home/xtreamcodes/iptv_xtream_codes/nginx/sbin/nginx
    chmod -R 0777 /home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/nginx_rtmp
	#!clear
  
	tput setaf 2 ; tput cuf 7;tput bold ;echo "Update completed successfully"; tput sgr0;;
   

n|N ) tput setaf 1 ;tput cuf 7; tput bold ;echo  "Please Wait ..."; tput sgr0; ;;
	
* ) tput setaf 1 ;tput cuf 7; tput bold ; echo "Answer with Y or N";tput sgr0; ;;
esac
 echo ""
 echo ""
 echo ""
    tput setaf 5  ; tput cuf 5;tput bold ;echo " ┌──────────────────────────────────────────────────────┐"; tput sgr0;
    tput setaf 5  ; tput cuf 5;tput bold ;echo " │    Restarting Xtream Codes Update $XC_VERSION    │"; tput sgr0;
    tput setaf 5  ; tput cuf 5;tput bold ;echo " └──────────────────────────────────────────────────────┘"; tput sgr0;
    sudo /home/xtreamcodes/iptv_xtream_codes/start_services.sh > /dev/null
    sudo chattr -i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
    sudo chown -R xtreamcodes:xtreamcodes /home/xtreamcodes/
 echo ""
 echo ""
exit 0