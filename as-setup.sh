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
echo "If this is the first installation, тow you need to configure it."
echo "See the manual on Hive OS forum"
echo "If this is an update, you do not need to do anything."
echo "Happy mining!"


#Set the PROFILE variable if you want to create several different filesystems for one algorithm. For example, with different miners (for NVIDIA and AMD) or with different wallet addresses. If this variable is set, you can create a file system with names like this: Autoswitch Algorithm PROFILE and autoswitch on this riga will use flight sheets only
