#!/bin/bash

if [ -f /usr/bin/apt-get ]
then
	apt-get update
	apt-get install -y git
else
	yum update -y
	yum install -y git
fi

echo 'Please enter your GitHub password :'
user='nbauma109'
read -s pass

git clone https://$user:$pass@github.com/$user/ibc
git clone https://$user:$pass@github.com/$user/r2d2

pushd ibc
./install.sh
popd

pushd r2d2
./install.sh
popd

