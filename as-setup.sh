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
	[[ $(echo $BENCHMARK | jq .Beam) == null ]] &&	sed -i "s/}'/,\n\"Beam\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Grin29) == null ]] &&	sed -i "s/}'/,\n\"Grin29\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Grin31) == null ]] &&	sed -i "s/}'/,\n\"Grin31\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Lyra2rev3) == null ]] &&	sed -i "s/}'/,\n\"Lyra2rev3\":0\n}'/" /hive-config/autoswitch.conf
fi


if [[ ! -f /hive-config/rig_data.json ]]; then
	cp as/rig_data.json /hive-config
else
	rig_data=$(cat /hive-config/rig_data.json)
	if [[ -z $(echo $rig_data | jq ".[] | select (.nice_algo == 37) | .algo") ]]; then
		rig_data=$(echo $rig_data | jq ".[. | length] |= . + {\"hive_fs\": \"Autoswitch Beam\",\"algo\": \"Beam\",\"bench\": 0,\"mining\": 1,\"mult\": 0,\"nice_algo\": 37,\"fs_id\": 0}")
	fi
	if [[ -z $(echo $rig_data | jq ".[] | select (.nice_algo == 38) | .algo") ]]; then
		rig_data=$(echo $rig_data | jq ".[. | length] |= . + {\"hive_fs\": \"Autoswitch Grin29\",\"algo\": \"Grin29\",\"bench\": 0,\"mining\": 1,\"mult\": 0,\"nice_algo\": 38,\"fs_id\": 0}")
	fi
	if [[ -z $(echo $rig_data | jq ".[] | select (.nice_algo == 39) | .algo") ]]; then
		rig_data=$(echo $rig_data | jq ".[. | length] |= . + {\"hive_fs\": \"Autoswitch Grin31\",\"algo\": \"Grin31\",\"bench\": 0,\"mining\": 1,\"mult\": 0,\"nice_algo\": 39,\"fs_id\": 0}")
	fi
	if [[ -z $(echo $rig_data | jq ".[] | select (.nice_algo == 40) | .algo") ]]; then
		rig_data=$(echo $rig_data | jq ".[. | length] |= . + {\"hive_fs\": \"Autoswitch Lyra2rev3\",\"algo\": \"Lyra2rev3\",\"bench\": 0,\"mining\": 1,\"mult\": 0,\"nice_algo\": 40,\"fs_id\": 0}")
	fi
	echo $rig_data | jq . > /hive-config/rig_data.json
fi


if [[ ! -f /hive-config/autoswitch_pow.conf ]]; then
	cp as/autoswitch_pow.conf /hive-config
else
	source /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Beam) == null ]] &&	sed -i "s/}'/,\n\"Beam\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Grin29) == null ]] &&	sed -i "s/}'/,\n\"Grin29\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Grin31) == null ]] &&	sed -i "s/}'/,\n\"Grin31\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Lyra2rev3) == null ]] &&	sed -i "s/}'/,\n\"Lyra2rev3\":0\n}'/" /hive-config/autoswitch_pow.conf
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
