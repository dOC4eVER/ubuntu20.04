#!/bin/bash
wget -qO- https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/depbuild.sh | bash -s
apt-get update
apt-get -y dist-upgrade
apt-get -y install mariadb-server
apt-get -y install curl
apt-get -y install libxslt1-dev
apt-get -y install libcurl3-gnutls
apt-get -y install libgeoip-dev
apt-get -y install python
apt-get -y install e2fsprogs
apt-get -y install wget
apt-get -y install mcrypt
apt-get -y install nscd
apt-get -y install htop
apt-get -y install zip
apt-get -y install unzip
apt-get -y install mc
apt-get -y install python3-paramiko
apt-get -y install python-paramiko
rm -f install.py
curl -L -o install.py https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/install.py
python install.py
rm -f install.py
apt-get -y install libcurl4 curl
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/xcphp_7.3.33-1_amd64.deb -O xcphp_7.3.33-1_amd64.deb
dpkg -i xcphp_7.3.33-1_amd64.deb
rm -f xcphp_7.3.33-1_amd64.deb
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/xcphp-mcrypt_1.0.5-1_amd64.deb -O xcphp-mcrypt_1.0.5-1_amd64.deb
dpkg -i xcphp-mcrypt_1.0.5-1_amd64.deb
rm -f xcphp-mcrypt_1.0.5-1_amd64.deb
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/xcphpgeoip_1.1.1-1_amd64.deb -O xcphpgeoip_1.1.1-1_amd64.deb
dpkg -i xcphpgeoip_1.1.1-1_amd64.deb
rm -f xcphpgeoip_1.1.1-1_amd64.deb
rm -rf /home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20170718/
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O ioncube_loaders_lin_x86-64.tar.gz
tar -zxvf ioncube_loaders_lin_x86*
cp ioncube/ioncube_loader_lin_7.3.so /home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20180731/
rm -f ioncube*
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/php.ini -O /home/xtreamcodes/iptv_xtream_codes/php/lib/php.ini
rm -f /home/xtreamcodes/iptv_xtream_codes/php/VaiIb8.pid /home/xtreamcodes/iptv_xtream_codes/php/JdlJXm.pid /home/xtreamcodes/iptv_xtream_codes/php/CWcfSP.pid.bk
/home/xtreamcodes/iptv_xtream_codes/start_services.sh
