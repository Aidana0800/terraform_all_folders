
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.20240401.1-kernel-6.1-x86_64"]
  }
}


resource "aws_vpc" "vpc" {
  cidr_block = var.vpcCidr
}


resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_cidr
  availability_zone       = var.av-zone-pb-subnet
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.igw]
  tags = {
    "name" = var.resource_name_pub
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "name" = var.igw_name
  }
}


resource "aws_route_table" "rout_table_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}

resource "aws_route_table_association" "rt_association_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rout_table_public.id
  depends_on     = [aws_route_table.rout_table_public]
}


resource "aws_network_acl" "public-subnet-nacl" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.subnet_public.id]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    from_port  = 80
    to_port    = 80
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    from_port  = 443
    to_port    = 443
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }

}



resource "aws_subnet" "subnet_private" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_private_cidr
  map_public_ip_on_launch = false
  availability_zone       = var.av-zone-pr-subnet
  depends_on              = []
  tags = {
    "name" = var.resource_name_pr
  }

}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_public.id
}



resource "aws_route_table" "route_table_pr" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "route_table_assocciation_pr" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table_pr.id
  depends_on     = [aws_route_table.route_table_pr]
}



resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_private.id
  tags = {
    "name" = var.resource_name_pub
  }
}


resource "aws_instance" "instance-oregon" {
  ami           = "ami-0663b059c6536cac8"
  instance_type = var.instance_type
  provider      = aws.oregon
  depends_on    = [var.instance_type]
  tags = {
    "name" = var.resource_name_pr
  }
}








