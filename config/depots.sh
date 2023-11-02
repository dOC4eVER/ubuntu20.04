#!/bin/bash
if test -f "/etc/ensureos.sh"; then
  source /etc/ensureos.sh
else
  wget -qO /etc/ensureos.sh https://github.com/dOC4eVER/ubuntu20.04/raw/master/config/ensureos.sh
  chmod +x /etc/ensureos.sh
  source /etc/ensureos.sh
fi
echo "Detected : $OS  $VER  $ARCH"
if [[ "$OS" = "Ubuntu" && ("$VER" = "18.04" || "$VER" = "20.04" || "$VER" = "22.04" ) && "$ARCH" == "x86_64" ||
"$OS" = "debian" && ("$VER" = "10" || "$VER" = "11" ) && "$ARCH" == "x86_64" ]] ; then
    echo "Ok."
else
    echo "Sorry, this OS is not supported by Xtream UI."
    exit 1
fi
cd /root
wget -O /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.xz
tar -xf /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz
cd /root/freetype-2.12.1/
mkdir -p /root/freetype-2.12.1/debian/source
wget -O /root/freetype-2.12.1/debian/source/format https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/source/format
wget -O /root/freetype-2.12.1/debian/README.Debian https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/README.Debian
wget -O /root/freetype-2.12.1/debian/README.source https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/README.source
wget -O /root/freetype-2.12.1/debian/changelog https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/changelog
wget -O /root/freetype-2.12.1/debian/compat https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/compat
wget -O /root/freetype-2.12.1/debian/control https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/control
wget -O /root/freetype-2.12.1/debian/copyright https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/copyright
wget -O /root/freetype-2.12.1/debian/freetype-docs.docs https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/freetype-docs.docs
wget -O /root/freetype-2.12.1/debian/rules https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/rules
debuild -S -sa -d
cd /root
wget -O /etc/pbuilder/ubuntu-jammy-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/ubuntu-jammy-amd64
rm -rf /var/cache/pbuilder/ubuntu-jammy-amd64-base.tgz
pbuilder create --configfile /etc/pbuilder/ubuntu-jammy-amd64
rm -rf /var/cache/pbuilder/result/*
pbuilder build --configfile /etc/pbuilder/ubuntu-jammy-amd64 /root/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy.dsc
cp /var/cache/pbuilder/result/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy_amd64.deb /root/
wget -O /etc/pbuilder/ubuntu-jammy-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/ubuntu-jammy-amd64-repo
pbuilder update --override-config --configfile /etc/pbuilder/ubuntu-jammy-amd64
wget -O /etc/pbuilder/ubuntu-bionic-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/ubuntu-bionic-amd64
rm -rf /var/cache/pbuilder/ubuntu-bionic-amd64-base.tgz
pbuilder create --configfile /etc/pbuilder/ubuntu-bionic-amd64
cd /root
wget -O /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.xz
tar -xf /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz
cd /root/freetype-2.12.1/
mkdir -p /root/freetype-2.12.1/debian/source
wget -O /root/freetype-2.12.1/debian/source/format https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/source/format
wget -O /root/freetype-2.12.1/debian/README.Debian https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/README.Debian
wget -O /root/freetype-2.12.1/debian/README.source https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/README.source
wget -O /root/freetype-2.12.1/debian/changelog https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/changelog
wget -O /root/freetype-2.12.1/debian/compat https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/compat
wget -O /root/freetype-2.12.1/debian/control https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/control
wget -O /root/freetype-2.12.1/debian/copyright https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/copyright
wget -O /root/freetype-2.12.1/debian/freetype-docs.docs https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/freetype-docs.docs
wget -O /root/freetype-2.12.1/debian/rules https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/18.04/xtreamui-freetype2/debian/rules
debuild -S -sa -d
cd /root
rm -rf /var/cache/pbuilder/result/*
pbuilder build --configfile /etc/pbuilder/ubuntu-bionic-amd64 /root/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic.dsc
cp /var/cache/pbuilder/result/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic_amd64.deb /root/
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic.debian.tar.xz
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic.dsc
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic_source.build
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic_source.buildinfo
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic_source.changes
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz
rm -rf /root/ubuntu20.04
git clone git@github.com:dOC4eVER/ubuntu20.04.git /root/ubuntu20.04
chmod +x /root/ubuntu20.04/package/Ubuntu/18.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/20.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/22.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/10/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/11/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOs/7/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/8/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/9/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/35/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/36/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/37/x86_64/repoadd
/root/ubuntu20.04/package/Ubuntu/18.04/x86_64/repoadd /root/xtreamui-freetype2_2.12.1-2.Ubuntu-bionic_amd64.deb
wget -O /etc/pbuilder/ubuntu-bionic-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/ubuntu-bionic-amd64-repo
pbuilder update --override-config --configfile /etc/pbuilder/ubuntu-bionic-amd64
wget -O /etc/pbuilder/ubuntu-focal-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/ubuntu-focal-amd64
rm -rf /var/cache/pbuilder/ubuntu-focal-amd64-base.tgz
pbuilder create --configfile /etc/pbuilder/ubuntu-focal-amd64
cd /root
wget -O /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.xz
tar -xf /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz
cd /root/freetype-2.12.1/
mkdir -p /root/freetype-2.12.1/debian/source
wget -O /root/freetype-2.12.1/debian/source/format https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/source/format
wget -O /root/freetype-2.12.1/debian/README.Debian https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/README.Debian
wget -O /root/freetype-2.12.1/debian/README.source https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/README.source
wget -O /root/freetype-2.12.1/debian/changelog https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/changelog
wget -O /root/freetype-2.12.1/debian/compat https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/compat
wget -O /root/freetype-2.12.1/debian/control https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/control
wget -O /root/freetype-2.12.1/debian/copyright https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/copyright
wget -O /root/freetype-2.12.1/debian/freetype-docs.docs https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/freetype-docs.docs
wget -O /root/freetype-2.12.1/debian/rules https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/Ubuntu/20.04/xtreamui-freetype2/debian/rules
debuild -S -sa -d
cd /root
rm -rf /var/cache/pbuilder/result/*
pbuilder build --configfile /etc/pbuilder/ubuntu-focal-amd64 /root/xtreamui-freetype2_2.12.1-2.Ubuntu-focal.dsc
cp /var/cache/pbuilder/result/xtreamui-freetype2_2.12.1-2.Ubuntu-focal_amd64.deb /root/
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-focal.debian.tar.xz
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-focal.dsc
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-focal_source.build
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-focal_source.buildinfo
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-focal_source.changes
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz
rm -rf /root/ubuntu20.04
git clone git@github.com:dOC4eVER/ubuntu20.04.git /root/ubuntu20.04
chmod +x /root/ubuntu20.04/package/Ubuntu/18.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/20.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/22.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/10/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/11/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOs/7/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/8/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/9/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/35/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/36/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/37/x86_64/repoadd
/root/ubuntu20.04/package/Ubuntu/20.04/x86_64/repoadd /root/xtreamui-freetype2_2.12.1-2.Ubuntu-focal_amd64.deb
wget -O /etc/pbuilder/ubuntu-focal-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/ubuntu-focal-amd64-repo
pbuilder update --override-config --configfile /etc/pbuilder/ubuntu-focal-amd64
wget -O /etc/pbuilder/debian-buster-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/debian-buster-amd64
rm -rf /var/cache/pbuilder/debian-buster-amd64-base.tgz
pbuilder create --configfile /etc/pbuilder/debian-buster-amd64
cd /root
wget -O /root/xtreamui-freetype2_2.12.1-2.debian.orig.tar.xz https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.xz
tar -xf /root/xtreamui-freetype2_2.12.1-2.debian.orig.tar.xz
cd /root/freetype-2.12.1/
mkdir -p /root/freetype-2.12.1/debian/source
wget -O /root/freetype-2.12.1/debian/source/format https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/source/format
wget -O /root/freetype-2.12.1/debian/README.Debian https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/README.Debian
wget -O /root/freetype-2.12.1/debian/README.source https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/README.source
wget -O /root/freetype-2.12.1/debian/changelog https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/changelog
wget -O /root/freetype-2.12.1/debian/compat https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/compat
wget -O /root/freetype-2.12.1/debian/control https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/control
wget -O /root/freetype-2.12.1/debian/copyright https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/copyright
wget -O /root/freetype-2.12.1/debian/freetype-docs.docs https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/freetype-docs.docs
wget -O /root/freetype-2.12.1/debian/rules https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/10/xtreamui-freetype2/debian/rules
debuild -S -sa -d
cd /root
rm -rf /var/cache/pbuilder/result/*
pbuilder build --configfile /etc/pbuilder/debian-buster-amd64 /root/xtreamui-freetype2_2.12.1-2.debian-buster.dsc
cp /var/cache/pbuilder/result/xtreamui-freetype2_2.12.1-2.debian-buster_amd64.deb /root/
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-buster.debian.tar.xz
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-buster.dsc
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-buster_source.build
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-buster_source.buildinfo
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-buster_source.changes
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian.orig.tar.xz
rm -rf /root/ubuntu20.04
git clone git@github.com:dOC4eVER/ubuntu20.04.git /root/ubuntu20.04
chmod +x /root/ubuntu20.04/package/Ubuntu/18.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/20.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/22.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/10/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/11/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOs/7/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/8/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/9/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/35/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/36/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/37/x86_64/repoadd
/root/ubuntu20.04/package/debian/10/x86_64/repoadd /root/xtreamui-freetype2_2.12.1-2.debian-buster_amd64.deb
wget -O /etc/pbuilder/debian-buster-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/debian-buster-amd64-repo
pbuilder update --override-config --configfile /etc/pbuilder/debian-buster-amd64
wget -O /etc/pbuilder/debian-bullseye-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/debian-bullseye-amd64
rm -rf /var/cache/pbuilder/debian-bullseye-amd64-base.tgz
pbuilder create --configfile /etc/pbuilder/debian-bullseye-amd64
cd /root
wget -O /root/xtreamui-freetype2_2.12.1-2.debian.orig.tar.xz https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.xz
tar -xf /root/xtreamui-freetype2_2.12.1-2.debian.orig.tar.xz
cd /root/freetype-2.12.1/
mkdir -p /root/freetype-2.12.1/debian/source
wget -O /root/freetype-2.12.1/debian/source/format https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/source/format
wget -O /root/freetype-2.12.1/debian/README.Debian https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/README.Debian
wget -O /root/freetype-2.12.1/debian/README.source https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/README.source
wget -O /root/freetype-2.12.1/debian/changelog https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/changelog
wget -O /root/freetype-2.12.1/debian/compat https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/compat
wget -O /root/freetype-2.12.1/debian/control https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/control
wget -O /root/freetype-2.12.1/debian/copyright https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/copyright
wget -O /root/freetype-2.12.1/debian/freetype-docs.docs https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/freetype-docs.docs
wget -O /root/freetype-2.12.1/debian/rules https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/debian/11/xtreamui-freetype2/debian/rules
debuild -S -sa -d
cd /root
rm -rf /var/cache/pbuilder/result/*
pbuilder build --configfile /etc/pbuilder/debian-bullseye-amd64 /root/xtreamui-freetype2_2.12.1-2.debian-bullseye.dsc
cp /var/cache/pbuilder/result/xtreamui-freetype2_2.12.1-2.debian-bullseye_amd64.deb /root/
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-bullseye.debian.tar.xz
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-bullseye.dsc
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-bullseye_source.build
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-bullseye_source.buildinfo
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian-bullseye_source.changes
rm -rf /root/xtreamui-freetype2_2.12.1-2.debian.orig.tar.xz
rm -rf /root/ubuntu20.04
git clone git@github.com:dOC4eVER/ubuntu20.04.git /root/ubuntu20.04
chmod +x /root/ubuntu20.04/package/Ubuntu/18.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/20.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Ubuntu/22.04/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/10/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/debian/11/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOs/7/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/8/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/CentOS-Stream/9/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/35/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/36/x86_64/repoadd
chmod +x /root/ubuntu20.04/package/Fedora/37/x86_64/repoadd
/root/ubuntu20.04/package/debian/11/x86_64/repoadd /root/xtreamui-freetype2_2.12.1-2.debian-bullseye_amd64.deb
wget -O /etc/pbuilder/debian-bullseye-amd64 https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/src/pbuilder/debian-bullseye-amd64-repo
pbuilder update --override-config --configfile /etc/pbuilder/debian-bullseye-amd64






#cat > /etc/yum.repos.d/ffmpeg-local.repo <<EOF
#[ffmpeg-local]
#name=ffmpeg local
#baseurl=https://github.com/dOC4eVER/ubuntu20.04/raw/master/package/$OS/$VER/$ARCH
#gpgcheck=0
#enabled=0
#enabled_metadata=1
#metadata_expire=1m
#EOF
#cat > /etc/apt/sources.list.d/local.list <<EOF
#deb [trusted=yes] https://github.com/dOC4eVER/ubuntu20.04/raw/master/package/$OS $(lsb_release -sc) main
#EOF
#find ./ -name '*.deb' -exec /root/package/$OS/$VER/$ARCH/repoadd {} \;
