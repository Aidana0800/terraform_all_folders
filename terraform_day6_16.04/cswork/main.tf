terraform {
  backend "s3" {
    region               = "us-east-1"
    bucket               = "aidana-tf-day6"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "env"
  }
}

locals {
  #   env  = var.env
  #   name = "${local.env}-vpc"

}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    "Name" = "${terraform.workspace}-vpc"
  }
}

