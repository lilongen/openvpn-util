#!/usr/bin/env bash
# automatically update tunnelblock client config file remote host
#

# 1. get public ip from terrafrom tfstate file when run terrform plan to create a new eip
# 2. get public ip from aws cli describe-instances output,
#    cause last "terraform destory" will destroy eip, and automatically renew a eip to ec2 instance
#    but it will not listed in eip list
file_tfstate="./terraform/terraform.tfstate"
public_ip="$(grep -o '"public_ip": .*' $file_tfstate | awk -F'"' '{print $4}')"
if [ "$public_ip" = "" ]; then
  echo "public_ip not found in terraform state!"
  echo "get public_ip using aws cli ..."
  aws ec2 describe-instances > .ec2.instances
  public_ip="$(grep -o '"PublicIpAddress": .*' .ec2.instances | awk -F'"' '{print $4}')"
  echo "public_ip from aws cli: $public_ip"
fi


# update aws ec2 openvpn client config using new eip
tunnelblick_ovpn_location="/Library/Application Support/Tunnelblick/Shared/"
ovpn_source_location="/Users/lilongen/onedrive/aws/openvpn/client_config/"
echo "find candidated ovpn config file ..."
sudo find "$tunnelblick_ovpn_location" "$ovpn_source_location" -name "*.ovpn" | grep aws-ov-bw | tee candidated.config.files

timestamp=$(date "+%Y%m%d.%H%M%S")
echo "'remote host' in these files will be updated to '${public_ip}' ..."
cat candidated.config.files | xargs -I {} sudo perl -i.${timestamp} -pE 's/(remote) [\d\.]* (\d+)/$1 '${public_ip}' $2/g' {}
echo "aws config.ovpn ... updated!"
