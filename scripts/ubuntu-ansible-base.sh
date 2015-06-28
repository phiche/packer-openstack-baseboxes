#!/bin/sh

echo "apt-get update and upgrade"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Install ansible so it can run locally"
sudo apt-get -y install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y update
sudo apt-get -y install ansible

#echo "Set the local time to CET and turn on ntpd"
sudo cp /usr/share/zoneinfo/CET /etc/localtime
#sudo chkconfig ntpd on

echo "Set config necessary for automation"
sudo sed -i 's/^.*requiretty/#Defaults requiretty/g' /etc/sudoers
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
