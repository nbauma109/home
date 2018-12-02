#!/bin/bash

pushd /etc
ln -sf /usr/share/zoneinfo/Europe/Paris localtime
popd

if [ -f /usr/bin/apt-get ]
then
	apt-get update
	apt-get install -y wget curl git xvfb unzip libxrender1 libxtst6 libxi6 libhyphen0 csh curl g++ make psmisc default-jdk poppler-utils python python-ipaddr bzip2 fontconfig lynx firefox-esr
else
	yum update -y
	yum install -y redhat-lsb-core wget curl git dbus-x11 Xvfb unzip libXrender libXtst libXi csh curl gcc-c++ glibc-static make psmisc java-1.8.0-openjdk-devel poppler-utils python python-ipaddr bzip2 fontconfig lynx firefox
	dbus-uuidgen --ensure	
fi

git config --global credential.helper store --file
git config --global push.default matching

user=$1

git clone https://$user@github.com/$user/r2d2
git clone https://$user@github.com/$user/idsrd

mkdir -p ~/Downloads

#runit installation
mkdir -p /package
chmod 1755 /package
pushd /package
wget -qO- http://smarden.org/runit/install.html | grep -o runit-[0-9.]*tar.gz | head -n1 | xargs -I '{}' sh -c \
'wget http://smarden.org/runit/{} -O {} && tar xzvf {}'
pushd admin/runit*
package/install
package/install-man
install -m0750 /package/admin/runit/etc/2 /sbin/runsvdir-start
mkdir -p /service
popd
popd


pushd r2d2
bash ./install.sh
popd

pushd idsrd
bash ./install.sh
popd

cat r2d2/r2d2.cron idsrd/idsrd.cron | crontab


