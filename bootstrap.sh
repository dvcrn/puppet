#!/bin/bash
echo "This script will bootstrap puppet and configure your node for the use with our puppetmaster."
read -p "Please enter this machines (wished) hostname: " CERTNAME
echo "Okay, let's do this!"

echo ""
echo "----> Changing hostname..."
/bin/hostname $CERTNAME
echo $CERTNAME > /etc/hostname

echo ""
echo "----> Installing puppet..."
cd /tmp/
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update
apt-get -y install build-essential puppet ruby1.9.3 git
gem install librarian-puppet

echo ""
echo "----> Configuring puppet..."

mkdir -p /opt/puppet
cd /opt/puppet
git clone https://github.com/dabido/puppet.git .
git fetch -p
git checkout master
librarian-puppet install

echo ""
echo "----> Doing initial pull"
puppet apply /opt/puppet/manifests/ --modulepath=/opt/puppet/modules/ --certname=$(hostname)

