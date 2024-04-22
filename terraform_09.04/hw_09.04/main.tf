resource "aws_vpc" "vpc" {
  cidr_block = var.vpcCidr
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet1Cidr
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet2Cidr
}


resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_1.id

  tags = {
    "Name" = var.instance_name
  }
}




