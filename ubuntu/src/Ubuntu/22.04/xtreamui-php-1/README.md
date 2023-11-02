`cd $HOME`

`sudo yum -y remove rpmdevtools`

`sudo yum -y install devscripts pbuilder wget ca-certificates`

`sudo apt-get -y install pbuilder debhelper cdbs lintian build-essential fakeroot devscripts dh-make dput wget ca-certificates`

`sudo wget -O /etc/pbuilder/ubuntu-jammy-amd64 https://raw.githubusercontent.com/amidevous/xtream-ui-ubuntu20.04/master/ubuntu/src/pbuilder/ubuntu-jammy-amd64-xtreamui-php`

`sudo pbuilder create --configfile /etc/pbuilder/ubuntu-jammy-amd64`

`sudo pbuilder update --override-config --configfile /etc/pbuilder/ubuntu-jammy-amd64`

`sudo pbuilder login --configfile /etc/pbuilder/ubuntu-jammy-amd64`

`wget -O $HOME/build-php.sh https://raw.githubusercontent.com/amidevous/xtream-ui-ubuntu20.04/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/build.sh`

`bash $HOME/build-php.sh`

`rm -f $HOME/build-php.sh`

`exit`

`sudo wget -O /root/xtreamui-php_7.4.33-1.Ubuntu.orig.tar.xz https://www.php.net/distributions/php-7.4.33.tar.xz`

`sudo wget -O /root/xtreamui-php_7.4.33-1.Ubuntu-jammy.debian.tar.xz https://raw.githubusercontent.com/amidevous/xtream-ui-ubuntu20.04/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/xtreamui-php_7.4.33-1.Ubuntu-jammy.debian.tar.xz`

`sudo wget -O /root/xtreamui-php_7.4.33-1.Ubuntu-jammy.dsc https://raw.githubusercontent.com/amidevous/xtream-ui-ubuntu20.04/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/xtreamui-php_7.4.33-1.Ubuntu-jammy.dsc`

`sudo wget -O /root/xtreamui-php_7.4.33-1.Ubuntu-jammy_source.build https://raw.githubusercontent.com/amidevous/xtream-ui-ubuntu20.04/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/xtreamui-php_7.4.33-1.Ubuntu-jammy_source.build`

`sudo wget -O /root/xtreamui-php_7.4.33-1.Ubuntu-jammy_source.buildinfo https://raw.githubusercontent.com/amidevous/xtream-ui-ubuntu20.04/master/ubuntu/src/Ubuntu/22.04/xtreamui-php-1/xtreamui-php_7.4.33-1.Ubuntu-jammy_source.buildinfo`

`sudo pbuilder build --configfile /etc/pbuilder/ubuntu-jammy-amd64 /root/xtreamui-php_7.4.33-1.Ubuntu-jammy.dsc`

`cp /var/cache/pbuilder/result/xtreamui-freetype2_2.12.1-2.Ubuntu-jammy_amd64.deb /root/deb/`
