//terraform functions and count meta argument, imports

terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "aidana-tf-day5"
    key    = "dev/terraform.tfstate"
  }
}


locals {
  instance_name = ["first", "second"]

}

resource "aws_instance" "instances" {
  count         = length(local.instance_name)
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"

  tags = {
    "Name" = "instance-${local.instance_name[count.index]}"
  }

}


