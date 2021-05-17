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

variable "ec2_id" {
  type = string
  default = "i-08576e98179d60049"
}

resource "aws_eip" "ec2_public_eip" {
  instance = var.ec2_id
  vpc = true
}
