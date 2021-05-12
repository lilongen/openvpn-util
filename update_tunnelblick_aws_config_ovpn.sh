#!/usr/bin/env bash
# automatically update tunnelblock client config file remote host
#

ovpn_location="/Library/Application Support/Tunnelblick/Shared/"
file_tfstate="./terraform/terraform.tfstate"
echo "find candidated ovpn config file ..."
sudo find "$ovpn_location" -name "*.ovpn" | grep aws-ov-bw | tee candidated.config.files

timestamp=$(date "+%Y%m%d.%H%M%S")
new_eip=$(grep -o '"public_ip": .*' $file_tfstate | awk -F'"' '{print $4}')
echo "'remote host' in these files will be updated to '${new_eip}' ..."

cat candidated.config.files | xargs -I {} sudo perl -i.${timestamp} -pE 's/(remote) [\d\.]+ (\d+)/$1 '${new_eip}' $2/g' {}
echo "aws config.ovpn ... updated!"
