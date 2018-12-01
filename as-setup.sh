#!/bin/bash

dpkg -s bc > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
	apt update
	apt install -y bc
fi
cd /tmp
wget https://github.com/lexandr0s/autoswitch/raw/master/autoswitch.tar
tar -xf autoswitch.tar 
cp as/autoswitch /hive/sbin
cp as/autoswitch_bin /hive/sbin
if [[ ! -f /hive-config/autoswitch.conf ]]; then
	cp as/autoswitch.conf /hive-config
else
	source /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Zhash) == null ]] &&	sed -i "s/}'/,\n\"Zhash\":0\n}'/" /hive-config/autoswitch.conf
fi


if [[ ! -f /hive-config/rig_data.json ]]; then
	cp as/rig_data.json /hive-config
else
	rig_data=$(cat /hive-config/rig_data.json)
	if [[ -z $(echo $rig_data | jq ".[] | select (.nice_algo == 36) | .algo") ]]; then
		rig_data=$(echo $rig_data | jq ".[. | length] |= . + {\"hive_fs\": \"Autoswitch Zhash\",\"algo\": \"Zhash\",\"bench\": 0,\"mining\": 1,\"mult\": 0,\"nice_algo\": 36,\"fs_id\": 0}")
		echo $rig_data | jq . > /hive-config/rig_data.json
	fi
fi
rm -R as
rm autoswitch.tar
cd /home/user
echo
echo "Install Autoswitch complete"
echo "If this is the first installation, now you need to configure it."
echo "See the manual on Hive OS forum"
echo "If this is an update, you do not need to do anything."
echo "Happy mining!"
