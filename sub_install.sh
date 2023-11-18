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
### fixed by dOC4eVE 2023
#--- Set custom logging methods so we create a log file in the current working directory.
logfile=$(date +%Y-%m-%d_%H.%M.%S_xtream_ui_install.log)
touch "$logfile"
exec > >(tee "$logfile")
exec 2>&1
while getopts ":t:c:i:l:m:h:" option; do
    case "${option}" in
        t)
            tz=${OPTARG}
            ;;
        c)
            CLIENTACCESPORT=${OPTARG}
            ;;
        i)
            MAINIP=${OPTARG}
            ;;
        l)
            LOADID=${OPTARG}
            ;;
        m)
            XPASS=${OPTARG}
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
    tput setaf 4 ;tput cuf 5;tput bold ;echo "require use parameter"; tput sgr0;
echo ""
      exit 0
    esac
done
#clear
XC_VERSION="CK41-> dOC4eVER v03"
PANEL_PATH="/home/xtreamcodes/iptv_xtream_codes"
#--- Display the 'welcome' splash/user warning info..
#test ok
echo ""
    tput setaf 2 ; tput bold ;echo " ┌───────────────────────────────────────────────────────────────────┐"; tput sgr0;
    tput setaf 2 ; tput bold ;echo " │  Welcome to the Official Xtream UI Installer $XC_VERSION  │"; tput sgr0;
    tput setaf 2 ; tput bold ;echo " └───────────────────────────────────────────────────────────────────┘"; tput sgr0;
echo ""
    tput setaf 3 ; tput bold ;tput cuf 20;echo "Xtream UI ◄۞ $XC_VERSION ۞► "; tput sgr0;
echo ""
    tput setaf 1 ; tput bold ; tput cuf 5; echo "Supported Operating Systems:"; tput sgr0;
    tput setaf 2 ; tput bold ; tput cuf 5; echo "Ubuntu server 18.04/20.04/22.04"; tput sgr0;
    tput setaf 3 ; tput bold ; tput cuf 5; echo "CentOS 7.*"; tput sgr0;
    tput setaf 4 ; tput bold ; tput cuf 5; echo "CentOS Stream 8.*"; tput sgr0;
    tput setaf 5 ; tput bold ; tput cuf 5; echo "Fedora 34/35/36"; tput sgr0;
    tput setaf 6 ; tput bold ; tput cuf 5; echo "Debian 10/11 "; tput sgr0;
    tput setaf 7 ; tput bold ; tput cuf 5; echo "64bit online system "; tput sgr0;
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
	# remove Centos 8 repository and set CentOS Stream 8 repository by default
	dnf -y swap centos-linux-repos centos-stream-repos
	# system upgrade
	dnf -y distro-sync
	# ceanup old rpmconf file create
	find / -name '*.rpmnew' -exec rm -f {} \;
	find / -name '*.rpmsave' -exec rm -f {} \;
	OS="Centos Stream"
	fi
    echo -e " \033[1;33m Detected\033[1;36m $OS\033[1;32m $VER\033[0m" "\033[1;35m$ARCH\033[0m"
echo ""	
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
elif [[ "$OS" = "Fedora" || "$OS" = "Centos Stream"  ]]; then
    PACKAGE_INSTALLER="dnf -y -q install"
    PACKAGE_REMOVER="dnf -y -q remove"
    PACKAGE_UPDATER="dnf -y -q update"
    PACKAGE_UTILS="dnf-utils" 
    PACKAGE_GROUPINSTALL="dnf -y -q groupinstall"
    PACKAGE_SOURCEDOWNLOAD="dnf download --source"
    BUILDDEP="dnf build-dep -y -q"
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    PACKAGE_INSTALLER="apt-get -yqq install"
    PACKAGE_REMOVER="apt-get -yqq purge"
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
#XPASS=$(</dev/urandom tr -dc A-Z-a-z-0-9 | head -c16)
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
    sleep 10
# sleep 30	old value
    $PACKAGE_INSTALLER tzdata
    # setup server timezone
    if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
        # make tzselect to save TZ in /etc/timezone
        echo "echo \$TZ > /etc/timezone" >> /usr/bin/tzselect
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
######################################################################
if [[ "$MAINIP" == "" ]] ; then
    tput setaf 1 ; tput bold ;read -p " Main Server IP Address ->->->->: " MAINIP; tput sgr0;
else
    tput setaf 1 ; tput bold ;echo "Your MAIN IP set $MAINIP"; tput sgr0;
fi
echo " "
######################################################################
if [[ "$XPASS" == "" ]] ; then
    tput setaf 2 ; tput bold ;read -p " MYSQL user_iptvpro PASS->->->->: " XPASS; tput sgr0;
else
    tput setaf 2 ; tput bold ;echo "Your PASS MYSQL set $XPASS"; tput sgr0;
fi
echo " "
######################################################################
if [[ "$LOADID" == "" ]] ; then
    tput setaf 3 ; tput bold ;read -p " Load Balancer Server ID->->->->: " LOADID; tput sgr0;
else
    tput setaf 3 ; tput bold ;echo "Your LOAD ID set $LOADID"; tput sgr0;
fi
echo " "
######################################################################
if [[ "$CLIENTACCESPORT" == "" ]] ; then
    tput setaf 4 ; tput bold ;read -p" Client Port Access ->->->->->->: " CLIENTACCESPORT; tput sgr0;
else
    tput setaf 4 ; tput bold ;echo "Your Client Port Access set $CLIENTACCESPORT"; tput sgr0;
fi
echo " "
######################################################################

PORTSSH=22
echo " "
sleep 1
if [[ "$silent" != "yes" ]] ; then
    tput setaf 3 ; tput bold ;read -e -p "All is ok. Do you want to install Load Balancer now (y/n)? " yn; tput sgr0;
case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
esac
fi
clear
# ***************************************
# Installation really starts here
echo ""

echo ""
    tput setaf 1 ;tput blink; tput bold ;tput cuf 20;echo "Installation really starts here" yn; tput sgr0;
echo " "
#--- Set custom logging methods so we create a log file in the current working directory.
logfile=$(date +%Y-%m-%d_%H.%M.%S_xtream_ui_install.log)
touch "$logfile"
exec > >(tee "$logfile")
exec 2>&1
 echo " "
## print infos on putty or openssh client
#############################################################################################
    echo -e "\033[1;32m ─────────────────────\033[0m""\033[1;35m Installing the LOAD BALANCER \033[0m""\033[1;32m─────────────────────\033[0m"
    echo -e " \033[1;33m Installing the LOAD BALANCER on the server with the IP\033[0m": $ipaddr
    echo -e " \033[1;33m under\033[0m""\033[1;36m $OS\033[1;32m $VER\033[0m" "\033[1;35m$ARCH\033[0m""\033[1;33m which will be associated with the\033[0m"
    echo -e " \033[1;33m MAIN with IP\033[0m": $MAINIP:"\033[1;34m$CLIENTACCESPORT \033[0m"
    echo -e "\033[1;32m ────────────────────────────────────────────────────────────────────────\033[0m"   
echo " "
uname -a
# Function to disable a file by appending its name with _disabled
disable_file() {
    mv "$1" "$1_disabled_by_xtream_ui" &> /dev/null
}
#--- Ubuntu and Debian AppArmor must be disabled to avoid problems
if [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    [ -f /etc/init.d/apparmor ]
    if [ $? = "0" ]; then
 echo " "
   tput setaf 4 ; tput cuf 5; tput bold ;echo -e "\n-- Disabling and removing AppArmor, please wait..."; tput sgr0;
 echo " "
        systemctl stop apparmor &> /dev/null
        systemctl disable apparmor &> /dev/null
        PACKAGE_REMOVER apparmor* &> /dev/null
        disable_file /etc/init.d/apparmor &> /dev/null
 echo ""
   tput setaf 2 ; tput cuf 5; tput bold ;echo -e "AppArmor has been removed."; tput sgr0;
 echo ""
    fi
	ufw disable
fi
#--- Adapt repositories and packages sources
 echo " "
   tput setaf 4 ; tput cuf 5; tput bold ;echo -e "\n-- Updating repositories and packages sources"; tput sgr0;
 echo ""
if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
	if [[ "$OS" = "CentOs" || "$OS" = "Centos Stream" ]]; then
		find /etc/yum.repos.d -name '*.repo' -exec sed -i 's|mirrorlist=http://mirrorlist.centos.org|#mirrorlist=http://mirrorlist.centos.org|' {} \;
		find /etc/yum.repos.d -name '*.repo' -exec sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://mirror.centos.org|' {} \;
		yum -y install https://rpms.remirepo.net/enterprise/remi-release-"$VER".rpm
		#check if the machine and on openvz
		if [ -f "/etc/yum.repos.d/vz.repo" ]; then
			sed -i "s|mirrorlist=http://vzdownload.swsoft.com/download/mirrors/centos-$VER|baseurl=http://vzdownload.swsoft.com/ez/packages/centos/$VER/$ARCH/os/|" "/etc/yum.repos.d/vz.repo"
			sed -i "s|mirrorlist=http://vzdownload.swsoft.com/download/mirrors/updates-released-ce$VER|baseurl=http://vzdownload.swsoft.com/ez/packages/centos/$VER/$ARCH/updates/|" "/etc/yum.repos.d/vz.repo"
		fi
		$PACKAGE_INSTALLER epel-releas
		$PACKAGE_INSTALLER https://rpms.remirepo.net/enterprise/remi-release-"$VER".rpm
	elif [[ "$OS" = "Fedora" ]]; then
		yum -y install https://rpms.remirepo.net/fedora/remi-release-"$VER".rpm
	fi
	#disable deposits that could result in installation errors
	find /etc/yum.repos.d -name '*.repo' -exec sed -i 's|enabled=1|enabled=0|' {} \;
	if [ -f "/etc/yum.repos.d/vz.repo" ]; then
		sed -i "s|enabled=0|enabled=1|" "/etc/yum.repos.d/vz.repo"
	fi
	enablerepo() {
	if [ "$OS" = "CentOs" ]; then
        	yum-config-manager --enable $1
	else
		dnf config-manager --set-enabled $1
        fi
	}
	if [ "$OS" = "CentOs" ]; then
		# enable official repository CentOs Base
		enablerepo base
		# enable official repository CentOs Updates
		enablerepo updates
		enablerepo epel
	elif [ "$OS" = "Centos Stream" ]; then
		# enable official repository CentOs Stream BaseOS
		enablerepo baseos
		# enable official repository CentOs Stream AppStream
		enablerepo appstream
		# enable official repository CentOs Stream extra
		enablerepo extras
		# enable official repository CentOs Stream extra-common
		enablerepo extras-common
		# enable official repository CentOs Stream PowerTools
		enablerepo powertools
		# enable official repository Fedora Epel
		enablerepo epel
		# enable official repository Fedora Epel Modular
		enablerepo epel-modular
		# install wget and add copr repo for devel package not build on official depots
		# temporary solve bug
		# https://bugzilla.redhat.com/show_bug.cgi?id=2099386
		# final bug solved packages found on PowerTools
		# just enable official repository CentOs Stream PowerTools for solve
	elif [ "$OS" = "Fedora" ]; then
		enablerepo fedora
		enablerepo fedora-cisco-openh264
		enablerepo fedora-modular
		enablerepo updates-modular
		enablerepo updates
	fi
	# enable repository Remi's RPM repository
	enablerepo remi
	enablerepo remi-safe
	yumpurge() {
	for package in $@
	do
		echo "removing config files for $package"
		for file in $(rpm -q --configfiles $package)
		do
			echo "  removing $file"
			rm -f $file
		done
		rpm -e $package
	done
	}
cat > /etc/yum.repos.d/remi-source.repo <<EOF
[remi-source]
name=Remi's RPM source repository
baseurl=https://rpms.remirepo.net/SRPMS/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi
EOF

if [[ "$OS" = "CentOs" || "$OS" = "Centos Stream" ]]; then
curl -L https://downloads.mariadb.com/MariaDB/mariadb_repo_setup  | bash -s -- --mariadb-server-version=10.9
elif [[ "$OS" = "Fedora" ]]; then
cat > /etc/yum.repos.d/mariadb.repo <<EOF
[mariadb]
name=MariaDB RPM source
baseurl=http://mirror.mariadb.org/yum/10.9/fedora/$VER/x86_64/
enabled=1
gpgcheck=0
EOF
fi
	# We need to disable SELinux...
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
	setenforce 0
	# Stop conflicting services and iptables to ensure all services will work
	if  [[ "$VER" = "7" || "$VER" = "8" || "$VER" = "34" || "$VER" = "35" || "$VER" = "36" ]]; then
		systemctl  stop sendmail.service
		systemctl  disable sendmail.service
	else
		service sendmail stop
		chkconfig sendmail off
	fi
	# disable firewall
	$PACKAGE_INSTALLER iptables
	$PACKAGE_INSTALLER firewalld
	if  [[ "$VER" = "7" || "$VER" = "8" || "$VER" = "34" || "$VER" = "35" || "$VER" = "36" ]]; then
		FIREWALL_SERVICE="firewalld"
	else
		FIREWALL_SERVICE="iptables"
	fi
	if  [[ "$VER" = "7" || "$VER" = "8" || "$VER" = "34" || "$VER" = "35" || "$VER" = "36" ]]; then
		systemctl  save "$FIREWALL_SERVICE".service
		systemctl  stop "$FIREWALL_SERVICE".service
		systemctl  disable "$FIREWALL_SERVICE".service
	else
		service "$FIREWALL_SERVICE" save
		service "$FIREWALL_SERVICE" stop
		chkconfig "$FIREWALL_SERVICE" off
	fi
	# Removal of conflicting packages prior to installation.
	yumpurge bind-chroot
	yumpurge qpid-cpp-client
elif [[ "$OS" = "Ubuntu" ]]; then
	DEBIAN_FRONTEND=noninteractive
	export DEBIAN_FRONTEND=noninteractive
	# Update the enabled Aptitude repositories
    echo -e "\nUpdating Aptitude Repos: "
	mkdir -p "/etc/apt/sources.list.d.save"
	cp -R "/etc/apt/sources.list.d/*" "/etc/apt/sources.list.d.save" &> /dev/null
	rm -rf "/etc/apt/sources.list/*"
	cp "/etc/apt/sources.list" "/etc/apt/sources.list.save"
	cat > /etc/apt/sources.list <<EOF
#Depots main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main restricted universe multiverse 
deb-src http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-security main restricted universe multiverse
deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner
deb-src http://archive.canonical.com/ubuntu $(lsb_release -sc) partner
EOF
    echo -e "update mirror list"
	apt-get update
	echo "install software-properties-common"
	apt-get install software-properties-common dirmngr --install-recommends -y
	echo "install ppa curl"
	add-apt-repository ppa:andykimpe/curl -y
	echo "updatelist after ppa add"
	apt-get update
	echo "add mariadb key"
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
	echo "add mariadb repo"
	add-apt-repository -y "deb [arch=amd64,arm64,ppc64el] https://mirrors.nxthost.com/mariadb/repo/10.9/ubuntu/ $(lsb_release -cs) main"
	echo "final update list"
	apt-get update
	echo "final update list end"
elif [[ "$OS" = "debian" ]]; then
	DEBIAN_FRONTEND=noninteractive
	export DEBIAN_FRONTEND=noninteractive
	# Update the enabled Aptitude repositories
	echo -ne "\nUpdating Aptitude Repos: " >/dev/tty
	apt-get update
	apt install curl wget apt-transport-https gnupg2 dirmngr -y
	mkdir -p "/etc/apt/sources.list.d.save"
	cp -R "/etc/apt/sources.list.d/*" "/etc/apt/sources.list.d.save" &> /dev/null
	rm -rf "/etc/apt/sources.list/*"
	cp "/etc/apt/sources.list" "/etc/apt/sources.list.save"
	cat > /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian/ $(lsb_release -sc) main contrib non-free
deb-src http://deb.debian.org/debian/ $(lsb_release -sc) main contrib non-free
deb http://deb.debian.org/debian/ $(lsb_release -sc)-updates main contrib non-free
deb-src http://deb.debian.org/debian/ $(lsb_release -sc)-updates main contrib non-free
deb http://deb.debian.org/debian-security/ $(lsb_release -sc)/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ $(lsb_release -sc)/updates main contrib non-free
EOF
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
	echo "deb [arch=amd64,arm64,ppc64el] https://mirrors.nxthost.com/mariadb/repo/10.9/debian/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/mariadb.list
	apt-get update
fi
#--- List all already installed packages (may help to debug)
echo " "
    tput setaf 4 ; tput cuf 5; tput bold ;echo -e "\n-- Listing of all packages installed:"; tput sgr0;
echo " "
if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
    rpm -qa | sort
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    dpkg --get-selections
fi
	#--- Ensures that all packages are up to date
    tput setaf 1 ; tput cuf 5; tput bold ;echo -e "\n-- Updating+upgrading system, it may take some time..."; tput sgr0;    
echo " "	
if [[ "$OS" = "CentOs" || "$OS" = "Fedora" ]]; then
    $PACKAGE_UPDATER
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    apt-get update
    apt-get -y dist-upgrade
fi
if [[ "$OS" = "Ubuntu" ]]; then
    apt-get purge libcurl3 -y
fi
#--- Install utility packages required by the installer and/or Sentora.
    tput setaf 1 ; tput cuf 5; tput bold ;echo -e "\n-- Downloading and installing required tools..."; tput sgr0;    
echo " "	
if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
    $PACKAGE_INSTALLER sudo vim make zip unzip chkconfig bash-completion
    if  [[ "$VER" = "7" ]]; then
    	$PACKAGE_INSTALLER ld-linux.so.2 libbz2.so.1 libdb-4.7.so libgd.so.2
    else
    	$PACKAGE_INSTALLER glibc32 bzip2-libs 
    fi
    $PACKAGE_INSTALLER sudo curl curl-devel perl-libwww-perl libxml2 libxml2-devel zip bzip2-devel gcc gcc-c++ at make
    $PACKAGE_INSTALLER ca-certificates nano psmisc
    $PACKAGE_GROUPINSTALL "Fedora Packager" "Development Tools"
	if [[ "$VER" = "7" ]]; then
$PACKAGE_INSTALLER https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-basic-21.6.0.0.0-1.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-sqlplus-21.6.0.0.0-1.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-tools-21.6.0.0.0-1.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-devel-21.6.0.0.0-1.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-jdbc-21.6.0.0.0-1.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-odbc-21.6.0.0.0-1.x86_64.rpm
$PACKAGE_INSTALLER http://packages.psychotic.ninja/7/plus/x86_64/RPMS/libzip-0.11.2-6.el7.psychotic.x86_64.rpm http://packages.psychotic.ninja/7/plus/x86_64/RPMS/libzip-devel-0.11.2-6.el7.psychotic.x86_64.rpm
	else
$PACKAGE_INSTALLER https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-basic-21.6.0.0.0-1.el8.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-sqlplus-21.6.0.0.0-1.el8.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-tools-21.6.0.0.0-1.el8.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-devel-21.6.0.0.0-1.el8.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-jdbc-21.6.0.0.0-1.el8.x86_64.rpm \
https://download.oracle.com/otn_software/linux/instantclient/216000/oracle-instantclient-odbc-21.6.0.0.0-1.el8.x86_64.rpm
$PACKAGE_INSTALLER libzip-devel
	fi
	$PACKAGE_SOURCEDOWNLOAD php73-php-7.3.33-3.remi.src
	rpm -i php73-php-7.3.33-3.remi.src.rpm
	$BUILDDEP /root/rpmbuild/SPECS/php.spec
	$BUILDDEP php73
	rm -rf php73-php-7.3.33-3.remi.src.rpm /root/rpmbuild/SPECS/php.spec /root/rpmbuild/SOURCES/php* /root/rpmbuild/SOURCES/10-opcache.ini ls /root/rpmbuild/SOURCES/20-oci8.ini /root/rpmbuild/SOURCES/macros.php /root/rpmbuild/SOURCES/opcache-default.blacklist
	$PACKAGE_INSTALLER sudo vim make zip unzip at bash-completion ca-certificates jq sshpass net-tools curl
	$PACKAGE_INSTALLER e2fslibs
	$PACKAGE_INSTALLER e2fsprogs
	$PACKAGE_INSTALLER e2fsprogs-libs
	$PACKAGE_INSTALLER libcurl-devel
	$PACKAGE_INSTALLER libxslt-devel GeoIP-devel wget nscd htop unzip httpd httpd-devel zip mc libpng-devel python3 python3-pip
	$PACKAGE_INSTALLER mcrypt
	$PACKAGE_INSTALLER mcrypt-devel
	$PACKAGE_INSTALLER libmcrypt
	$PACKAGE_INSTALLER libmcrypt-devel
	$PACKAGE_INSTALLER MariaDB-client
	if [[ "$VER" = "7" ]]; then
	$PACKAGE_INSTALLER python python-paramiko python-pip
	else
	$PACKAGE_INSTALLER python2
	#install pip2
	wget -qO- https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2 - 'pip==20.3.4'
	#upgrade pip3
	pyfv=$(python3 --version | sed  "s|Python ||g")
	pyv=${pyfv:0:3}
	wget -qO- https://bootstrap.pypa.io/pip/$pyv/get-pip.py | python3
	rm -rf /usr/local/bin/pip /usr/local/bin/pip2 /usr/local/bin/pip3  /usr/bin/pip /usr/bin/pip2 /usr/bin/pip3
cat > /usr/bin/pip2 <<EOF
#!/usr/bin/python2
# -*- coding: utf-8 -*-
import re
import sys
from pip._internal.cli.main import main
if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
EOF
chmod +x /usr/bin/pip2
cat > /usr/bin/pip3 <<EOF
#!/usr/bin/python3
# -*- coding: utf-8 -*-
import re
import sys
from pip._internal.cli.main import main
if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
EOF
	chmod +x /usr/bin/pip3
	ln -s /usr/bin/pip2 /usr/local/bin/pip2
	ln -s /usr/bin/pip3 /usr/local/bin/pip3
	pip2 install paramiko
	
	update-alternatives --remove-all pip
	update-alternatives --install /usr/bin/pip pip /usr/bin/pip2 2
	ln -s /usr/bin/pip /usr/local/bin/pip
	update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
	rm -f /usr/bin/python
	update-alternatives --remove-all python
	update-alternatives --install /usr/bin/python python /usr/bin/python3 2
	update-alternatives --install /usr/bin/python python /usr/local/bin/python2 1
	fi
	sed -i "s/Listen 80/Listen $APACHEACCESPORT/g" /etc/httpd/conf/httpd.conf
	systemctl restart httpd
	systemctl enable httpd
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
	$PACKAGE_INSTALLER debhelper cdbs lintian build-essential fakeroot devscripts dh-make
	apt-get -y build-dep php7.3
        $PACKAGE_INSTALLER sudo vim make zip unzip debconf-utils at bash-completion ca-certificates e2fslibs jq sshpass
	$PACKAGE_INSTALLER net-tools curl 
	apt-get purge libcurl3 -y
	$PACKAGE_INSTALLER libcurl4 libxslt1-dev libgeoip-dev e2fsprogs wget mcrypt libmcrypt-dev nscd htop unzip ufw apache2 zip mc libpng16-16 python2 python3
	ufw disable
	$PACKAGE_INSTALLER libmcrypt4 libmcrypt-dev mcrypt libgeoip-dev
	$PACKAGE_INSTALLER libzip5
	$PACKAGE_INSTALLER libzip4
	apt-get update
	$PACKAGE_INSTALLER mariadb-client-10.5
	$PACKAGE_INSTALLER  mariadb-client
	echo "postfix postfix/mailname string postfixmessage" | debconf-set-selections
	echo "postfix postfix/main_mailer_type string 'Local only'" | debconf-set-selections
	$PACKAGE_INSTALLER postfix
	if [[ "$VER" = "18.04" ]]; then
		$PACKAGE_INSTALLER python python-paramiko python-pip
		$PACKAGE_INSTALLER python3-pip python3
		#upgrade pip3
		pyfv=$(python3 --version | sed  "s|Python ||g")
		pyv=${pyfv:0:3}
		wget -qO- https://bootstrap.pypa.io/pip/$pyv/get-pip.py | python3
		rm -rf /usr/local/bin/pip /usr/local/bin/pip2 /usr/local/bin/pip3  /usr/bin/pip /usr/bin/pip2 /usr/bin/pip3
cat > /usr/bin/pip3 <<EOF
!/usr/bin/python3
 -*- coding: utf-8 -*-
import re
import sys
from pip._internal.cli.main import main
if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
EOF
		chmod +x /usr/bin/pip3
		ln -s /usr/bin/pip3 /usr/local/bin/pip3
cat > /usr/bin/pip <<EOF
#!/usr/bin/python2
# GENERATED BY DEBIAN
import sys
# Run the main entry point, similarly to how setuptools does it, but because
# we didn't install the actual entry point from setup.py, don't use the
# pkg_resources API.
from pip import main
if __name__ == '__main__':
    sys.exit(main())
EOF
		chmod +x /usr/bin/pip
		ln -s /usr/bin/pip /usr/local/bin/pip
cat > /usr/bin/pip2 <<EOF
#!/usr/bin/python2
# GENERATED BY DEBIAN
import sys
# Run the main entry point, similarly to how setuptools does it, but because
# we didn't install the actual entry point from setup.py, don't use the
# pkg_resources API.
from pip import main
if __name__ == '__main__':
    sys.exit(main())
EOF
		chmod +x /usr/bin/pip2
		ln -s /usr/bin/pip2 /usr/local/bin/pip2
	else
		$PACKAGE_INSTALLER python3-pip python3
		#install pip2
		wget -qO- https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2 - 'pip==20.3.4'
		#upgrade pip3
		pyfv=$(python3 --version | sed  "s|Python ||g")
		pyv=${pyfv:0:3}
		wget -qO- https://bootstrap.pypa.io/pip/$pyv/get-pip.py | python3
		rm -rf /usr/local/bin/pip /usr/local/bin/pip2 /usr/local/bin/pip3  /usr/bin/pip /usr/bin/pip2 /usr/bin/pip3
cat > /usr/bin/pip2 <<EOF
#!/usr/bin/python2
# -*- coding: utf-8 -*-
import re
import sys
from pip._internal.cli.main import main
if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
EOF
chmod +x /usr/bin/pip2
cat > /usr/bin/pip3 <<EOF
#!/usr/bin/python3
# -*- coding: utf-8 -*-
import re
import sys
from pip._internal.cli.main import main
if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
EOF
	chmod +x /usr/bin/pip3
	ln -s /usr/bin/pip2 /usr/local/bin/pip2
	ln -s /usr/bin/pip3 /usr/local/bin/pip3
	pip2 install paramiko
	update-alternatives --remove-all pip
	update-alternatives --install /usr/bin/pip pip /usr/bin/pip2 2
	ln -s /usr/bin/pip /usr/local/bin/pip
	update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
	rm -f /usr/bin/python
	update-alternatives --remove-all python
	update-alternatives --install /usr/bin/python pythonp /usr/bin/python3 2
	update-alternatives --install /usr/bin/python python /usr/local/bin/python2 1
	fi
  echo "not require"
	fi
$PACKAGE_INSTALLER daemonize
echo " "
    tput setaf 2 ; tput cuf 5; tput bold ;echo -e "\\r${CHECK_MARK} Installation Of Packages Done"; tput sgr0;
echo " "
sleep 1s
#### Installation Of Load Balancer
    tput setaf 4 ; tput cuf 5; tput bold ;echo -n "[+] Installation Of Load Balancer..."; tput sgr0;
echo " "
sleep 1s
echo " "
if [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
adduser --system --shell /bin/false --group --disabled-login xtreamcodes
else
adduser --system --shell /bin/false xtreamcodes
mkdir -p /home/xtreamcodes
fi
OSNAME=$(echo $OS | sed  "s| |.|g" )
wget -q -O /tmp/xtreamcodes.tar.gz https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/sub_xui_"$OSNAME"_"$VER".tar.gz
tar -xf "/tmp/xtreamcodes.tar.gz" -C "/home/xtreamcodes/"
rm -r /tmp/xtreamcodes.tar.gz



echo " "
    tput setaf 2 ; tput bold ;echo -e "\\r${CHECK_MARK} Installation Of XtreamCodes Done"; tput sgr0;
echo " "
    tput setaf 4 ; tput bold ;echo -n "[+] Configuration Of Mysql & Nginx..."; tput sgr0;
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
rHost = "$MAINIP"
rPassword = "$XPASS"
rServerID = $LOADID
rUsername = "user_iptvpro"
rDatabase = "xtream_iptvpro"
rPort = 7999
rExtra = " -p$PASSMYSQL"
reseau = "$networkcard"
portadmin = "$ACCESPORT"

sshssh = "$PORTSSH"
getVersion = "$versionn"
generate1 = "$zzz"
generate2 = "$eee"
generate3 = "$rrr"
def encrypt(rHost="127.0.0.1", rUsername="user_iptvpro", rPassword="", rDatabase="xtream_iptvpro", rServerID=1, rPort=7999):
    rf = open('/home/xtreamcodes/iptv_xtream_codes/config', 'wb')
    rf.write(''.join(chr(ord(c)^ord(k)) for c,k in izip('{\"host\":\"%s\",\"db_user\":\"%s\",\"db_pass\":\"%s\",\"db_name\":\"%s\",\"server_id\":\"%d\", \"db_port\":\"%d\"}' % (rHost, rUsername, rPassword, rDatabase, rServerID, rPort), cycle('5709650b0d7806074842c6de575025b1'))).encode('base64').replace('\n', ''))
    rf.close()
encrypt(rHost, rUsername, rPassword, rDatabase, rServerID, rPort)
END
echo " "
    tput setaf 2 ; tput cuf 5; tput bold ;echo -e "\\r${CHECK_MARK} Configuration Of Mysql & Nginx Done"; tput sgr0;
echo " "
    tput setaf 4 ; tput cuf 5; tput bold ;echo -n "[+] Configuration Of Crons & Autorisations..."; tput sgr0;    
echo " "
echo " "
if ! grep -q "xtreamcodes ALL = (root) NOPASSWD: /sbin/iptables, /usr/bin/chattr, /usr/bin/python2, /usr/bin/python" /etc/sudoers; then
   echo "xtreamcodes ALL = (root) NOPASSWD: /sbin/iptables, /usr/bin/chattr, /usr/bin/python2, /usr/bin/python" >> /etc/sudoers;
fi
ln -s /home/xtreamcodes/iptv_xtream_codes/bin/ffmpeg /usr/bin/
if ! grep -q "tmpfs /home/xtreamcodes/iptv_xtream_codes/streams tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=90% 0 0" /etc/fstab; then
   echo "tmpfs /home/xtreamcodes/iptv_xtream_codes/streams tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=90% 0 0" >> /etc/fstab;    
fi
if ! grep -q "tmpfs /home/xtreamcodes/iptv_xtream_codes/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=2G 0 0" /etc/fstab; then
   echo "tmpfs /home/xtreamcodes/iptv_xtream_codes/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=2G 0 0" >> /etc/fstab;
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
}
EOR
#update php.ini timezone
sed -i "s|;date.timezone =|date.timezone = $timezone|g" /home/xtreamcodes/iptv_xtream_codes/php/lib/php.ini
#replace python by python2
#local and security patching settings and admin_settings
echo " "
    tput setaf 2 ; tput bold ;echo -e "\\r${CHECK_MARK} Configuration Of Crons & Autorisations Done"; tput sgr0;
echo " "
    tput setaf 4 ; tput bold ;echo -n "[+] Installation Of Load Balancer..."; tput sgr0;    
echo " "
chattr -i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
wget -O /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/GeoLite2.mmdb
chattr -ai /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
sudo chmod 0777 /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb
    mkdir /home/xtreamcodes/iptv_xtream_codes/pytools
wget -O /home/xtreamcodes/iptv_xtream_codes/pytools/config.py https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/config.py
wget -O /home/xtreamcodes/iptv_xtream_codes/pytools/config_p3.py https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/config_p3.py
    #chmod 0777 /home/xtreamcodes/iptv_xtream_codes/pytools
chmod +x /home/xtreamcodes/iptv_xtream_codes/start_services.sh
#chmod +x /home/xtreamcodes/iptv_xtream_codes/permissions.sh
chmod -R 0777 /home/xtreamcodes/iptv_xtream_codes/crons
#### start xtream after boot
echo "@reboot root sudo /home/xtreamcodes/iptv_xtream_codes/start_services.sh" >> /etc/crontab
#/home/xtreamcodes/iptv_xtream_codes/permissions.sh
killall php-fpm
rm -f /home/xtreamcodes/iptv_xtream_codes/php/VaiIb8.pid /home/xtreamcodes/iptv_xtream_codes/php/JdlJXm.pid /home/xtreamcodes/iptv_xtream_codes/php/CWcfSP.pid
rm -f /home/xtreamcodes/iptv_xtream_codes/start_services.sh
wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/start_services.sh -O /home/xtreamcodes/iptv_xtream_codes/start_services.sh
chmod +x /home/xtreamcodes/iptv_xtream_codes/start_services.sh
if [[ "$OS" = "CentOs" || "$OS" = "Fedora" || "$OS" = "Centos Stream" ]]; then
echo " "
    tput setaf 3 ; tput cuf 5; tput bold ;echo "CentOS or Fedora Require nginx rebuild"; tput sgr0;
echo " "
    tput setaf 1 ; tput cuf 5; tput blink; tput bold ;echo "please wait this operation can be long"; tput sgr0;
echo " "
sleep 10
#sleep 60 ancienne valeur(dOC4eVER)
$PACKAGE_INSTALLER libaio-devel libmaxminddb-devel
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
rm -rf /tmp/OpenSSL_1_1_1w /tmp/openssl-OpenSSL_1_1_1w nginx-1.24.0 v1.2.2.zip nginx-rtmp-module-1.2.2 ngx_http_geoip2_module nginx-1.24.0.tar.gz
fi
/home/xtreamcodes/iptv_xtream_codes/start_services.sh
##################
    tput setaf 2 ; tput bold ;echo -e "\\r${CHECK_MARK} Configuration Auto Start Done"; tput sgr0;
echo " "
echo " ┌────────────────────────────────────────────────────────┐ "
echo " │[R]        LOAD BALANCER  Installed successfully        │ "
echo " └────────────────────────────────────────────────────────┘ "
echo " "
############ info install /root/infoinstall.txt ############
## print infos on putty or openssh client
echo -e " \033[1;33m fixed by\033[0m""\033[1;32m dOC4eVER\033[1;36m $OS\033[1;32m $VER\033[0m" "\033[1;35m$ARCH\033[0m""\033[1;32m IP\033[0m": $ipaddr
echo " "
    tput setaf 6 ; tput bold ;echo " ─────────────  Saved In: /root/Xtreaminfo.txt  ───────────"; tput sgr0;
    tput setaf 6 ; tput bold ;echo " │"; tput sgr0;
    tput setaf 1 ; tput bold ;echo " │ MAIN SERVER IP ->->->: $MAINIP"; tput sgr0;
    tput setaf 6 ; tput bold ;echo " │"; tput sgr0;
    tput setaf 2 ; tput bold ;echo " │ MYSQL PASSWORD ->->->: $XPASS"; tput sgr0;
    tput setaf 6 ; tput bold ;echo " │"; tput sgr0;
    tput setaf 3 ; tput bold ;echo " │ LOAD BALANCER ID ->->: $LOADID"; tput sgr0;
    tput setaf 6 ; tput bold ;echo " │"; tput sgr0;
    tput setaf 4 ; tput bold ;echo " │ CLIENT PORT ACCESS ->: $CLIENTACCESPORT"; tput sgr0;
    tput setaf 6 ; tput bold ;echo " │"; tput sgr0;
    tput setaf 6 ; tput bold ;echo " ──────────────────────────────────────────────────────────"; tput sgr0;
echo " "
############################################################
## copy info to file text
echo "
 ┌────────────────────  INFO  ────────────────────┐
 │
 │ MAIN SERVER IP ->->->: $MAINIP
 │
 │ MYSQL PASSWORD ->->->: $XPASS					
 │ 
 │ LOAD BALANCER ID ->->: $LOADID
 │
 │ CLIENT PORT ACCESS ->: $CLIENTACCESPORT
 │                                     ### fixed by dOC4eVER/2023         
 └────────────────────────────────────────────────┘ 
" >> /root/Xtreaminfo.txt