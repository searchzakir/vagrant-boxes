ssh_authorized_key { 
    "vagrant-root":
        ensure  => present,
        key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key",
        user    => "root",
        type    => "rsa";
    "vagrant":
        ensure  => present,
        key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key",
        user    => "vagrant",
        type    => "rsa",
        require => File["/home/vagrant/.ssh"];
}

group { vagrant: ensure => present, }

user { 
    "vagrant":
        ensure      => present,
        gid         => "vagrant",
        home        => "/home/vagrant",
        shell       => "/bin/bash",
        password    => '$6$tmV1bTlq$wU8KpujritkHy/tdWekK4VwZX/KdbXHf.RdopUIoff3/2YYOomX/1CkzNCY9cCZm2.9KrmHORv1helWBwOQ0o0',
        require     => Group["vagrant"];
    "root":
        password    => '$6$tmV1bTlq$wU8KpujritkHy/tdWekK4VwZX/KdbXHf.RdopUIoff3/2YYOomX/1CkzNCY9cCZm2.9KrmHORv1helWBwOQ0o0';
}

file {
    "/home/vagrant":
        ensure  => directory,
        owner   => "vagrant",
        group   => "vagrant",
        require => [ Group["vagrant"], User["vagrant"], ];
    "/home/vagrant/.ssh":
        ensure  => directory,
        owner   => "vagrant",
        group   => "vagrant",
        require => [ Group["vagrant"], User["vagrant"],
            File["/home/vagrant"],];
    "/etc/sudoers":
        source  => "/tmp/manifests/sudoers",
        mode    => 440,
        require => Package["sudo"];
}

package { sudo: ensure  => present, }
