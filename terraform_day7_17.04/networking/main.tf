locals {
  name = "aidana"
  private_subnet = {
    "private-subnet-1" = {
      cidr_block = "10.0.1.0/24"
      env        = "dev"
    }
    "private-subnet-2" = {
      cidr_block = "10.0.2.0/24"
      env        = "prod"
    }
    "private-subnet-3" = {
      cidr_block = "10.0.3.0/24"
      env        = "stage"
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "${local.name}-vpc"
  }
}

resource "aws_subnet" "private" {
  for_each   = local.private_subnet
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value["cidr_block"]

  tags = {
    "Name" = each.key
    env    = each.value["env"]
  }

}
