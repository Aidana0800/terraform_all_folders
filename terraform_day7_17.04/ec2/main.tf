
locals {
  name = "aidana"
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  subnet_id     = "subnet-0cd45a869bc5d75c3"
  tags = {
    "Name" = "${local.name}-instance"
  }
}


resource "aws_subnet" "instance_subnet" {
  vpc_id     = data.terraform_remote_state.networking.outputs.vpc
  cidr_block = "10.0.7.0/24"
  tags = {
    "Name" = "subnet-for-isntance"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = data.terraform_remote_state.networking.outputs.vpc
}




