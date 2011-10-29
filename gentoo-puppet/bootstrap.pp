Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }
File { owner => root, group => root }

import "common"
include osuosl::gentoo::init

class { 
    "puppet":
        ensure  => "disableboot";
}
