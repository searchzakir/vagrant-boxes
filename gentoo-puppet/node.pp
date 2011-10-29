Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }
File { owner => root, group => root }

import "common"

include osuosl
#include osuosl::ssh
include osuosl::postfix
include osuosl::packages
include firewall
include cron
include grub::gentoo
#include nrpe
#include sudo
include stunnel::server
#include xinetd
#include rsync::server
#include apache

class { 
    "ntp":
        ntp_server => "time.osuosl.org";
    "postfix":
        smtp_server => "smtp.osuosl.org";
    "puppet":
        ensure  => "disableboot";
#    "syslog_ng::server":
#        source => {
#           fir_bak => {
#               "server"    => "10.1.0.20",
#               "port"      => "514",
#               "protocol"  => "udp"
#           },
#           fir_oob => {
#               "server"    => "10.0.0.20",
#               "port"      => "514",
#               "protocol"  => "udp"
#           },
#           fir_stunnel => {
#               "server"    => "127.0.0.1",
#               "port"      => "syslog-ng",
#               "protocol"  => "tcp"
#           },
#        };
}

stunnel::service { "syslog-ngs":
    accept  => "127.0.0.1:syslog-ng",
    connect => "fir.osuosl.org:syslog-ngs",
}

#xinetd::conf { "syslog-ng":
#    bind        => "127.0.0.1",
#    server      => "/usr/sbin/stunnel",
#    server_args => "/etc/stunnel/stunnel.conf",
#    port        => "syslog-ng",
#}

#rsync::module { "meego":
#    path    => "/data/ftp/pub/meego",
#    comment => "MeeGo",
#}

#rsync::secrets { "foobar":
#    ensure  => absent,
#    password => "secret",
#}

network_config { "eth0":
    bootproto => "dhcp",
}

#realize Resolv_conf[osuosl]
