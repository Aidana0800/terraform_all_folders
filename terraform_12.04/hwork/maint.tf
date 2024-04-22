
terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "aidana-bucket"
    key    = "dev/terraform.tfstate"
  }
}


data "aws_ami" "ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.20240401.1-kernel-6.1-x86_64"]
  }
}


locals {
  vpc_id            = aws_vpc.vpc.id
  subnet_id         = aws_subnet.public_subnet.id
  cidrVpc           = "10.0.0.0/16"
  cidrPublicSubnet  = "10.0.1.0/24"
  cidrPrivateSubnet = "10.0.2.0/24"
  name              = "aidana"
  ami               = data.aws_ami.ami

}

resource "aws_vpc" "vpc" {
  cidr_block = local.vpc_id

}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = local.vpc_id
  cidr_block              = local.cidrPublicSubnet
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
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}


resource "aws_subnet" "private_subnet" {
  vpc_id     = local.vpc_id
  cidr_block = local.cidrPrivateSubnet
}




