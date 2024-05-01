resource "aws_launch_template" "launch_template" {
  name_prefix            = var.name_prefix
  image_id               = data.aws_ami.ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.sg
}

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.public_subnets
  desired_capacity    = var.desired_size
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}
