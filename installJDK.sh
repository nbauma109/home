#!/bin/bash

echo Installing JAVA 8 ...
if [ -f /usr/bin/apt-get ]
then
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
	apt-get -y install oracle-java8-installer oracle-java8-set-default
else
	pushd ~/Downloads
	ora_base='http://www.oracle.com'
	ora_java=$ora_base'/technetwork/java/javase/downloads/index.html'
	ora_jdk8=$ora_base`wget -qO- $ora_java|tr '"' '\n'|grep jdk8|head -n1`
	wget -qO- $ora_jdk8|tr '"' '\n'|grep http|grep x64.rpm|tail -n1|xargs -I '{}' sh -c \
	'wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" {} -O `basename {}` && rpm -i `basename {}`'
	popd
fi

