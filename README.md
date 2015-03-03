Varnish-Cache-boilerplate
=====================
A personal boilerplate for setting up Varnish Cache.

# Installation Steps

Step 1 - Install Core Essentials:  
--------------------
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y install build-essential git  

Step 2 - Install Varnish (Ubuntu/14.04 Trusty Tahr)
---------------------------------------
    sudo apt-get -y install apt-transport-https
    curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
    echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list
    sudo apt-get -y update
    sudo apt-get -y install varnish libvarnish-dev


