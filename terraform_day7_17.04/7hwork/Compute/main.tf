
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}


locals {
  instance = { "isntance-1" = "first", "inctance-2" = "second", "instance-3" = "thrid" }

}


resource "aws_instance" "instance" {
  for_each      = local.instance
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.networking.outputs.subnets[each.key].id

}


# resource "aws_security_group" "secuirty_group" {
#   vpc_id = data.terraform_remote_state.networking.vpc


# }
