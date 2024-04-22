output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "vpc-cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "subnet1-id" {
  value = aws_subnet.subnet_1.id
}

output "subnet2-id" {
  value = aws_subnet.subnet_2.id
}


output "instance-id" {
  value = aws_instance.instance.id
}

output "instance-name" {
  value = aws_instance.instance.tags_all
}
