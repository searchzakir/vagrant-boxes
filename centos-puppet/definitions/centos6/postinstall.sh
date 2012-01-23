#http://chrisadams.me.uk/2010/05/10/setting-up-a-centos-base-box-for-development-and-testing-with-vagrant/

date > /etc/vagrant_box_build_time

rpm -iUh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-5.noarch.rpm

# Set yum repos to us
for i in CentOS-Base epel ; do
      sed -i -e 's/^\(mirrorlist.*\)/#\1/g' /etc/yum.repos.d/$i.repo
done
sed -i -e 's/^#baseurl=.*$releasever\/os\/$basearch\//baseurl=http\:\/\/centos.osuosl.org\/$releasever\/os\/$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/updates\/$basearch\//baseurl=http\:\/\/centos.osuosl.org\/$releasever\/updates\/$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/addons\/$basearch\//baseurl=http\:\/\/centos.osuosl.org\/$releasever\/addons\/$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/extras\/$basearch\//baseurl=http\:\/\/centos.osuosl.org\/$releasever\/extras\/$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/centosplus\/$basearch\//baseurl=http\:\/\/centos.osuosl.org\/$releasever\/centosplus\/$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*$releasever\/contrib\/$basearch\//baseurl=http\:\/\/centos.osuosl.org\/$releasever\/contrib\/$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
sed -i -e 's/^#baseurl=.*pub\/epel\/5\/$basearch$/baseurl=http\:\/\/epel.osuosl.org\/$releasever\/$basearch\//g' /etc/yum.repos.d/epel.repo
sed -i -e 's/^#baseurl=.*pub\/epel\/5\/$basearch\/debug$/baseurl=http\:\/\/epel.osuosl.org\/$releasever\/$basearch\/debug\//g' /etc/yum.repos.d/epel.repo

yum -y erase wireless-tools gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y update --skip-broken
yum -y clean all

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm VBoxGuestAdditions_$VBOX_VERSION.iso

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

#dd if=/dev/zero of=/tmp/clean || rm /tmp/clean

exit
