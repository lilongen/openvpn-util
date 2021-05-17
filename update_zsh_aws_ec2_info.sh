#!/usr/bin/env bash
# automatically update zsh and iterm aws ec2 info
#


file_tfstate="./terraform/terraform.tfstate"
public_ip="$(grep -o '"public_ip": .*' $file_tfstate | awk -F'"' '{print $4}')"
echo "public_ip: $public_ip"

perl -i -pE 's/(awsHost=).*/$1'${public_ip}'/g' /Users/lilongen/github/awssshsocks/vars.sh
source /Users/lilongen/github/awssshsocks/vars.sh