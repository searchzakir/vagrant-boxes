Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }
File { owner => root, group => root }

import "common"

include osuosl
#include osuosl::ssh
include osuosl::postfix
include osuosl::base_packages
include firewall
include cron
include grub::gentoo

class { 
    "ntp":
        ntp_server => "time.osuosl.org";
    "postfix":
        smtp_server => "smtp.osuosl.org";
#    "ldap::client":
#        ldap_base   => "dc=osuosl,dc=org",
#        ldap_uri    => "ldaps://ldap1.osuosl.org/ ldaps://ldap2.osuosl.org",
#        ldap_ssl    => "yes";
    "puppet":
        ensure  => "disableboot";
}

#realize Resolv_conf[osuosl]
