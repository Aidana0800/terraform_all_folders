
resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.default_subnet.id
  user_data     = var.user_data

  tags = {
    "Name" = var.instance_name
  }

}
