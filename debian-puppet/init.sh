#!/bin/bash

# module path
cp /vagrant/puppet.conf /etc/puppet/puppet.conf
echo 'alias p="puppet apply --modulepath=/vagrant/puppet/modules/core:/vagrant/puppet/modules/dist"' >> /root/.bashrc
