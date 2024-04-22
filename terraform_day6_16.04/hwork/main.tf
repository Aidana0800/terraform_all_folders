terraform {
  backend "s3" {
    region               = "us-east-1"
    bucket               = "aidana-tf-day6"
    key                  = "day6hw/terraform.tfstate"
    workspace_key_prefix = "env"
  }
}

# locals {
#   bucket_name = terraform.workspace == "prod" ? "bucket-prod" : (
#     terraform.workspace == "dev" ? "bucket-dev" :
#   terraform.workspace == "stage" ? "bucket-stage" : null)
# }


resource "aws_s3_bucket" "s3_bucket" {
  count = terraform.workspace == "dev" || terraform.workspace == "prod" || terraform.workspace == "stage" ? 1 : 0
  tags = {
    "Name" = "bucket-${terraform.workspace}"
  }
}

resource "aws_vpc" "vpc_prod" {
  count      = terraform.workspace == "prod" ? 1 : 0
  cidr_block = "10.1.0.0/16"
  tags = {
    "Name" = "vpc-${terraform.workspace}"
  }
}


