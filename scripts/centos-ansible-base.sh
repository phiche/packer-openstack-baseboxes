#!/bin/sh

echo "Yum update and install"
sudo yum -y update

echo "Add the official EPEL repository"
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
while [ $? -ne 0 ]
do
  echo "Did we just error on Couldn't resolve host 'dl.fedoraproject.org'?. Seems this host is a bit unreliable. Lets retry."
  sleep 5
  sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
done

echo "Install ansible so it can run locally"
sudo yum -y install ansible libselinux-python

echo "Set the local time to CET and turn on ntpd"
sudo ln -sf /usr/share/zoneinfo/CET /etc/localtime
sudo chkconfig ntpd on

echo "Set config necessary for automation"
sudo sed -i 's/^.*requiretty/#Defaults requiretty/g' /etc/sudoers
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
