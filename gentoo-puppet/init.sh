#!/bin/bash

# module path
cp /vagrant/puppet.conf /etc/puppet/puppet.conf
# local binary files
#cp -r /vagrant/packages/* /usr/portage/packages/
# disable cfengine
# NOTE: this will be taken care of by puppet eventually
sed -i -e 's/.*cfexecd.*//g' /etc/crontab

echo 'alias p="puppet apply --modulepath=/vagrant/puppet/modules/core:/vagrant/puppet/modules/dist"' >> /root/.bashrc
