output "vpc" {
  description = "outputting id of vpc from networking folder"
  value       = aws_vpc.vpc.id
}

output "subent" {
  description = "outputting id of private subnet from  networking folder"
  value       = { for subnet, v in aws_subnet.private : subnet => v.id }
}
