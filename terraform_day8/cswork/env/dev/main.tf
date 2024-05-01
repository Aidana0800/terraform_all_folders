
provider "aws" {
  region = "us-east-1"
}

locals {
  ingress_ports = [22, 80, 443]
}


module "vpc" {
  source        = "../../modules/vpc"
  public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidrs = ["10.0.7.0/24", "10.0.8.0/24"]
}


module "asg" {
  source         = "../../modules/asg"
  name_prefix    = "aidana-asg"
  instance_type  = "t2.micro"
  desired_size   = 2
  max_size       = 3
  min_size       = 1
  public_subnets = [module.vpc.public_subnets["10.0.1.0/24"], module.vpc.public_subnets["10.0.2.0/24"]]
  sg             = [aws_security_group.sg.id]
}


resource "aws_security_group" "sg" {
  vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = toset(local.ingress_ports)

    content {
      to_port     = ingress.key
      from_port   = ingress.key
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }
  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
