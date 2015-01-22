#!/bin/bash

if [ -f /usr/bin/apt-get ]
then
	apt-get update
	apt-get install -y git
else
	yum update -y
	yum install -y git
fi

user=$1

git clone https://$user@github.com/$user/ibc
git clone https://$user@github.com/$user/r2d2

pushd ibc
./install.sh
popd

pushd r2d2
./install.sh
popd

