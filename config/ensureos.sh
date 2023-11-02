#!/bin/bash
echo -e "\nChecking that minimal requirements are ok"
# Ensure the OS is compatible with the launcher
if [ -f /etc/centos-release ]; then
    inst() {
       rpm -q --queryformat '%{Version}-%{Release}' "$1"
    } 
    if (inst "centos-stream-repos"); then
    OS="CentOS-Stream"
    else
    OS="CentOs"
    fi    
    VERFULL=$(sed 's/^.*release //;s/ (Fin.*$//' /etc/centos-release) VER=${VERFULL:0:1} # return 6, 7, 8, 9 etc
elif [ -f /etc/fedora-release ]; then
    inst() {
       rpm -q --queryformat '%{Version}-%{Release}' "$1"
    } 
    OS="Fedora" VERFULL=$(sed 's/^.*release //;s/ (Fin.*$//' /etc/fedora-release) VER=${VERFULL:0:2} # return 34, 35, 36,37 etc
elif [ -f /etc/lsb-release ]; then
    OS=$(grep DISTRIB_ID /etc/lsb-release | sed 's/^.*=//') VER=$(grep DISTRIB_RELEASE /etc/lsb-release | sed 's/^.*=//')
	inst() {
       dpkg-query --showformat='${Version}' --show "$1"
    }
elif [ -f /etc/os-release ]; then
    OS=$(grep -w ID /etc/os-release | sed 's/^.*=//') VER=$(grep VERSION_ID /etc/os-release | sed 's/^.*"\(.*\)"/\1/' | head -n 1 | tail -n 1)
 else
    OS=$(uname -s) VER=$(uname -r)
fi
ARCH=$(uname -m)
if [[ "$OS" = "CentOs" || "$OS" = "CentOS-Stream" ]]; then
dist=el$VER
pack=rpm
elif [[ "$OS" = "Fedora" ]]; then
dist=fc$VER
pack=rpm
elif [[ "$OS" = "Ubuntu" ]]; then
dist=Ubuntu-$(lsb_release -sc)
pack=debian
elif [[ "$OS" = "debian" ]]; then
dist=debian-$(lsb_release -sc)
pack=debian
fi
if [[ "$OS" = "CentOs" ]] ; then
    PACKAGE_INSTALLER="yum -y install" PACKAGE_INSTALLER_LOCAL="yum -y --enablerepo ffmpeg-local install" PACKAGE_BININSTALLER="rpm -i"
	PACKAGE_REMOVER="yum -y remove" PACKAGE_UPDATER="yum -y update" PACKAGE_UPDGRADER="yum -y  upgrade" PACKAGE_UTILS="yum-utils"
    PACKAGE_GROUPINSTALL="yum -y groupinstall" PACKAGE_SOURCEDOWNLOAD="yumdownloader --source"
    PACKAGE_BUILDDEP="yum-builddep -y"
elif [[ "$OS" = "Fedora" || "$OS" = "CentOS-Stream"  ]]; then
    PACKAGE_INSTALLER="dnf -y install" PACKAGE_INSTALLER_LOCAL="dnf -y --enablerepo ffmpeg-local install"
	PACKAGE_BININSTALLER="rpm -i" PACKAGE_REMOVER="dnf -y remove"
    PACKAGE_UPDATER="dnf -y update" PACKAGE_UPDGRADER="dnf -y upgrade" PACKAGE_UTILS="dnf-utils"
    PACKAGE_GROUPINSTALL="dnf -y groupinstall"PACKAGE_SOURCEDOWNLOAD="dnf download --source"
    PACKAGE_BUILDDEP="dnf build-dep -y"
elif [[ "$OS" = "Ubuntu" || "$OS" = "debian" ]]; then
    PACKAGE_INSTALLER="apt-get -y install" PACKAGE_INSTALLER_LOCAL="apt-get -y install" PACKAGE_BININSTALLER="dpkg -i" 
	PACKAGE_REMOVER="apt-get -y purge" PACKAGE_UPDATER="apt-get -y update" PACKAGE_UPDGRADER="apt-get -y dist-upgrade"
	PACKAGE_SOURCEDOWNLOAD="apt-get -y source" PACKAGE_BUILDDEP="apt-get -y build-dep"
fi
