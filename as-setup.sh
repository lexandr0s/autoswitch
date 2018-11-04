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
else
	sed -i '/PROFILE/d' /hive-config/autoswitch.conf
	sed -i '/different miners/d' /hive-config/autoswitch.conf
	sed -i '/FS with names like this/d' /hive-config/autoswitch.conf
	sed -i '1i\\n' /hive-config/autoswitch.conf
	sed -i '1i\PROFILE=\"\"' /hive-config/autoswitch.conf
	sed -i '1i\#If you are not using different profiles, just leave PROFILE variable empty.' /hive-config/autoswitch.conf
	sed -i '1i\#\"Autoswitch Algorithm PROFILE\" and autoswitch on this riga will use FS only with this PROFILE in the name' /hive-config/autoswitch.conf
	sed -i '1i\#If this variable is set, you can create a FS with names like this:' /hive-config/autoswitch.conf
	sed -i '1i\#For example, with different miners (for NVIDIA and AMD rigs) or with different wallet addresses' /hive-config/autoswitch.conf
	sed -i '1i\#Set the PROFILE variable if you want to create several different FS for one algorithm' /hive-config/autoswitch.conf
	sed -i '/^$/N;/\n$/N;//D' /hive-config/autoswitch.conf
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