#!/bin/bash
echo -e "\nChecking that minimal requirements are ok"
echo ""
# Ensure the OS is compatible with the launcher
if [ -f /etc/centos-release ]; then
    inst() {
       rpm -q "$1" &> /dev/null
    } 
    if (inst "centos-stream-repos"); then
    OS="CentOS-Stream"
    else
    OS="CentOs"
    fi    
    VERFULL=$(sed 's/^.*release //;s/ (Fin.*$//' /etc/centos-release)
    VER=${VERFULL:0:1} # return 6, 7 or 8
elif [ -f /etc/fedora-release ]; then
    inst() {
       rpm -q "$1" &> /dev/null
    } 
    OS="Fedora"
    VERFULL=$(sed 's/^.*release //;s/ (Fin.*$//' /etc/fedora-release)
    VER=${VERFULL:0:2} # return 34, 35 or 36
elif [ -f /etc/lsb-release ]; then
    OS=$(grep DISTRIB_ID /etc/lsb-release | sed 's/^.*=//')
    VER=$(grep DISTRIB_RELEASE /etc/lsb-release | sed 's/^.*=//')
elif [ -f /etc/os-release ]; then
    OS=$(grep -w ID /etc/os-release | sed 's/^.*=//')
    VER=$(grep VERSION_ID /etc/os-release | sed 's/^.*"\(.*\)"/\1/' | head -n 1 | tail -n 1)
 else
    OS=$(uname -s)
    VER=$(uname -r)
fi
ARCH=$(uname -m)
    echo -e " \033[1;33m Detected\033[0m""\033[1;36m $OS\033[1;32m $VER\033[0m" "\033[1;35m$ARCH\033[0m"
echo ""	
if [[ "$OS" = "CentOs" && "$VER" = "7" && "$ARCH" == "x86_64" ||
"$OS" = "CentOS-Stream" && "$VER" = "8" && "$ARCH" == "x86_64" ||
"$OS" = "CentOS-Stream" && "$VER" = "9" && "$ARCH" == "x86_64" ||
"$OS" = "Fedora" && ("$VER" = "35" || "$VER" = "36" || "$VER" = "37" ) && "$ARCH" == "x86_64" ||
"$OS" = "Ubuntu" && ("$VER" = "18.04" || "$VER" = "20.04" || "$VER" = "22.04" ) && "$ARCH" == "x86_64" ||
"$OS" = "debian" && ("$VER" = "10" || "$VER" = "11" ) && "$ARCH" == "x86_64" ]] ; then
    tput setaf 2 ; tput bold ;echo "Ok."; tput sgr0;    
#echo ""
else
    tput setaf 1 ; tput bold ;echo "Sorry, this OS is not supported by Xtream UI."; tput sgr0;    
echo ""
    exit 1
fi


if [[ "$OS" = "CentOs" ]] ; then
    PACKAGE_INSTALLER="yum -y -q install"
    PACKAGE_REMOVER="yum -y -q remove"
    PACKAGE_UPDATER="yum -y -q update"
    PACKAGE_UTILS="yum-utils"
    PACKAGE_GROUPINSTALL="yum -y -q groupinstall"
    PACKAGE_SOURCEDOWNLOAD="yumdownloader --source"
    PACKAGE_COPRENABLE="yum -y copr enable" 
    BUILDDEP="yum-builddep -y"
elif [[ "$OS" = "Fedora" || "$OS" = "CentOS-Stream"  ]]; then
    PACKAGE_INSTALLER="dnf -y -q install"
    PACKAGE_REMOVER="dnf -y -q remove"
    PACKAGE_UPDATER="dnf -y -q update"
    PACKAGE_UTILS="dnf-utils" 
    PACKAGE_GROUPINSTALL="dnf -y -q groupinstall"
    PACKAGE_SOURCEDOWNLOAD="dnf download --source"
    PACKAGE_COPRENABLE="dnf -y copr enable"
    BUILDDEP="dnf build-dep -y"
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    PACKAGE_INSTALLER="apt-get -yqq install"
    PACKAGE_REMOVER="apt-get -yqq purge"
    inst() {
       dpkg -l "$1" 2> /dev/null | grep '^ii' &> /dev/null
    }
fi
$PACKAGE_REMOVER xtreamui-freetype2 xtreamui-php xtreamui-php-geoip xtreamui-php-ioncube-loader xtreamui-php-mcrypt
rm -rf /home/xtreamcodes/iptv_xtream_codes/php
$PACKAGE_INSTALLER daemonize xtreamui-freetype2 xtreamui-php xtreamui-php-geoip xtreamui-php-ioncube-loader xtreamui-php-mcrypt
$PACKAGE_INSTALLER xtreamui-ffmpeg
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/start_services.sh -O /home/xtreamcodes/iptv_xtream_codes/start_services.sh
chmod +x /home/xtreamcodes/iptv_xtream_codes/start_services.sh
fi
