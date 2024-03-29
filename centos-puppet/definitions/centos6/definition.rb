Veewee::Session.declare({
  :cpu_count => '1', :memory_size=> '512',
  :disk_size => '10240', :disk_format => 'VDI', :hostiocache => 'off', :ioapic => 'on', :pae => 'on',
  :os_type_id => 'RedHat_64',
  :iso_file => "CentOS-6.2-x86_64-netinstall.iso",
  :iso_src => "http://centos.osuosl.org/6/isos/x86_64/CentOS-6.2-x86_64-netinstall.iso",
  :iso_md5 => "7e7f4161a5c8c49032655e5f4ecd1f07",
  :iso_download_timeout => 1000,
  :boot_wait => "15", :boot_cmd_sequence => [ '<Tab> text ks=http://%IP%:%PORT%/ks.cfg<Enter>' ],
  :kickstart_port => "7122", :kickstart_timeout => 10000, :kickstart_file => "ks.cfg",
  :ssh_login_timeout => "100", :ssh_user => "vagrant", :ssh_password => "vagrant", :ssh_key => "",
  :ssh_host_port => "7222", :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p'|sudo -S sh '%f'",
  :shutdown_cmd => "/sbin/halt -h -p",
  :postinstall_files => [ "postinstall.sh"], :postinstall_timeout => 10000
})
