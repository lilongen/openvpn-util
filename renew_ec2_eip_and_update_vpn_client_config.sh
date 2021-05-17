#!/usr/bin/env bash
# automatically renew ec2 eip and update tunnelblock client config file remote host
#

cd terraform
echo "destory last created eip ..."
terraform destroy
echo "destory last created eip ... done"

sleep 3

echo "renew ec2 eip ..."
terraform plan
terraform apply
echo "renew ec2 eip ... done!"
cd ..


echo "udpate tunnelblick aws openvpn client config file ..."
./update_tunnelblick_aws_config_ovpn.sh
echo "udpate tunnelblick aws openvpn client config file ... done!"

echo "restart tunnelblick and auto connect ..."
osascript ./restart_tunnelblick.applescript
echo "restart tunnelblick and auto connect ... done!"

echo "finished!"




