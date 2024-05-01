output "vpc" {
  description = "outputting id of vpc from networking folder"
  value       = aws_vpc.vpc.id
}

output "subnets" {
  description = "outputting id of private subnet from  networking folder"
  value       = { for subnet, v in aws_subnet.public-subnet : subnet => v.id }
}
