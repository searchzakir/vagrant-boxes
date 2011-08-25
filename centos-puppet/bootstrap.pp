Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }
File { owner => root, group => root }

import "common"

package { "puppet":
    ensure  => "latest",
}
