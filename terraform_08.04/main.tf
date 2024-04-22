resource "aws_instance" "web" {

  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  tags = {
    name = "inctance-1"
  }
}

resource "aws_instance" "web_1" {

  ami                         = "ami-051f8a213df8bc089"
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  availability_zone           = "us-east-1a"

  tags = {
    name = "inctance-2"
  }
}

resource "aws_instance" "web_2" {
  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  monitoring                  = true
  tags = {
    name = "instance_3"
  }
}

