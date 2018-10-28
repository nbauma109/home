#!/bin/bash

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
