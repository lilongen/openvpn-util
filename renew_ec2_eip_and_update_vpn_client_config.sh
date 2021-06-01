#!/usr/bin/env bash
# automatically renew ec2 eip and update tunnelblock client config file remote host
#

run() {
  cmd=$1
  desc=$2
  echo "$desc ..."
  echo "$cmd"
  eval "$cmd"
  echo "${desc} ... done"
}

run "osascript ./disconnect_tunnelblick_aws_connection.applescript" \
  "disconnect Tunnelblick aws connection"

run "python ./pyexpect_renew_ec2_eip.py" \
  "renew ec2 eip"

run "./update_tunnelblick_aws_config_ovpn.sh" \
  "udpate tunnelblick aws openvpn client config file"

run "osascript ./restart_tunnelblick.applescript" \
  "restart tunnelblick and auto connect"

echo "finished!"

