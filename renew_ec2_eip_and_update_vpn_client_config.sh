#!/usr/bin/env bash
# automatically renew ec2 eip and update tunnelblock client config file remote host
#

echo "disconnect Tunnelblick aws connection ..."
osascript ./disconnect_tunnelblick_aws_connection.applescript
sleep 8
echo "disconnect Tunnelblick aws connection ... done"

echo "renew ec2 eip ..."
python ./pyexpect_renew_ec2_eip.py
echo "renew ec2 eip ... done!"

echo "udpate tunnelblick aws openvpn client config file ..."
./update_tunnelblick_aws_config_ovpn.sh
echo "udpate tunnelblick aws openvpn client config file ... done!"

echo "restart tunnelblick and auto connect ..."
osascript ./restart_tunnelblick.applescript
echo "restart tunnelblick and auto connect ... done!"

echo "finished!"




