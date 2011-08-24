#!/bin/bash

# module path
cp /vagrant/puppet.conf /etc/puppet/puppet.conf
# disable cfengine
# NOTE: this will be taken care of by puppet eventually
sed -i -e 's/.*cfexecd.*//g' /etc/crontab
