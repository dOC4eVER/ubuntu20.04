#!/usr/bin/env bash
# Official Xtream UI Automated Installation Script
# =============================================
# Beta Version dot not use in production
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Supported Operating Systems: 
# Ubuntu server 18.04/20.04/22.04
# soon
# CentOS 7.*
# CentOS Stream 8.*
# Fedora 34/35/36
# Debian 10/11
# 64bit online system
#
while getopts ":t:a:p:o:c:r:e:m:s:h:" option; do
    case "${option}" in
        t)
            tz=${OPTARG}
            ;;
        a)
            adminL=${OPTARG}
            ;;
        p)
            adminP=${OPTARG}
            ;;
        o)
            ACCESPORT=${OPTARG}
            ;;
        c)
            CLIENTACCESPORT=${OPTARG}
            ;;
        r)
            APACHEACCESPORT=${OPTARG}
            ;;
        e)
            EMAIL=${OPTARG}
            ;;
        m)
            PASSMYSQL=${OPTARG}
            ;;
        s)
            silent=yes
            ;;
        h)
            echo "help usage"
			echo "curl -L https://github.com/dOC4eVER/ubuntu20.04/raw/master/install.sh | sudo bash -s -- -a adminusername -t timezone -p adminpassord -o adminaccesport -c clientaccesport -r apacheport -e email -m mysqlpassword -s yes"
			echo "./install.sh -a adminusername -t timezone -p adminpassord -o adminaccesport -c clientaccesport -r apacheport -e email -m mysqlpassword -s yes"
			echo "option -t for set Time Zone"
			echo "option -a Enter Your Desired Admin Login Access"
			echo "option -p Enter Your Desired Admin Password Access"
			echo "option -o Enter Your Desired Admin Port Access"
			echo "option -c Enter Your Desired Client Port Access"
			echo "option -r Enter Your Desired Apache Port Access"
			echo "option -e Enter Your Email Addres"
			echo "option -m Enter Your Desired MYSQL Password"
			echo "option -s for silent use yes option for remove confirm install"
			echo "option -h for write this help"
			echo "full exemple"
			echo "curl -L https://github.com/dOC4eVER/ubuntu20.04/raw/master/install.sh | bash -s -- -a admin -t Europe/Paris -p admin -o 25500 -c 80 -r 8080 -e admin@example.com -m mysqlpassword -s yes"
			echo "./install.sh -a admin -t Europe/Paris -p admin -o 25500 -c 80 -r 8080 -e admin@example.com -m mysqlpassword -s yes"
			exit
            ;;
        *)
            		tz=
			adminL=
			adminP=
			ACCESPORT=
			CLIENTACCESPORT=
			APACHEACCESPORT=
			EMAIL=
			PASSMYSQL=
			silent=no
            ;;
    esac
done
#clear
XC_VERSION="41 dOC4eVER v01"
PANEL_PATH="/home/xtreamcodes/iptv_xtream_codes"
#--- Display the 'welcome' splash/user warning info..
#test ok
echo ""
    tput setaf 2 ; tput bold ;echo " ┌───────────────────────────────────────────────────────────────────┐"; tput sgr0;
    tput setaf 2 ; tput bold ;echo " │    Welcome to the Official Xtream UI Installer $XC_VERSION    │"; tput sgr0;
    tput setaf 2 ; tput bold ;echo " └───────────────────────────────────────────────────────────────────┘"; tput sgr0;
echo ""
    tput setaf 3 ;tput blink; tput bold ;tput cuf 20;echo "Xtream UI ◄۞ $XC_VERSION ۞► "; tput sgr0;
echo ""
    tput setaf 1 ; tput bold ;tput cuf 5;echo "Supported Operating Systems:"; tput sgr0;
    tput setaf 2 ; tput bold ;tput cuf 5;echo "Ubuntu server 18.04/20.04/22.04"; tput sgr0;
    tput setaf 3 ; tput bold ;tput cuf 5;echo "CentOS 7.*"; tput sgr0;
    tput setaf 4 ; tput bold ;tput cuf 5;echo "CentOS Stream 8.*"; tput sgr0;
    tput setaf 5 ; tput bold ;tput cuf 5;echo "Fedora 34/35/36"; tput sgr0;
    tput setaf 6 ; tput bold ;tput cuf 5;echo "Debian 10/11 "; tput sgr0;
    tput setaf 7 ; tput bold ;tput cuf 5;echo "64bit online system "; tput sgr0;
echo -e "\nChecking that minimal requirements are ok"
echo ""
# Ensure the OS is compatible with the launcher
if [ -f /etc/centos-release ]; then
    inst() {
       rpm -q "$1" &> /dev/null
    } 
    if (inst "centos-stream-repos"); then
    OS="Centos Stream"
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
    VER=${VERFULL:0:2} # return 34 35 or 36
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
if [[ "$VER" = "8" && "$OS" = "CentOs" ]]; then
    tput setaf 3 ; tput bold ;echo "Centos 8 obsolete udate to CentOS-Stream 8"; tput sgr0;
echo " "	
    tput setaf 1 ; tput bold ;echo "this operation may take some time"; tput sgr0;
echo " "	
	sleep 60
	# change repository to use vault.centos.org CentOS 8 found online to vault.centos.org
	find /etc/yum.repos.d -name '*.repo' -exec sed -i 's|mirrorlist=http://mirrorlist.centos.org|#mirrorlist=http://mirrorlist.centos.org|' {} \;
	find /etc/yum.repos.d -name '*.repo' -exec sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|' {} \;
	#update package list
	dnf update -y
	#upgrade all packages to latest CentOS 8
	dnf upgrade -y
	#install Centos Stream 8 repository
	dnf -y install centos-release-stream --allowerasing
	#install rpmconf
	dnf -y install rpmconf
	#set config file with rpmconf
	rpmconf -a
	# remove Centos 8 repository and set CentOS Stream 8 repository by default
	dnf -y swap centos-linux-repos centos-stream-repos
	# system upgrade
	dnf -y distro-sync
	# ceanup old rpmconf file create
	find / -name '*.rpmnew' -exec rm -f {} \;
	find / -name '*.rpmsave' -exec rm -f {} \;
	OS="Centos Stream"
	fi
    tput setaf 3 ; tput bold ;echo "Detected : $OS  $VER  $ARCH"; tput sgr0;
echo ""	
#if [[ "$OS" = "CentOs" && ("$VER" = "6" || "$VER" = "7" || "$VER" = "8" ) ||
#      "$OS" = "Fedora" && ("$VER" = "34" || "$VER" = "35" ) ||
#      "$OS" = "Ubuntu" && ("$VER" = "12.04" || "$VER" = "14.04" || "$VER" = "16.04" || "$VER" = "18.04" ) || 
#      "$OS" = "debian" && ("$VER" = "7" || "$VER" = "8" || "$VER" = "9" || "$VER" = "10" ) ]] ; then
if [[ "$OS" = "Ubuntu" && ("$VER" = "18.04" || "$VER" = "20.04" || "$VER" = "22.04" ) && "$ARCH" == "x86_64" ||
"$OS" = "debian" && ("$VER" = "10" || "$VER" = "11" ) && "$ARCH" == "x86_64" ||
"$OS" = "CentOs" && ("$VER" = "6" || "$VER" = "7" || "$VER" = "8" ) && "$ARCH" == "x86_64" ||
"$OS" = "Centos Stream" && "$VER" = "8" && "$ARCH" == "x86_64" ||
"$OS" = "Fedora" && ("$VER" = "36" || "$VER" = "37" || "$VER" = "38" ) && "$ARCH" == "x86_64" ]] ; then
    tput setaf 2 ; tput bold ;echo "Ok."; tput sgr0;    
else
    tput setaf 1 ; tput bold ;echo "Sorry, this OS is not supported by Xtream UI."; tput sgr0;
echo " "
    exit 1
fi
# Check if the user is 'root' before allowing installation to commence
if [ $UID -ne 0 ]; then
    tput setaf 4 ; tput bold ;echo "Install failed: you must be logged in as 'root' to install."; tput sgr0;
echo ""
    tput setaf 4 ; tput bold ;echo "Use command 'sudo -i', then enter root password and then try again."; tput sgr0;
echo ""
    exit 1
fi
if [ -e /usr/local/cpanel ] || [ -e /usr/local/directadmin ] || [ -e /usr/local/solusvm/www ] || [ -e /usr/local/home/admispconfig ] || [ -e /usr/local/lxlabs/kloxo ] || [ -e /home/zpanel ] || [ -e /home/sentora ] ; then
echo ""
    tput setaf 4 ; tput bold ;echo "It appears that a control panel is already installed on your server; This installer"; tput sgr0;
echo ""
    tput setaf 4 ; tput bold ;echo "is designed to install and configure Sentora on a clean OS installation only."; tput sgr0;
echo ""
    tput setaf 4 ; tput bold ;echo -e "\nPlease re-install your OS before attempting to install using this script."; tput sgr0;
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
    BUILDDEP="yum-builddep -y -q"
    MYSQLCNF=/etc/my.cnf
elif [[ "$OS" = "Fedora" || "$OS" = "Centos Stream"  ]]; then
    PACKAGE_INSTALLER="dnf -y -q install"
    PACKAGE_REMOVER="dnf -y -q remove"
    PACKAGE_UPDATER="dnf -y -q update"
    PACKAGE_UTILS="dnf-utils" 
    PACKAGE_GROUPINSTALL="dnf -y -q groupinstall"
    PACKAGE_SOURCEDOWNLOAD="dnf download --source"
    BUILDDEP="dnf build-dep -y -q"
    MYSQLCNF=/etc/my.cnf
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    PACKAGE_INSTALLER="apt-get -yqq install"
    PACKAGE_REMOVER="apt-get -yqq purge"
    MYSQLCNF=/etc/mysql/mariadb.cnf
    inst() {
       dpkg -l "$1" 2> /dev/null | grep '^ii' &> /dev/null
    }
fi
#--- Prepare or query informations required to install
# Update repositories and Install wget and util used to grab server IP
    tput setaf 6 ; tput bold ;echo -e "\n-- Installing wget and dns utils required to manage inputs"; tput sgr0;
echo ""
if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
	$PACKAGE_INSTALLER $PACKAGE_UTILS
	$PACKAGE_INSTALLER crontabs
    $PACKAGE_UPDATER
        $PACKAGE_INSTALLER bind-utils perl
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
	DEBIAN_FRONTEND=noninteractive
	export DEBIAN_FRONTEND=noninteractive
	if [ -f "/etc/apt/apt.conf.d/99needrestart" ]; then
	sed -i 's|DPkg::Post-Invoke|#DPkg::Post-Invoke|' "/etc/apt/apt.conf.d/99needrestart"
	fi
    	apt-get -qq update   #ensure we can install
    	$PACKAGE_INSTALLER dnsutils net-tools
fi
$PACKAGE_INSTALLER curl wget
ipaddr="$(wget -qO- http://api.sentora.org/ip.txt)"
local_ip=$(ip addr show | awk '$1 == "inet" && $3 == "brd" { sub (/\/.*/,""); print $2 }')
networkcard=$(route | grep default | awk '{print $8}')
blofish=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1)
alg=6
salt='rounds=20000$xtreamcodes'
XPASS=$(</dev/urandom tr -dc A-Z-a-z-0-9 | head -c16)
zzz=$(</dev/urandom tr -dc A-Z-a-z-0-9 | head -c20)
eee=$(</dev/urandom tr -dc A-Z-a-z-0-9 | head -c10)
rrr=$(</dev/urandom tr -dc A-Z-a-z-0-9 | head -c20)
versionn="$OS $VER"
nginx111='$uri'
nginx222='$document_root$fastcgi_script_name'
nginx333='$fastcgi_script_name'
nginx444='$host:$server_port$request_uri'
spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}
if [[ "$tz" == "" ]] ; then
    # Propose selection list for the time zone
echo ""
    tput setaf 5 ;tput blink;tput cuf 5; tput bold ;echo "Preparing to select timezone, please wait a few seconds..."; tput sgr0;
echo " "
    sleep 30
    $PACKAGE_INSTALLER tzdata
    # setup server timezone
    if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
        # make tzselect to save TZ in /etc/timezone
    tput setaf 5 ; tput bold ;echo "echo "echo \$TZ > /etc/timezone" >> /usr/bin/tzselect"; tput sgr0;
echo ""
        tzselect
        tz=$(cat /etc/timezone)
	rm -f /etc/localtime
	ln -s /usr/share/zoneinfo/$tz /etc/localtime
	timedatectl set-timezone $tz
    elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
        DEBIAN_FRONTEND=dialog dpkg-reconfigure tzdata
		DEBIAN_FRONTEND=noninteractive
		export DEBIAN_FRONTEND=noninteractive
        tz=$(cat /etc/timezone)
	rm -f /etc/localtime
	ln -s /usr/share/zoneinfo/$tz /etc/localtime
	timedatectl set-timezone $tz
    fi
else
	echo "time zone set $tz"
	echo $tz > /etc/timezone
	rm -f /etc/localtime
	ln -s /usr/share/zoneinfo/$tz /etc/localtime
	timedatectl set-timezone $tz
fi
echo " "
if [[ "$adminL" == "" ]] ; then
    tput setaf 1 ; tput bold ;read -p "...... Enter Your Desired Admin Login Access: " adminL; tput sgr0;
else
    tput setaf 1 ; tput bold ;echo "Desired Admin Login Access set $adminL"; tput sgr0;
fi
echo " "
if [[ "$adminP" == "" ]] ; then
    tput setaf 2 ; tput bold ;read -p "...... Enter Your Desired Admin Password Access: " adminP; tput sgr0;
else
    tput setaf 2 ; tput bold ;echo "Desired Admin Password Access set $adminP"; tput sgr0;
fi
echo " "
if [[ "$ACCESPORT" == "" ]] ; then
    tput setaf 3 ; tput bold ;read -p "...... Enter Your Desired Admin Port Access: " ACCESPORT; tput sgr0;
else
    tput setaf 3 ; tput bold ;echo "Desired Admin Port Access set $ACCESPORT" ACCESPORT; tput sgr0;
fi
echo " "
if [[ "$CLIENTACCESPORT" == "" ]] ; then
    tput setaf 4 ; tput bold ;read -p"...... Enter Your Desired Client Port Access: " CLIENTACCESPORT; tput sgr0;
else
    tput setaf 4 ; tput bold ;echo "Desired Admin Port Access set $ACCESPORT" ACCESPORT; tput sgr0;
fi
echo " "
if [[ "$APACHEACCESPORT" == "" ]] ; then
    tput setaf 5 ; tput bold ;read -p "...... Enter Your Desired Apache Port Access: " APACHEACCESPORT; tput sgr0;
echo " "
else
    tput setaf 5 ; tput bold ;echo "Desired Admin Port Access set $ACCESPORT" ACCESPORT; tput sgr0;
fi
if [[ "$EMAIL" == "" ]] ; then
    tput setaf 6 ; tput bold ;read -p "...... Enter Your Email Addres: " EMAIL; tput sgr0;
else
    tput setaf 6 ; tput bold ;echo "Your Email Addres set $EMAIL"; tput sgr0;
fi
echo " "
if [[ "$PASSMYSQL" == "" ]] ; then
    tput setaf 7 ; tput bold ;read -p "...... Enter Your Desired MYSQL Password: " PASSMYSQL; tput sgr0;
else
    tput setaf 7 ; tput bold ;echo "Desired MYSQL Password set $PASSMYSQL"; tput sgr0;
fi
echo " . "
PORTSSH=22
echo " "
Padmin=$(perl -e 'print crypt($ARGV[1], "\$" . $ARGV[0] . "\$" . $ARGV[2]), "\n";' "$alg" "$adminP" "$salt")
sleep 1
if [[ "$silent" != "yes" ]] ; then
    tput setaf 3 ; tput bold ;read -e -p "All is ok. Do you want to install Xtream UI now (y/n)? " yn; tput sgr0;
case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
esac
fi
#clear
# ***************************************
# Installation really starts here
echo " "
    tput setaf 1 ;tput blink; tput bold ;tput cuf 20;echo "Installation really starts here" yn; tput sgr0;
echo " "
#--- Set custom logging methods so we create a log file in the current working directory.
logfile=$(date +%Y-%m-%d_%H.%M.%S_xtream_ui_install.log)
touch "$logfile"
exec > >(tee "$logfile")
exec 2>&1
    tput setaf 2 ;tput cuf 20; tput bold ;echo "Installing Xtream UI ◄۞ $XC_VERSION ۞► "; tput sgr0;
echo " "
    tput setaf 3 ; tput bold ;echo "at http://$ipaddr:$ACCESPORT on server under: $OS $VER $ARCH"; tput sgr0;
echo " "
uname -a
# Function to disable a file by appending its name with _disabled
disable_file() {
    mv "$1" "$1_disabled_by_xtream_ui" &> /dev/null
}
wget -qO- https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/depbuild.sh | bash
#--- List all already installed packages (may help to debug)
echo " "
    tput setaf 4 ; tput bold ;echo -e "\n-- Listing of all packages installed:"; tput sgr0;
echo " "
if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
    rpm -qa | sort
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    dpkg --get-selections
fi
echo " "
$PACKAGE_INSTALLER daemonize
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSMYSQL'; flush privileges;"
echo " "
    tput setaf 2 ; tput bold ;echo -e "\\r${CHECK_MARK} Installation Of Packages Done"; tput sgr0;
echo " "
sleep 1s
    tput setaf 4 ; tput bold ;echo -n "[+] Installation Of XtreamCodes..."; tput sgr0;
echo " "
sleep 1s
#### installation de xtream codes
echo " "
if [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
adduser --system --shell /bin/false --group --disabled-login xtreamcodes
else
adduser --system --shell /bin/false xtreamcodes
mkdir -p /home/xtreamcodes
fi
OSNAME=$(echo $OS | sed  "s| |.|g" )
wget -q -O /tmp/xtreamcodes.tar.gz https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/main_xui_"$OSNAME"_"$VER".tar.gz
tar -xf "/tmp/xtreamcodes.tar.gz" -C "/home/xtreamcodes/"
rm -r /tmp/xtreamcodes.tar.gz
mv $MYSQLCNF $MYSQLCNF.xc
echo IyBYdHJlYW0gQ29kZXMNCg0KW2NsaWVudF0NCnBvcnQgICAgICAgICAgICA9IDMzMDYNCg0KW215c3FsZF9zYWZlXQ0KbmljZSAgICAgICAgICAgID0gMA0KDQpbbXlzcWxkXQ0KdXNlciAgICAgICAgICAgID0gbXlzcWwNCnBvcnQgICAgICAgICAgICA9IDc5OTkNCmJhc2VkaXIgICAgICAgICA9IC91c3INCmRhdGFkaXIgICAgICAgICA9IC92YXIvbGliL215c3FsDQp0bXBkaXIgICAgICAgICAgPSAvdG1wDQpsYy1tZXNzYWdlcy1kaXIgPSAvdXNyL3NoYXJlL215c3FsDQpza2lwLWV4dGVybmFsLWxvY2tpbmcNCnNraXAtbmFtZS1yZXNvbHZlPTENCg0KYmluZC1hZGRyZXNzICAgICAgICAgICAgPSAqDQprZXlfYnVmZmVyX3NpemUgPSAxMjhNDQoNCm15aXNhbV9zb3J0X2J1ZmZlcl9zaXplID0gNE0NCm1heF9hbGxvd2VkX3BhY2tldCAgICAgID0gNjRNDQpteWlzYW0tcmVjb3Zlci1vcHRpb25zID0gQkFDS1VQDQptYXhfbGVuZ3RoX2Zvcl9zb3J0X2RhdGEgPSA4MTkyDQpxdWVyeV9jYWNoZV9saW1pdCAgICAgICA9IDRNDQpxdWVyeV9jYWNoZV9zaXplICAgICAgICA9IDI1Nk0NCg0KDQpleHBpcmVfbG9nc19kYXlzICAgICAgICA9IDEwDQptYXhfYmlubG9nX3NpemUgICAgICAgICA9IDEwME0NCg0KbWF4X2Nvbm5lY3Rpb25zICA9IDIwMDAwDQpiYWNrX2xvZyA9IDQwOTYNCm9wZW5fZmlsZXNfbGltaXQgPSAyMDI0MA0KaW5ub2RiX29wZW5fZmlsZXMgPSAyMDI0MA0KbWF4X2Nvbm5lY3RfZXJyb3JzID0gMzA3Mg0KdGFibGVfb3Blbl9jYWNoZSA9IDQwOTYNCnRhYmxlX2RlZmluaXRpb25fY2FjaGUgPSA0MDk2DQoNCg0KdG1wX3RhYmxlX3NpemUgPSAxRw0KbWF4X2hlYXBfdGFibGVfc2l6ZSA9IDFHDQoNCmlubm9kYl9idWZmZXJfcG9vbF9zaXplID0gMTBHDQppbm5vZGJfYnVmZmVyX3Bvb2xfaW5zdGFuY2VzID0gMTANCmlubm9kYl9yZWFkX2lvX3RocmVhZHMgPSA2NA0KaW5ub2RiX3dyaXRlX2lvX3RocmVhZHMgPSA2NA0KaW5ub2RiX3RocmVhZF9jb25jdXJyZW5jeSA9IDANCmlubm9kYl9mbHVzaF9sb2dfYXRfdHJ4X2NvbW1pdCA9IDANCmlubm9kYl9mbHVzaF9tZXRob2QgPSBPX0RJUkVDVA0KcGVyZm9ybWFuY2Vfc2NoZW1hID0gMA0KaW5ub2RiLWZpbGUtcGVyLXRhYmxlID0gMQ0KaW5ub2RiX2lvX2NhcGFjaXR5PTIwMDAwDQppbm5vZGJfdGFibGVfbG9ja3MgPSAwDQppbm5vZGJfbG9ja193YWl0X3RpbWVvdXQgPSAwDQppbm5vZGJfZGVhZGxvY2tfZGV0ZWN0ID0gMA0KDQoNCnNxbC1tb2RlPSJOT19FTkdJTkVfU1VCU1RJVFVUSU9OIg0KDQpbbXlzcWxkdW1wXQ0KcXVpY2sNCnF1b3RlLW5hbWVzDQptYXhfYWxsb3dlZF9wYWNrZXQgICAgICA9IDE2TQ0KDQpbbXlzcWxdDQoNCltpc2FtY2hrXQ0Ka2V5X2J1ZmZlcl9zaXplICAgICAgICAgICAgICA9IDE2TQ0K | base64 --decode > $MYSQLCNF
systemctl restart mariadb
echo " "
    tput setaf 2 ; tput bold ;echo -e "\\r${CHECK_MARK} Installation Of XtreamCodes Done"; tput sgr0;
echo " "
    tput setaf 4 ; tput bold ;echo -n "[+] Configuration Of Mysql & Nginx..."; tput sgr0;
echo " "
echo " "
#### config database
## add python script
python2 << END
# coding: utf-8
import subprocess, os, random, string, sys, shutil, socket
from itertools import cycle, izip
class col:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
rHost = "127.0.0.1"
rPassword = "$XPASS"
rServerID = 1
rUsername = "user_iptvpro"
rDatabase = "xtream_iptvpro"
rPort = 7999
rExtra = " -p$PASSMYSQL"
reseau = "$networkcard"
portadmin = "$ACCESPORT"
getIP = "$ipaddr"
sshssh = "$PORTSSH"
getVersion = "$versionn"
generate1 = "$zzz"
generate2 = "$eee"
generate3 = "$rrr"
def encrypt(rHost="127.0.0.1", rUsername="user_iptvpro", rPassword="", rDatabase="xtream_iptvpro", rServerID=1, rPort=7999):
    rf = open('/home/xtreamcodes/iptv_xtream_codes/config', 'wb')
    rf.write(''.join(chr(ord(c)^ord(k)) for c,k in izip('{\"host\":\"%s\",\"db_user\":\"%s\",\"db_pass\":\"%s\",\"db_name\":\"%s\",\"server_id\":\"%d\", \"db_port\":\"%d\"}' % (rHost, rUsername, rPassword, rDatabase, rServerID, rPort), cycle('5709650b0d7806074842c6de575025b1'))).encode('base64').replace('\n', ''))
    rf.close()
def modifyNginx():
    rPath = "/home/xtreamcodes/iptv_xtream_codes/nginx/conf/nginx.conf"
    rPrevData = open(rPath, "r").read()
    rData = "}".join(rPrevData.split("}")[:-1]) + "    server {\n        listen $ACCESPORT;\n        index index.php index.html index.htm;\n        root /home/xtreamcodes/iptv_xtream_codes/admin/;\n\n        location ~ \.php$ {\n			limit_req zone=one burst=8;\n            try_files ${nginx111} =404;\n			fastcgi_index index.php;\n			fastcgi_pass php;\n			include fastcgi_params;\n			fastcgi_buffering on;\n			fastcgi_buffers 96 32k;\n			fastcgi_buffer_size 32k;\n			fastcgi_max_temp_file_size 0;\n			fastcgi_keep_conn on;\n			fastcgi_param SCRIPT_FILENAME ${nginx222};\n			fastcgi_param SCRIPT_NAME ${nginx333};\n        }\n    }\n}"
    rFile = open(rPath, "w")
    rFile.write(rData)
    rFile.close()
    if not "api.xtream-codes.com" in open("/etc/hosts").read(): os.system('echo "127.0.0.1    api.xtream-codes.com" >> /etc/hosts')
    if not "downloads.xtream-codes.com" in open("/etc/hosts").read(): os.system('echo "127.0.0.1    downloads.xtream-codes.com" >> /etc/hosts')
    if not " xtream-codes.com" in open("/etc/hosts").read(): os.system('echo "127.0.0.1    xtream-codes.com" >> /etc/hosts')
def mysql():
    os.system('mysql -u root%s -e "DROP DATABASE IF EXISTS xtream_iptvpro; CREATE DATABASE IF NOT EXISTS xtream_iptvpro;" > /dev/null' % rExtra)
    os.system("mysql -u root%s xtream_iptvpro < /home/xtreamcodes/iptv_xtream_codes/database.sql > /dev/null" % rExtra)
    os.system('mysql -u root%s -e "USE xtream_iptvpro; REPLACE INTO streaming_servers (id, server_name, domain_name, server_ip, vpn_ip, ssh_password, ssh_port, diff_time_main, http_broadcast_port, total_clients, system_os, network_interface, latency, status, enable_geoip, geoip_countries, last_check_ago, can_delete, server_hardware, total_services, persistent_connections, rtmp_port, geoip_type, isp_names, isp_type, enable_isp, boost_fpm, http_ports_add, network_guaranteed_speed, https_broadcast_port, https_ports_add, whitelist_ips, watchdog_data, timeshift_only) VALUES (1, \'Main Server\', \'\', \'%s\', \'\', NULL, \'%s\', 0, 2082, 1000, \'%s\', \'%s\', 0, 1, 0, \'\', 0, 0, \'{}\', 3, 0, 2086, \'low_priority\', \'\', \'low_priority\', 0, 0, \'\', 1000, 2083, \'\', \'[\"127.0.0.1\",\"\"]\', \'{}\', 0);" > /dev/null' % (rExtra, getIP, sshssh, getVersion, reseau))
    os.system('mysql -u root%s -e "GRANT ALL PRIVILEGES ON *.* TO \'%s\'@\'%%\' IDENTIFIED BY \'%s\' WITH GRANT OPTION; FLUSH PRIVILEGES;" > /dev/null' % (rExtra, rUsername, rPassword))
mysql()
encrypt(rHost, rUsername, rPassword, rDatabase, rServerID, rPort)
modifyNginx()
END
wget -qO install.sql https://github.com/dOC4eVER/ubuntu20.04/raw/master/update_reg_users.py
sed -i "s|adminL|$adminL|g" install.sql
sed -i "s|Padmin|$Padmin|g" install.sql
sed -i "s|EMAIL|$EMAIL|g" install.sql
mysql -u root -p$PASSMYSQL xtream_iptvpro < install.sql
rm -f install.sql
echo " "
    tput setaf 2 ; tput bold ;echo -e "\\r${CHECK_MARK} Configuration Of Mysql & Nginx Done"; tput sgr0;
echo " "
    tput setaf 4 ; tput bold ;echo -n "[+] Configuration Of Crons & Autorisations..."; tput sgr0;
echo " "
echo " "
rm -r /home/xtreamcodes/iptv_xtream_codes/database.sql
if ! grep -q "xtreamcodes ALL = (root) NOPASSWD: /sbin/iptables, /usr/bin/chattr, /usr/bin/python2, /usr/bin/python" /etc/sudoers; then
    tput setaf 3 ; tput bold ;echo "xtreamcodes ALL = (root) NOPASSWD: /sbin/iptables, /usr/bin/chattr, /usr/bin/python2, /usr/bin/python" >> /etc/sudoers; tput sgr0;    
echo " "
fi
ln -s /home/xtreamcodes/iptv_xtream_codes/bin/ffmpeg /usr/bin/
if ! grep -q "tmpfs /home/xtreamcodes/iptv_xtream_codes/streams tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=90% 0 0" /etc/fstab; then
    tput setaf 3 ; tput bold ;echo "tmpfs /home/xtreamcodes/iptv_xtream_codes/streams tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=90% 0 0" >> /etc/fstab; tput sgr0;    
fi
if ! grep -q "tmpfs /home/xtreamcodes/iptv_xtream_codes/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=2G 0 0" /etc/fstab; then
    tput setaf 3 ; tput bold ;echo "tmpfs /home/xtreamcodes/iptv_xtream_codes/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=2G 0 0" >> /etc/fstab; tput sgr0;
fi
chmod -R 0777 /home/xtreamcodes
cat > /home/xtreamcodes/iptv_xtream_codes/nginx/conf/nginx.conf <<EOR
user  xtreamcodes;
worker_processes  auto;
worker_rlimit_nofile 300000;
events {
    worker_connections  16000;
    use epoll;
	accept_mutex on;
	multi_accept on;
}
thread_pool pool_xtream threads=32 max_queue=0;
http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile           on;
    tcp_nopush         on;
    tcp_nodelay        on;
	reset_timedout_connection on;
    gzip off;
    fastcgi_read_timeout 200;
	access_log off;
	keepalive_timeout 10;
	include balance.conf;
	send_timeout 20m;	
	sendfile_max_chunk 512k;
	lingering_close off;
	aio threads=pool_xtream;
	client_body_timeout 13s;
	client_header_timeout 13s;
	client_max_body_size 3m;
	limit_req_zone \$binary_remote_addr zone=one:30m rate=20r/s;
    server {
        listen $CLIENTACCESPORT;listen 25463 ssl;ssl_certificate server.crt;ssl_certificate_key server.key; ssl_protocols SSLv3 TLSv1.1 TLSv1.2;
        index index.php index.html index.htm;
        root /home/xtreamcodes/iptv_xtream_codes/wwwdir/;
        server_tokens off;
        chunked_transfer_encoding off;
		if ( \$request_method !~ ^(GET|POST)\$ ) {
			return 200;
		}
        rewrite_log on;
        rewrite ^/live/(.*)/(.*)/(.*)\.(.*)\$ /streaming/clients_live.php?username=\$1&password=\$2&stream=\$3&extension=\$4 break;
        rewrite ^/movie/(.*)/(.*)/(.*)\$ /streaming/clients_movie.php?username=\$1&password=\$2&stream=\$3&type=movie break;
		rewrite ^/series/(.*)/(.*)/(.*)\$ /streaming/clients_movie.php?username=\$1&password=\$2&stream=\$3&type=series break;
        rewrite ^/(.*)/(.*)/(.*).ch\$ /streaming/clients_live.php?username=\$1&password=\$2&stream=\$3&extension=ts break;
        rewrite ^/(.*)\.ch\$ /streaming/clients_live.php?extension=ts&stream=\$1&qs=\$query_string break;
        rewrite ^/ch(.*)\.m3u8\$ /streaming/clients_live.php?extension=m3u8&stream=\$1&qs=\$query_string break;
		rewrite ^/hls/(.*)/(.*)/(.*)/(.*)/(.*)\$ /streaming/clients_live.php?extension=m3u8&username=\$1&password=\$2&stream=\$3&type=hls&segment=\$5&token=$4 break;
		rewrite ^/hlsr/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)\$ /streaming/clients_live.php?token=\$1&username=\$2&password=\$3&segment=\$6&stream=\$4&key_seg=\$5 break;
		rewrite ^/timeshift/(.*)/(.*)/(.*)/(.*)/(.*)\.(.*)\$ /streaming/timeshift.php?username=\$1&password=\$2&stream=\$5&extension=\$6&duration=\$3&start=\$4 break;
		rewrite ^/timeshifts/(.*)/(.*)/(.*)/(.*)/(.*)\.(.*)\$ /streaming/timeshift.php?username=\$1&password=\$2&stream=\$4&extension=\$6&duration=\$3&start=\$5 break;
		rewrite ^/(.*)/(.*)/(\d+)\$ /streaming/clients_live.php?username=\$1&password=\$2&stream=\$3&extension=ts break;
		#add pvr support
		rewrite ^/server/load.php\$ /portal.php break;
		location /stalker_portal/c {
			alias /home/xtreamcodes/iptv_xtream_codes/wwwdir/c;
		}
		#FFmpeg Report Progress
		location = /progress.php {
		    allow 127.0.0.1;
			deny all;
			fastcgi_pass php;
			include fastcgi_params;
			fastcgi_ignore_client_abort on;
			fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
			fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
		}
  
        location ~ \.php\$ {
			limit_req zone=one burst=8;
            try_files \$uri =404;
			fastcgi_index index.php;
			fastcgi_pass php;
			include fastcgi_params;
			fastcgi_buffering on;
			fastcgi_buffers 96 32k;
			fastcgi_buffer_size 32k;
			fastcgi_max_temp_file_size 0;
			fastcgi_keep_conn on;
			fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
			fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
        }
    }
    server {
        listen $ACCESPORT;
        index index.php index.html index.htm;
        root /home/xtreamcodes/iptv_xtream_codes/admin/;
        location ~ \.php\$ {
			limit_req zone=one burst=8;
            try_files \$uri =404;
			fastcgi_index index.php;
			fastcgi_pass php;
			include fastcgi_params;
			fastcgi_buffering on;
			fastcgi_buffers 96 32k;
			fastcgi_buffer_size 32k;
			fastcgi_max_temp_file_size 0;
			fastcgi_keep_conn on;
			fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
			fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
        }
    }
    #ISP CONFIGURATION
    server {
         listen 8805;
         root /home/xtreamcodes/iptv_xtream_codes/isp/;
         location / {
                      allow 127.0.0.1;
                      deny all;
         }
         location ~ \.php\$ {
                             limit_req zone=one burst=8;
                             try_files \$uri =404;
                             fastcgi_index index.php;
                             fastcgi_pass php;
                             include fastcgi_params;
                             fastcgi_buffering on;
                             fastcgi_buffers 96 32k;
                             fastcgi_buffer_size 32k;
                             fastcgi_max_temp_file_size 0;
                             fastcgi_keep_conn on;
                             fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
                             fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
         }
    }
}
EOR
mysql -u root -p$PASSMYSQL xtream_iptvpro -e "UPDATE streaming_servers SET http_broadcast_port = '$CLIENTACCESPORT' WHERE streaming_servers.id = 1;"
#update gen pass
mysql -u root -p$PASSMYSQL xtream_iptvpro -e "UPDATE settings SET live_streaming_pass = '$zzz' WHERE settings.id = 1;"
mysql -u root -p$PASSMYSQL xtream_iptvpro -e "UPDATE settings SET unique_id = '$eee' WHERE settings.id = 1;"
mysql -u root -p$PASSMYSQL xtream_iptvpro -e "UPDATE settings SET crypt_load_balancing = '$rrr' WHERE settings.id = 1;"
mysql -u root -p$PASSMYSQL xtream_iptvpro -e "UPDATE settings SET crypt_load_balancing = '$rrr' WHERE settings.id = 1;"
#update php.ini timezone
sed -i "s|;date.timezone =|date.timezone = $timezone|g" /home/xtreamcodes/iptv_xtream_codes/php/lib/php.ini
#replace python by python2
#local and security patching settings and admin_settings
echo " "
    tput setaf 2 ; tput bold ;echo -e "\\r${CHECK_MARK} Configuration Of Crons & Autorisations Done"; tput sgr0;
echo " "
    tput setaf 4 ; tput bold ;echo -n "[+] Old CK41 to dOC4eVER v01 Installation Of Admin Web Access..."; tput sgr0;    
echo " "
echo " "
wget -q -O /tmp/update.zip https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/update.zip
unzip -o /tmp/update.zip -d /tmp/update/
chattr -i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
rm -rf /tmp/update/XtreamUI-master/php
rm -rf /tmp/update/XtreamUI-master/GeoLite2.mmdb
cp -rf /tmp/update/XtreamUI-master/* /home/xtreamcodes/iptv_xtream_codes/
rm -rf /tmp/update/XtreamUI-master
rm /tmp/update.zip
rm -rf /tmp/update
xcversion=01
mysql -u root -p$PASSMYSQL xtream_iptvpro -e "UPDATE admin_settings SET value = '$xcversion' WHERE admin_settings.type = 'panel_version'; "
chattr -i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
wget -O /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/GeoLite2.mmdb
chattr +i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
geoliteversion=$(wget -qO- https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/Geolite2_status.json | jq -r ".version")
mysql -u root -p$PASSMYSQL xtream_iptvpro -e "UPDATE admin_settings SET value = '$geoliteversion' WHERE admin_settings.type = 'geolite2_version'; "
chown xtreamcodes:xtreamcodes -R /home/xtreamcodes
chmod +x /home/xtreamcodes/iptv_xtream_codes/start_services.sh
chmod +x /home/xtreamcodes/iptv_xtream_codes/permissions.sh
chmod -R 0777 /home/xtreamcodes/iptv_xtream_codes/crons
#### start xtream after boot
echo "@reboot root sudo /home/xtreamcodes/iptv_xtream_codes/start_services.sh" >> /etc/crontab
/home/xtreamcodes/iptv_xtream_codes/permissions.sh
killall php-fpm
rm -f /home/xtreamcodes/iptv_xtream_codes/php/VaiIb8.pid /home/xtreamcodes/iptv_xtream_codes/php/JdlJXm.pid /home/xtreamcodes/iptv_xtream_codes/php/CWcfSP.pid
rm -f /home/xtreamcodes/iptv_xtream_codes/pytools/balancer.py
rm -f /home/xtreamcodes/iptv_xtream_codes/crons/balancer.php
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/balancer.php -O /home/xtreamcodes/iptv_xtream_codes/crons/balancer.php
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/balancer.sh -O /home/xtreamcodes/iptv_xtream_codes/pytools/balancer.sh
chmod +x /home/xtreamcodes/iptv_xtream_codes/pytools/balancer.sh
rm -f /home/xtreamcodes/iptv_xtream_codes/start_services.sh
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/start_services.sh -O /home/xtreamcodes/iptv_xtream_codes/start_services.sh
chmod +x /home/xtreamcodes/iptv_xtream_codes/start_services.sh
echo " "
    tput setaf 3 ; tput bold ;echo "CentOS or Fedora Require nginx rebuild"; tput sgr0;
echo " "
    tput setaf 1 ; tput blink; tput bold ;echo "please wait this operation can be long"; tput sgr0;
echo " "
sleep 10
$PACKAGE_INSTALLER libaio-devel libmaxminddb-devel
$PACKAGE_INSTALLER libaio-dev libmaxminddb-dev
cd /tmp/
sudo wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1w.tar.gz
tar -xzvf OpenSSL_1_1_1w.tar.gz
cd /root
wget http://nginx.org/download/nginx-1.24.0.tar.gz
tar -xzvf nginx-1.24.0.tar.gz
git clone https://github.com/leev/ngx_http_geoip2_module.git
cd nginx-1.24.0
./configure --prefix=/home/xtreamcodes/iptv_xtream_codes/nginx/ --http-client-body-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/client_temp --http-proxy-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/proxy_temp --http-fastcgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/fastcgi_temp --lock-path=/home/xtreamcodes/iptv_xtream_codes/tmp/nginx.lock --http-uwsgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/uwsgi_temp --http-scgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/scgi_temp --conf-path=/home/xtreamcodes/iptv_xtream_codes/nginx/conf/nginx.conf --error-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/error.log --http-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/access.log --pid-path=/home/xtreamcodes/iptv_xtream_codes/nginx/nginx.pid --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_v2_module --with-pcre --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-threads --with-mail --with-mail_ssl_module --with-file-aio --with-cpu-opt=generic --add-module=/root/ngx_http_geoip2_module --with-openssl=/tmp/openssl-OpenSSL_1_1_1w
make
rm -f /home/xtreamcodes/iptv_xtream_codes/nginx/sbin/nginx
cp objs/nginx /home/xtreamcodes/iptv_xtream_codes/nginx/sbin/
chmod +x /home/xtreamcodes/iptv_xtream_codes/nginx/sbin/nginx
cd /tmp/
rm -rf openssl-OpenSSL_1_1_1w
tar -xzvf OpenSSL_1_1_1w.tar.gz
cd /root
rm -rf nginx-1.24.0 ngx_http_geoip2_module
tar -xzvf nginx-1.24.0.tar.gz
git clone https://github.com/leev/ngx_http_geoip2_module.git
wget https://github.com/arut/nginx-rtmp-module/archive/v1.2.2.zip
unzip v1.2.2.zip
cd nginx-1.24.0
./configure --prefix=/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/ --lock-path=/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/nginx_rtmp.lock --conf-path=/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/conf/nginx.conf --error-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/rtmp_error.log --http-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/rtmp_access.log --pid-path=/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/nginx.pid --add-module=/root/nginx-rtmp-module-1.2.1 --with-pcre --without-http_rewrite_module --with-file-aio --with-cpu-opt=generic --with-openssl=/tmp/openssl-OpenSSL_1_1_1w --add-module=/root/ngx_http_geoip2_module --with-http_ssl_module --with-cc-opt="-Wimplicit-fallthrough=0"
make
cd objs
mv nginx nginx_rtmp
rm -f /home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/nginx_rtmp
cp nginx_rtmp /home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/
chmod +x /home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/nginx_rtmp
cd /root
rm -rf /tmp/OpenSSL_1_1_1w /tmp/openssl-OpenSSL_1_1_1w nginx-1.24.0 v1.2.2.zip nginx-rtmp-module-1.2.1 ngx_http_geoip2_module nginx-1.24.0.tar.gz
/home/xtreamcodes/iptv_xtream_codes/start_services.sh
##################
    tput setaf 3 ; tput bold ;echo -e "\\r${CHECK_MARK} Configuration Auto Start Done"; tput sgr0;
echo " "
echo " ┌───────────────────────────────────────────────────────────────────┐ "
echo " │[R]        Old CK41 to dOC4eVER v01 Installed successfully         │ "
echo " └───────────────────────────────────────────────────────────────────┘ "
############## info install /root/infoinstall.txt ###################
## print infos on putty or openssh client
    tput setaf 2 ; tput bold ;echo " ┌─────────────────  Saved In: /root/Xtreaminfo.txt  ────────────────┐"; tput sgr0;
    tput setaf 1 ; tput bold ;echo " │ USERNAME ->->->->->->->->->->: $adminL"; tput sgr0;
    tput setaf 2 ; tput bold ;echo " │ PASSWORD ->->->->->->->->->->: $adminP"; tput sgr0;
    tput setaf 3 ; tput bold ;echo " │ ADMIN ACCES PORT ->->->->->->: $ACCESPORT"; tput sgr0;
    tput setaf 4 ; tput bold ;echo " │ CLIENT ACCES PORT->->->->->->: $CLIENTACCESPORT"; tput sgr0;
    tput setaf 5 ; tput bold ;echo " │ APACHE ACCES PORT->->->->->->: $APACHEACCESPORT"; tput sgr0;
    tput setaf 6 ; tput bold ;echo " │ EMAIL->->->->->->->->->->->->: $EMAIL"; tput sgr0;
    tput setaf 7 ; tput bold ;echo " │ MYSQL root PASS->->->->->->->: $PASSMYSQL"; tput sgr0;
    tput setaf 8 ; tput bold ;echo " │ MYSQL user_iptvpro PASS->->->: $XPASS"; tput sgr0;
    tput setaf 2 ; tput bold ;echo " └───────────────────────────────────────────────────────────────────┘"; tput sgr0;
######################################################################
## copy info to file text
echo "
┌──────────────────────────  INFO  ─────────────────────────────────
│
│ PANEL ACCESS: http://$ipaddr:$ACCESPORT
│
│ USERNAME: $adminL
│
│ PASSWORD: $adminP
│
│ CLIENT ACCES PORT: $CLIENTACCESPORT
│
│ APACHE ACCES PORT: $APACHEACCESPORT
│
│ EMAIL   : $EMAIL
│
│ MYSQL root PASS: $PASSMYSQL
│
│ MYSQL user_iptvpro PASS: $XPASS
│ 
└───────────────────────────────────────────────────────────────────
" >> /root/Xtreaminfo.txt
