#!/bin/bash

apt update
apt install -y bc
cd /tmp
wget https://github.com/lexandr0s/autoswitch/raw/master/autoswitch.tar
tar -xf autoswitch.tar 
cp as/autoswitch /hive/sbin
cp as/autoswitch_bin /hive/sbin
if [[ ! -f /hive-config/autoswitch.conf ]]; then
	cp as/autoswitch.conf /hive-config
fi


[[ ! -f /hive-config/rig_data.json ]] && cp as/rig_data.json /hive-config
rm -R as
rm autoswitch.tar
cd /home/user
echo
echo "Install Autoswitch complete"
echo "If this is the first installation, now you need to configure it."
echo "See the manual on Hive OS forum"
echo "If this is an update, you do not need to do anything."
echo "Happy mining!"
