terraform {
  backend "s3" {
    region               = "us-east-1"
    bucket               = "aidana-tf-day6"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "env"
  }
}

locals {
  #   env                 = "prod"
  name                = "prod-vpc"
  create_default_cidr = false

}

resource "aws_vpc" "vpc_prod" {
  count      = terraform.workspace == "prod" ? 2 : 0
  cidr_block = local.create_default_cidr ? "10.0.0.0/16" : var.cidr_block

  tags = {
    "Name" = "${terraform.workspace}-vpc"
  }
}

resource "aws_vpc" "vpc_dev" {
  count      = terraform.workspace == "dev" ? 2 : 0
  cidr_block = local.create_default_cidr ? "10.0.0.0/16" : var.cidr_block

  tags = {
    "Name" = "${terraform.workspace}-vpc"
  }
}
