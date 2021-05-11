#!/usr/bin/env bash
# automatically update tunnelblock client config file remote host

tunnelblick_config_location="/Library/Application Support/Tunnelblick/Shared/"
sudo find "$tunnelblick_config_location" -name "*.ovpn" | grep aws-ov-bw | tee  candidated.config.files
ts=$(date "+%Y%m%d.%H%M%S")
new_eip=$(grep -o '"public_ip": .*' ./terraform/terraform.tfstate | awk -F'"' '{print $4}')
echo "new eip: ${new_eip}"
cat candidated.config.files | xargs -I {} sudo perl -i.${ts} -pE 's/(remote) [\d\.]+ (\d+)/$1 '${new_eip}' $2/g' {}
