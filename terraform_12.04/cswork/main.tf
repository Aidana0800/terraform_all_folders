//terraform state file importing to s3
terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "aidana-bucket"
    key    = "dev/terraform.tfstate"

  }
}

locals {
  vpc_id = aws_vpc.vpc.id
  name   = "aidana"

}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = local.vpc_id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    "name" = "${local.name}-vpc"
  }

  lifecycle {
    ignore_changes = [cidr_block]
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id
}

resource "aws_route_table" "rt" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}


resource "aws_subnet" "private_subnet" {
  vpc_id     = local.vpc_id
  cidr_block = "10.0.2.0/24"
}




