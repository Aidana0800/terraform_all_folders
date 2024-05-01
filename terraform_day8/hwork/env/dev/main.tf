
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
  subnet_azs    = ["us-east-1a", "us-east-1b"]
}


module "asg" {
  source          = "../../modules/asg"
  name_prefix     = "aidana-asg"
  instance_type   = "t2.micro"
  desired_size    = 2
  max_size        = 3
  min_size        = 1
  private_subnets = [module.vpc.private_subnets["10.0.7.0/24"], module.vpc.private_subnets["10.0.8.0/24"]]
  sg              = [aws_security_group.sg.id]
  tg_arns         = [module.alb.tg-arns]
}


module "alb" {
  source             = "../../modules/alb"
  name               = "aidana-resource"
  alb_public_subnets = [module.vpc.public_subnets["10.0.1.0/24"], module.vpc.public_subnets["10.0.2.0/24"]]
  vpc                = module.vpc.vpc_id
  security_groups    = [aws_security_group.sg.id]
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


