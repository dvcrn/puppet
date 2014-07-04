#!/bin/bash
cd /opt/puppet
git reset --hard
git fetch -p
git checkout master
git pull

puppet apply /opt/puppet/manifests/* --modulepath=/opt/puppet/modules/
