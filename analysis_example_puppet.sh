#! /bin/sh
# Copyright 2016, Stefan Kuppelwieser <stefan.kuppelwieser@online.de>
# -*- yaml -*-
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# Analyse an example project (puppet) with Codeface.

cd
if [ ! -d /vagrant ]; then
   echo "This script assumes a Vagrant based installation, aborting."
   exit 1
fi

if [ ! -d $HOME/git-repos ]; then
    mkdir git-repos
fi

if [ ! -d $HOME/res ]; then
    mkdir res
fi

echo "Cloning git repository for project puppet"
(cd git-repos; git clone https://github.com/puppetlabs/puppet.git)

if [ ! -d $HOME/git-repos/puppet ]; then
    echo "Could not clone git repository for puppet via http."
    echo "Proxy access problem? Be sure to set the environment variable http_proxy if required."
    echo "Aborting"
    exit 1
fi

# The use of two cpus (-j2) is intentional to make sure things work in
# parallel processing mode
echo "Running Codeface on puppet"
codeface -j2 run -c /vagrant/codeface.conf -p /vagrant/conf/puppet.conf $HOME/res $HOME/git-repos