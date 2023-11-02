#!/bin/bash
cd /root
#wget -O /root/xtreamui-php_7.4.33-1.Ubuntu.orig.tar.xz https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/xtreamui-php_7.4.33-1.Ubuntu.orig.tar.xz
wget -O /root/xtreamui-php_7.4.33-1.Ubuntu.orig.tar.xz https://www.php.net/distributions/php-7.4.33.tar.xz
tar -xvf /root/xtreamui-php_7.4.33-1.Ubuntu.orig.tar.xz
#mkdir -p /root/xtreamui-php_7.4.33-1.Ubuntu/
cd /root/php-7.4.33/
#tar -xf /root/xtreamui-php_7.4.33-1.Ubuntu.orig.tar.xz
mkdir -p /root/php-7.4.33/debian/source
mkdir -p /root/php-7.4.33/debian/patches
wget -O /root/php-7.4.33/debian/source/format https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/source/format
wget -O /root/php-7.4.33/debian/patches/0049-Add-minimal-OpenSSL-3.0-patch.patch https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/patches/0049-Add-minimal-OpenSSL-3.0-patch.patch
wget -O /root/php-7.4.33/debian/patches/series https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/patches/series
wget -O /root/php-7.4.33/debian/README.Debian https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/README.Debian
wget -O /root/php-7.4.33/debian/README.source https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/README.source
wget -O /root/php-7.4.33/debian/changelog https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/changelog
wget -O /root/php-7.4.33/debian/compat https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/compat
wget -O /root/php-7.4.33/debian/control https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/control
wget -O /root/php-7.4.33/debian/copyright https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/copyright
wget -O /root/php-7.4.33/debian/freetype-docs.docs https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/freetype-docs.docs
wget -O /root/php-7.4.33/debian/rules https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/debian/rules
debuild -S -sa -d
cd /root
apt-get -y install curl git make
git clone https://github.com/mcrapet/plowshare.git
cd plowshare
make install PREFIX=/usr
cd /root
rm -rf /root/plowshare
plowmod --install
plowmod --update
plowup 1fichier /root/xtreamui-php_7.4.33-1.Ubuntu-jammy.debian.tar.xz
plowup 1fichier /root/xtreamui-php_7.4.33-1.Ubuntu-jammy.dsc
plowup 1fichier /root/xtreamui-php_7.4.33-1.Ubuntu-jammy_source.build
plowup 1fichier /root/xtreamui-php_7.4.33-1.Ubuntu-jammy_source.buildinfo
plowup 1fichier /root/xtreamui-php_7.4.33-1.Ubuntu-jammy_source.changes
