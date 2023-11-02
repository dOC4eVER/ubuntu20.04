#!/bin/bash
# wget --no-check-certificate -qO- https://github.com/dOC4eVER/ubuntu20.04/raw/master/phpbuild.sh | bash -s
if [ -f "/home/xtreamcodes/iptv_xtream_codes/php-7.4.33" ]; then
    echo "update exists."
else
echo -e "\nChecking that minimal requirements are ok"

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
#wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/install-dep.sh -O /root/depbuild.sh && bash /root/install-dep.sh
if [[ "$OS" = "CentOs" && "$VER" = "6" && "$ARCH" == "x86_64" ]] ; then
/opt/rh/devtoolset-9/enable
source /opt/rh/devtoolset-9/enable
fi
cd /root
rm -rf /root/phpbuild/
mkdir -p /root/phpbuild/
cd /root/phpbuild/
rm -rf /root/phpbuild/ngx_http_geoip2_module
rm -rf /root/phpbuild/nginx-1.24.0
rm -rf /root/phpbuild/openssl-OpenSSL_1_1_1h
wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1h.tar.gz -O /root/phpbuild/OpenSSL_1_1_1h.tar.gz
tar -xzvf OpenSSL_1_1_1h.tar.gz
wget http://nginx.org/download/nginx-1.24.0.tar.gz -O /root/phpbuild/nginx-1.24.0.tar.gz
tar -xzvf nginx-1.24.0.tar.gz
git clone https://github.com/leev/ngx_http_geoip2_module.git /root/phpbuild/ngx_http_geoip2_module
rm -rf /root/phpbuild/v1.2.2.zip
rm -rf /root/phpbuild/nginx-rtmp-module-1.2.2
wget https://github.com/arut/nginx-rtmp-module/archive/v1.2.2.zip -O /root/phpbuild/v1.2.2.zip
unzip /root/phpbuild/v1.2.2.zip
cd /root/phpbuild/nginx-1.24.0
if [ -f "/usr/bin/dpkg-buildflags" ]; then
    configureend="--with-openssl=/root/phpbuild/openssl-OpenSSL_1_1_1h --with-ld-opt='$(dpkg-buildflags --get LDFLAGS)' --with-cc-opt='$(dpkg-buildflags --get CFLAGS)'"
elif [ -f "/usr/bin/rpm" ]; then
    configureend="--with-openssl=/root/phpbuild/openssl-OpenSSL_1_1_1h --with-cc-opt='$(rpm --eval %{build_ldflags})' --with-cc-opt='$(rpm --eval %{optflags})'"
else 
    configureend="--with-openssl=/root/phpbuild/openssl-OpenSSL_1_1_1h"
fi
./configure --prefix=/home/xtreamcodes/iptv_xtream_codes/nginx/ \
--http-client-body-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/client_temp \
--http-proxy-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/proxy_temp \
--http-fastcgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/fastcgi_temp \
--lock-path=/home/xtreamcodes/iptv_xtream_codes/tmp/nginx.lock \
--http-uwsgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/uwsgi_temp \
--http-scgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/scgi_temp \
--conf-path=/home/xtreamcodes/iptv_xtream_codes/nginx/conf/nginx.conf \
--error-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/error.log \
--http-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/access.log \
--pid-path=/home/xtreamcodes/iptv_xtream_codes/nginx/nginx.pid \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_v2_module \
--with-pcre \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-threads \
--with-mail \
--with-mail_ssl_module \
--with-file-aio \
--with-cpu-opt=generic \
--add-module=/root/phpbuild/ngx_http_geoip2_module \
"$configureend"
make -j$(nproc --all)
mkdir -p "/home/xtreamcodes/iptv_xtream_codes/nginx/"
mkdir -p "/home/xtreamcodes/iptv_xtream_codes/nginx/sbin/"
mkdir -p "/home/xtreamcodes/iptv_xtream_codes/nginx/modules"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/nginx/conf"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/logs/"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/client_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/proxy_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/fastcgi_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/uwsgi_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/scgi_temp"
killall nginx
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
killall nginx
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
killall nginx
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
rm -f /home/xtreamcodes/iptv_xtream_codes/nginx/sbin/nginx
cp /root/phpbuild/nginx-1.24.0/objs/nginx /home/xtreamcodes/iptv_xtream_codes/nginx/sbin/
if [ ! -f "/home/xtreamcodes/iptv_xtream_codes/nginx/sbin/nginx" ]; then
    echo "nginx build error"
    exit 0
fi
cd /root/phpbuild/
rm -rf /root/phpbuild/ngx_http_geoip2_module
rm -rf /root/phpbuild/nginx-1.24.0
rm -rf /root/phpbuild/openssl-OpenSSL_1_1_1h
wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1h.tar.gz -O /root/phpbuild/OpenSSL_1_1_1h.tar.gz
tar -xzvf OpenSSL_1_1_1h.tar.gz
wget http://nginx.org/download/nginx-1.24.0.tar.gz -O /root/phpbuild/nginx-1.24.0.tar.gz
tar -xzvf nginx-1.24.0.tar.gz
git clone https://github.com/leev/ngx_http_geoip2_module.git /root/phpbuild/ngx_http_geoip2_module
rm -rf /root/phpbuild/v1.2.2.zip
rm -rf /root/phpbuild/nginx-rtmp-module-1.2.2
wget https://github.com/arut/nginx-rtmp-module/archive/v1.2.2.zip -O /root/phpbuild/v1.2.2.zip
unzip /root/phpbuild/v1.2.2.zip
cd /root/phpbuild/nginx-1.24.0
./configure --prefix=/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/ \
--http-client-body-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/client_temp \
--http-proxy-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/proxy_temp \
--http-fastcgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/fastcgi_temp \
--lock-path=/home/xtreamcodes/iptv_xtream_codes/tmp/nginx.lock \
--http-uwsgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/uwsgi_temp \
--http-scgi-temp-path=/home/xtreamcodes/iptv_xtream_codes/tmp/scgi_temp \
--conf-path=/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/conf/nginx.conf \
--error-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/rtmp_error.log \
--http-log-path=/home/xtreamcodes/iptv_xtream_codes/logs/rtmp_access.log \
--pid-path=/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/nginx.pid \
--add-module=/root/phpbuild/nginx-rtmp-module-1.2.2 \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_v2_module \
--with-pcre \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-threads \
--with-mail \
--with-mail_ssl_module \
--with-file-aio \
--with-cpu-opt=generic \
--without-http_rewrite_module \
--add-module=/root/phpbuild/ngx_http_geoip2_module \
"$configureend"
make -j$(nproc --all)
mkdir -p "/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/"
mkdir -p "/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/"
mkdir -p "/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/modules"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/conf"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/logs/"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/client_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/proxy_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/fastcgi_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/uwsgi_temp"
mkdir -p  "/home/xtreamcodes/iptv_xtream_codes/tmp/scgi_temp"
killall nginx_rtmp
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
killall nginx_rtmp
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
killall nginx_rtmp
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
rm -f /home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/nginx_rtmp
mv /root/phpbuild/nginx-1.24.0/objs/nginx /root/phpbuild/nginx-1.24.0/objs/nginx_rtmp
cp /root/phpbuild/nginx-1.24.0/objs/nginx_rtmp /home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/
if [ ! -f "/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/nginx_rtmp" ]; then
    tput setaf 1 ; tput bold ;echo "nginx_rtmp build error"; tput sgr0;    
echo ""	
    exit 0
fi
cd /root/phpbuild/
wget --no-check-certificate https://www.php.net/distributions/php-7.4.33.tar.gz -O /root/phpbuild/php-7.4.33.tar.gz
rm -rf /root/phpbuild/php-7.4.33
tar -xvf /root/phpbuild/php-7.4.33.tar.gz
if [[ "$VER" = "18.04" || "$VER" = "20.04" || "$VER" = "22.04" || "$VER" = "11" || "$VER" = "37" || "$VER" = "38" ]]; then
wget --no-check-certificate "https://launchpad.net/~ondrej/+archive/ubuntu/php/+sourcefiles/php7.3/7.3.33-2+ubuntu22.04.1+deb.sury.org+1/php7.3_7.3.33-2+ubuntu22.04.1+deb.sury.org+1.debian.tar.xz" -O /root/phpbuild/debian.tar.xz
tar -xf /root/phpbuild/debian.tar.xz
rm -f /root/phpbuild/debian.tar.xz
cd /root/phpbuild/php-7.4.33
patch -p1 < ../debian/patches/0060-Add-minimal-OpenSSL-3.0-patch.patch
else
cd /root/phpbuild/php-7.4.33
fi
cd /root/phpbuild/
#if [[ "$OS" = "debian"  ]] ; then
#rm -f "/etc/apt/sources.list.d/alvistack.list"
#echo "deb http://download.opensuse.org/repositories/home:/alvistack/Debian_${VER}/ /" | tee "/etc/apt/sources.list.d/alvistack.list"
#wget --no-check-certificate -qO- "http://download.opensuse.org/repositories/home:/alvistack/Debian_${VER}/Release.key" | gpg --dearmor | tee /etc/apt/trusted.gpg.d/alvistack.gpg > /dev/null
#fi
wget --no-check-certificate https://download.savannah.gnu.org/releases/freetype/freetype-2.13.0.tar.gz -O /root/phpbuild/freetype-2.13.0.tar.gz
tar -xvf /root/phpbuild/freetype-2.13.0.tar.gz
cd /root/phpbuild/freetype-2.13.0
./autogen.sh
./configure --enable-freetype-config --prefix=/home/xtreamcodes/iptv_xtream_codes/freetype2
make -j$(nproc --all)
make install
if [ ! -f "/home/xtreamcodes/iptv_xtream_codes/freetype2/bin/freetype-config" ]; then
    echo "freetype build error"
    exit 0
fi
cd /root/phpbuild/php-7.4.33
'./configure'  '--prefix=/home/xtreamcodes/iptv_xtream_codes/php' '--with-zlib-dir' '--with-freetype-dir=/home/xtreamcodes/iptv_xtream_codes/freetype2' '--enable-mbstring' '--enable-calendar' '--with-curl' '--with-gd' '--disable-rpath' '--enable-inline-optimization' '--with-bz2' '--with-zlib' '--enable-sockets' '--enable-sysvsem' '--enable-sysvshm' '--enable-pcntl' '--enable-mbregex' '--enable-exif' '--enable-bcmath' '--with-mhash' '--enable-zip' '--with-pcre-regex' '--with-pdo-mysql=mysqlnd' '--with-mysqli=mysqlnd' '--with-openssl' '--with-fpm-user=xtreamcodes' '--with-fpm-group=xtreamcodes' '--with-libdir=/lib/x86_64-linux-gnu' '--with-gettext' '--with-xmlrpc' '--with-xsl' '--enable-opcache' '--enable-fpm' '--enable-libxml' '--enable-static' '--disable-shared' '--with-jpeg-dir' '--enable-gd-jis-conv' '--with-webp-dir' '--with-xpm-dir'
make -j$(nproc --all)
killall php
killall php-fpm
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
killall php
killall php-fpm
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
killall php
killall php-fpm
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
rm -rf /home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/
make install
if [ ! -f "/home/xtreamcodes/iptv_xtream_codes/php/bin/php" ]; then
    tput setaf 1 ; tput bold ;echo "php build error"; tput sgr0;    
echo ""	
    exit 0
fi
cd /root/phpbuild
wget --no-check-certificate -O /root/phpbuild/mcrypt-1.0.5.tgz https://pecl.php.net/get/mcrypt-1.0.5.tgz
tar -xvf /root/phpbuild/mcrypt-1.0.5.tgz
cd /root/phpbuild/mcrypt-1.0.5
/home/xtreamcodes/iptv_xtream_codes/php/bin/phpize
./configure --with-php-config=/home/xtreamcodes/iptv_xtream_codes/php/bin/php-config
make -j$(nproc --all)
make install
if [ ! -f "/home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20190902/mcrypt.so" ]; then
    tput setaf 1 ; tput bold ;echo "php-mcrypt build error"; tput sgr0;    
echo ""	
    exit 0
fi
cd /root/phpbuild/
wget --no-check-certificate -O /root/phpbuild/geoip-1.1.1.tgz https://pecl.php.net/get/geoip-1.1.1.tgz
tar -xvf /root/phpbuild/geoip-1.1.1.tgz
cd /root/phpbuild/geoip-1.1.1
/home/xtreamcodes/iptv_xtream_codes/php/bin/phpize
./configure --with-php-config=/home/xtreamcodes/iptv_xtream_codes/php/bin/php-config
make -j$(nproc --all)
make install
if [ ! -f "/home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20190902/geoip.so" ]; then
    tput setaf 1 ; tput bold ;echo "php-mcrypt build error"; tput sgr0;    
echo ""	
    exit 0
fi
cd /root/phpbuild/
mkdir -p /home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20190902/
wget --no-check-certificate -O /root/phpbuild/ioncube_loaders_lin_x86-64.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar -xvf /root/phpbuild/ioncube_loaders_lin_x86-64.tar.gz
rm -f /root/phpbuild/ioncube_loaders_lin_x86-64.tar.gz
rm -rf /home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_*.so
mv /root/phpbuild/ioncube/ioncube_loader_lin_7.4.so /root/phpbuild/ioncube/ioncube.so
cp /root/phpbuild/ioncube/ioncube.so /home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20190902/
rm -rf /root/phpbuild/ioncube
chmod 777 /home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20190902/ioncube.so
if [ ! -f "/home/xtreamcodes/iptv_xtream_codes/php/lib/php/extensions/no-debug-non-zts-20190902/ioncube.so" ]; then
    echo "ioncube install error"
    exit 0
fi
cd /root
wget --no-check-certificate https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/php.ini -O /home/xtreamcodes/iptv_xtream_codes/php/lib/php.ini
cd /root
rm -rf /root/phpbuild/
mkdir -p /home/xtreamcodes/iptv_xtream_codes/bin/
cd /home/xtreamcodes/iptv_xtream_codes/bin/
wget https://bitbucket.org/emre1393/xtreamui_mirror/downloads/ffmpeg_v5.0.1_amd64.zip -O /home/xtreamcodes/iptv_xtream_codes/bin/ffmpeg_v5.0.1_amd64.zip
rm -f /home/xtreamcodes/iptv_xtream_codes/bin/ffmpeg
rm -f /home/xtreamcodes/iptv_xtream_codes/bin/ffprobe
unzip /home/xtreamcodes/iptv_xtream_codes/bin/ffmpeg_v5.0.1_amd64.zip
rm -f /home/xtreamcodes/iptv_xtream_codes/bin/ffmpeg_v5.0.1_amd64.zip
cd /root
rm -rf /root/phpbuild/
sudo rm -rf /tmp/update/
mkdir -p /tmp/update/
wget "https://github.com/dOC4eVER/ubuntu20.04/releases/download/start/update.zip" -O /tmp/update/update.zip
unzip /tmp/update/update.zip -d /tmp/update/
rm -f /tmp/update/update.zip
sudo cp -rf /tmp/update/XtreamUI-master/admin/* /home/xtreamcodes/iptv_xtream_codes/admin/
sudo cp /tmp/update/XtreamUI-master/permissions.sh /home/xtreamcodes/iptv_xtream_codes/
sudo chmod +x /home/xtreamcodes/iptv_xtream_codes/permissions.sh
sudo rm -rf /home/xtreamcodes/iptv_xtream_codes/pytools/
sudo mkdir -p /home/xtreamcodes/iptv_xtream_codes/pytools/
sudo cp -rf /tmp/update/XtreamUI-master/pytools/* /home/xtreamcodes/iptv_xtream_codes/pytools/
rm -rf /tmp/update/XtreamUI-master
rm -rf /tmp/update
sudo chown -R xtreamcodes:xtreamcodes /home/xtreamcodes/
sudo chmod +x /home/xtreamcodes/iptv_xtream_codes/permissions.sh
sudo /home/xtreamcodes/iptv_xtream_codes/permissions.sh
sudo find /home/xtreamcodes/ -type d -not \( -name .update -prune \) -exec chmod -R 777 {} +
sudo wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/ubuntu/start_services.sh -O /home/xtreamcodes/iptv_xtream_codes/start_services.sh
sudo chmod +x /home/xtreamcodes/iptv_xtream_codes/start_services.sh
/home/xtreamcodes/iptv_xtream_codes/permissions.sh
/home/xtreamcodes/iptv_xtream_codes/start_services.sh
sudo bash -c "echo 1 > /home/xtreamcodes/iptv_xtream_codes/php-7.4.33"
fi
    tput setaf 2 ; tput bold ;echo "finish"; tput sgr0;


