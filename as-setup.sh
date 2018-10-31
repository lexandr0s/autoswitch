#!/bin/bash

apt update
apt install -y bc
cd /tmp
wget https://github.com/lexandr0s/autoswitch/raw/master/autoswitch.tar
tar -xvf autoswitch.tar
cp as/autoswitch /hive/sbin
cp as/autoswitch_bin /hive/sbin
cp as/autoswitch.conf /hive-config
cp as/rig_data.json /hive-config
rm -R as
rm autoswitch.tar
cd /home/user
echo "Install Autoswitch complete"
echo "Now you need to configure it."
echo "See the manual"
echo "Happy mining!"
