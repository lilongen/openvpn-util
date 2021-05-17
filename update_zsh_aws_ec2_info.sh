#!/usr/bin/env bash
# automatically update zsh and iterm aws ec2 info
#


file_tfstate="./terraform/terraform.tfstate"
public_ip="$(grep -o '"public_ip": .*' $file_tfstate | awk -F'"' '{print $4}')"
echo "public_ip: $public_ip"

file_aws_vars=/Users/lilongen/github/awssshsocks/vars.sh
perl -i -pE 's/(awsHost=).*/${1}'${public_ip}'/g' $file_aws_vars
echo source $file_aws_vars