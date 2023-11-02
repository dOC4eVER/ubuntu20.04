#!/bin/bash
cd /root
mkdir -p /root/deb/
wget -O /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.xz
tar -xf /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz
cd /root/freetype-2.12.1/
mkdir -p /root/freetype-2.12.1/debian/source
wget -O /root/freetype-2.12.1/debian/source/format https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/source/format
wget -O /root/freetype-2.12.1/debian/README.Debian https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/README.Debian
wget -O /root/freetype-2.12.1/debian/README.source https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/README.source
wget -O /root/freetype-2.12.1/debian/changelog https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/changelog
wget -O /root/freetype-2.12.1/debian/compat https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/compat
wget -O /root/freetype-2.12.1/debian/control https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/control
wget -O /root/freetype-2.12.1/debian/copyright https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/copyright
wget -O /root/freetype-2.12.1/debian/freetype-docs.docs https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/freetype-docs.docs
wget -O /root/freetype-2.12.1/debian/rules https://github.com/amidevous/xtream-ui-ubuntu20.04/raw/master/ubuntu/src/Ubuntu/22.04/xtreamui-freetype2/debian/rules
debuild -S -sa -d
cd /root
pbuilder build --configfile /etc/pbuilder/ubuntu-jammy-amd64 /root/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy.dsc
cp /var/cache/pbuilder/result/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy_amd64.deb /root/deb/
rm -rf /root/freetype-2.12.1 /root/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy.debian.tar.xz /root/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy.dsc /root/xtreamui-freetype2_2.12.1-2.Ubuntu.orig.tar.xz
rm -rf /root/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy_source.build xtreamui-freetype2_2.12.1-2.Ubuntu-jammy_source.buildinfo xtreamui-freetype2_2.12.1-2.Ubuntu-jammy_source.changes
