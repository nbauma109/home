#!/bin/bash

if [ -f /usr/bin/apt-get ]
then
	apt-get update
	apt-get install -y git
else
	yum update -y
	yum install -y git
fi

git config --global credential.helper store --file

user=$1

git clone https://$user@github.com/$user/ibc
git clone https://$user@github.com/$user/r2d2
git clone https://$user@github.com/$user/idsrd

pushd ibc
./install.sh
popd

pushd r2d2
./install.sh
popd

pushd idsrd
./install.sh
popd

cat r2d2/r2d2.cron idsrd/idsrd.cron | crontab


