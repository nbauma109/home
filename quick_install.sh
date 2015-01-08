#!/bin/bash

if [ -f /usr/bin/apt-get ]
then
	apt-get update
	apt-get install -y git
else
	yum update -y
	yum install -y git
fi

git clone https://github.com/nbauma109/ibc
git clone https://github.com/nbauma109/r2d2

pushd ib-controller
./install.sh
popd

pushd r2d2
./install.sh
popd


