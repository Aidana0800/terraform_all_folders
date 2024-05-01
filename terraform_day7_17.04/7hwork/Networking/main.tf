resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "aidana-vpc"
  }
}

locals {
  public_subnets = {
    "puclic-subnet-1" = "10.0.1.0/24"
    "puclic-subnet-2" = "10.0.2.0/24"
    "puclic-subnet-3" = "10.0.3.0/24"
  }

  private_subnets = {
    "private-subnet-1" = "10.0.4.0/24"
    "private-subnet-2" = "10.0.5.0/24"
    "private-subnet-3" = "10.0.6.0/24"
  }



}

resource "aws_subnet" "public-subnet" {
  for_each   = local.public_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value
  tags = {
    "Name" = each.key
  }

}

resource "aws_subnet" "private-subnet" {
  for_each   = local.private_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value
  tags = {
    "Name" = each.key
  }

}
