

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "${var.name}-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each                = toset(var.public_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.key
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.name}-public-subnet-${each.key}"
  }

}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.name}-igw"
  }

}

# resource "aws_internet_gateway_attachment" "attachment" {
#   internet_gateway_id = aws_internet_gateway.igw.id
#   vpc_id              = aws_vpc.vpc.id
# }


resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "${var.name}-public-rt"
  }

}

resource "aws_route_table_association" "public-rt-association" {
  for_each       = toset(var.public_cidrs)
  route_table_id = aws_route_table.rt-public.id
  subnet_id      = aws_subnet.public_subnets[each.key].id
}



resource "aws_subnet" "private_subnets" {
  for_each   = toset(var.private_cidrs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.key
  tags = {
    "Name" = "${var.name}-private-subnet-${each.key}"
  }
}


resource "aws_eip" "eip-private" {
  tags = {
    "Name" = "${var.name}-eip"
  }
}


resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip-private.id
  subnet_id     = aws_subnet.public_subnets["10.0.1.0/24"].id

  tags = {
    "Name" = "${var.name}-ngw"
  }
}




resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    "Name" = "${var.name}-private-rt"
  }
}

resource "aws_route_table_association" "private-rt-association" {
  for_each       = toset(var.private_cidrs)
  route_table_id = aws_route_table.rt-private.id
  subnet_id      = aws_subnet.private_subnets[each.key].id
}






