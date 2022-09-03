#!/bin/bash


firsttime=1

dpkg -s bc > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
	apt update
	apt install -y bc
fi

[[ -f autoswitch.tar ]] && rm autoswitch.tar
wget https://github.com/lexandr0s/autoswitch/raw/master/autoswitch.tar
tar -xf autoswitch.tar 
cp as/autoswitch /hive/sbin
cp as/autoswitch_bin /hive/sbin

if [[ ! -f /hive-config/autoswitch.conf ]]; then
	cp as/autoswitch.conf /hive-config
else
	firsttime=0
	source /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Beam) == null ]] &&	sed -i "s/}'/,\n\"Beam\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Grin29) == null ]] &&	sed -i "s/}'/,\n\"Grin29\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Grin31) == null ]] &&	sed -i "s/}'/,\n\"Grin31\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Lyra2rev3) == null ]] &&	sed -i "s/}'/,\n\"Lyra2rev3\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .MTP) == null ]] &&	sed -i "s/}'/,\n\"MTP\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .CryptoNightR) == null ]] &&	sed -i "s/}'/,\n\"CryptoNightR\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .CuckooAE) == null ]] &&	sed -i "s/}'/,\n\"CuckooAE\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Grin29d) == null ]] &&	sed -i "s/}'/,\n\"Grin29d\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .BeamV2) == null ]] &&	sed -i "s/}'/,\n\"BeamV2\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .X16Rv2) == null ]] &&	sed -i "s/}'/,\n\"X16Rv2\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .RandomX) == null ]] &&	sed -i "s/}'/,\n\"RandomX\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Eaglesong) == null ]] &&	sed -i "s/}'/,\n\"Eaglesong\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Cuckaroom) == null ]] &&	sed -i "s/}'/,\n\"Cuckaroom\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Cuckatoo32) == null ]] &&	sed -i "s/}'/,\n\"Cuckatoo32\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .KawPow) == null ]] &&	sed -i "s/}'/,\n\"KawPow\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .CuckarooBFC) == null ]] &&	sed -i "s/}'/,\n\"CuckarooBFC\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .BeamV3) == null ]] &&	sed -i "s/}'/,\n\"BeamV3\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .CuckaRooz29) == null ]] &&	sed -i "s/}'/,\n\"CuckaRooz29\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Octopus) == null ]] &&	sed -i "s/}'/,\n\"Octopus\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Autolykos) == null ]] &&	sed -i "s/}'/,\n\"Autolykos\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .Zelhash) == null ]] &&	sed -i "s/}'/,\n\"Zelhash\":0\n}'/" /hive-config/autoswitch.conf
	[[ $(echo $BENCHMARK | jq .ETCHash) == null ]] &&	sed -i "s/}'/,\n\"ETCHash\":0\n}'/" /hive-config/autoswitch.conf
	
	#[[ $(cat /hive-config/autoswitch.conf | grep -c "IPV6") -eq 0 ]] && sed -i "/BENCHMARK='{/i\#If you dont want to use IPv6 on algo X16r, set IPV6=0\nIPV6=1\n" /hive-config/autoswitch.conf
	[[ $(cat /hive-config/autoswitch.conf | grep -c "ZIL") -eq 0 ]] && sed -i "/use IPv6/i\#If you want mining Zilliqa, set ZIL=1 or ZIL=2\nZIL=0\n" /hive-config/autoswitch.conf
	
	#[[ $(cat /hive-config/autoswitch.conf | grep -c "USE_NEW") -eq 0 ]] && sed -i "/BENCHMARK=/i\#Set variable for New Platform\nUSE_NEW=1\n" /hive-config/autoswitch.conf
	
	sed -i "s/ZIL=3/ZIL=2/" /hive-config/autoswitch.conf
	sed -i "/#Set variable for New Platform/d" /hive-config/autoswitch.conf
	sed -i "/USE_NEW=/d" /hive-config/autoswitch.conf
fi


if [[ ! -f /hive-config/autoswitch_pow.conf ]]; then
	cp as/autoswitch_pow.conf /hive-config
else
	source /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Beam) == null ]] &&	sed -i "s/}'/,\n\"Beam\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Grin29) == null ]] &&	sed -i "s/}'/,\n\"Grin29\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Grin31) == null ]] &&	sed -i "s/}'/,\n\"Grin31\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Lyra2rev3) == null ]] &&	sed -i "s/}'/,\n\"Lyra2rev3\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .MTP) == null ]] &&	sed -i "s/}'/,\n\"MTP\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .CryptoNightR) == null ]] &&	sed -i "s/}'/,\n\"CryptoNightR\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .CuckooAE) == null ]] &&	sed -i "s/}'/,\n\"CuckooAE\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Grin29d) == null ]] &&	sed -i "s/}'/,\n\"Grin29d\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .BeamV2) == null ]] &&	sed -i "s/}'/,\n\"BeamV2\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .X16Rv2) == null ]] &&	sed -i "s/}'/,\n\"X16Rv2\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .RandomX) == null ]] &&	sed -i "s/}'/,\n\"RandomX\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Eaglesong) == null ]] &&	sed -i "s/}'/,\n\"Eaglesong\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Cuckaroom) == null ]] &&	sed -i "s/}'/,\n\"Cuckaroom\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Cuckatoo32) == null ]] &&	sed -i "s/}'/,\n\"Cuckatoo32\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .KawPow) == null ]] &&	sed -i "s/}'/,\n\"KawPow\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .CuckarooBFC) == null ]] &&	sed -i "s/}'/,\n\"CuckarooBFC\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .BeamV3) == null ]] &&	sed -i "s/}'/,\n\"BeamV3\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .CuckaRooz29) == null ]] &&	sed -i "s/}'/,\n\"CuckaRooz29\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Octopus) == null ]] &&	sed -i "s/}'/,\n\"Octopus\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Autolykos) == null ]] &&	sed -i "s/}'/,\n\"Autolykos\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .Zelhash) == null ]] &&	sed -i "s/}'/,\n\"Zelhash\":0\n}'/" /hive-config/autoswitch_pow.conf
	[[ $(echo $POW | jq .ETCHash) == null ]] &&	sed -i "s/}'/,\n\"ETCHash\":0\n}'/" /hive-config/autoswitch_pow.conf
fi

cp as/rig_data.json /hive-config
[[ -f /hive-config/rig_data_new.json ]] && rm /hive-config/rig_data_new.json
[[ $firsttime -eq 0 ]] && autoswitch config



rm -R as
rm autoswitch.tar
cd /home/user
need_reboot=0
source /hive-config/autoswitch.conf
#if [[ $IPV6 == 1 ]]; then
#	if [[ $(cat /etc/default/grub | grep -c ipv6.disable=1) -ne 0 ]]; then
#		sed -i "s/ipv6.disable=1 //" /etc/default/grub
#		sleep 1
#		update-grub
#		need_reboot=1
#	fi
#fi

echo
echo "Install Autoswitch complete"
echo "If this is the first installation, now you need to configure it."
echo "See the manual on Hive OS forum"
echo "If this is an update, you do not need to do anything."
echo "Happy mining!"

#if [[ $need_reboot -eq 1 ]]; then
#	message info "Your system reconfigure for IPv6 enable. Reboot is required. Reboot after 15 seconds"
#	sleep 15
#	sreboot
#fi

