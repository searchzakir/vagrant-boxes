Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }
File { owner => root, group => root }

import "common"
include osuosl::gentoo::base

class { 
    "puppet":
        ensure  => "disableboot";
}
