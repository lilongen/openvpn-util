terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_vpc" "vpc_t1" {
  cidr_block = "10.10.10.0/24"
}

variable "ec2_id" {
  type = string
  default = "i-08576e98179d60049"
}

resource "aws_eip" "ec2_public_eip" {
  instance = var.ec2_id
  vpc = true
}

data "aws_instances" "test" {
  filter {
    name = "ids"
    values = ["i-08576e98179d60049"]
  }

  instance_state_names = ["running", "stopped"]
}
