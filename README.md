# Xtream UI for Ubuntu 18.04 20.04 22.04 Debian 10 11 CentOS 8 Fedora 34 35 36 install



### If you install on ubuntu 18.04 there is the old command only on ubuntu 18.04
    https://github.com/dOC4eVER/ubuntu20.04



### New installation the Xtream UI on Ubuntu 18.04/20.04/22.04 Debian 10/11 CentOS 8 Fedora 34/35/36

    wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/install.sh -O /tmp/install.sh && bash /tmp/install.sh



### To upgrade an existing Panel only, with a backup of the /admin & /pytools directories in *.old in case you want to go back
 
    wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/Update_dOC4eVER.sh -O /tmp/Update_dOC4eVER.sh && bash /tmp/Update_dOC4eVER.sh



### Restore the old Panel and delete the "old" directory

    wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/Downgrade_old_panel.sh -O /tmp/Downgrade_old_panel.sh && bash /tmp/Downgrade_old_panel.sh
    



### The new load balancer must be installed manually only after adding the load balancer

    wget https://github.com/dOC4eVER/ubuntu20.04/raw/master/sub_install.sh -O /tmp/sub_install.sh && bash /tmp/sub_install.sh

### if error

sudo: /home/xtreamcodes/iptv_xtream_codes/php/bin/php: command not found

full binary rebuild require

    wget https://github.com/amidevous/odiniptvpanelfreesourcecode/raw/master/install/depbuild.sh -O /root/depbuild.sh
    bash /root/depbuild.sh wget https://github.com/amidevous/odiniptvpanelfreesourcecode/raw/master/install/php7.2rebuild.sh -O /root/php7.2rebuild.sh
    bash /root/php7.2rebuild.sh /home/xtreamcodes/iptv_xtream_codes/start_services.sh

### if nginx and nginx_rtmp error minimal rebuild require

    wget https://github.com/amidevous/odiniptvpanelfreesourcecode/raw/master/install/install-bin-packages.sh -O /root/install-bin-packages.sh
    bash /root/install-bin-packages.sh /home/xtreamcodes/iptv_xtream_codes/start_services.sh 
   
   * (dOC4eVER) 2023
