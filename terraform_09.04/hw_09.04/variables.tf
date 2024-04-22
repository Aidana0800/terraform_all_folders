variable "vpcCidr" {
  description = "vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}


variable "subnet1Cidr" {
  description = "subnet 1 cidr"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet2Cidr" {
  description = "subnet 2 cidr"
  type        = string
  default     = "10.0.2.0/24"
}


variable "instance_name" {
  description = "isntance name"
  type        = string
  default     = "test 1"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}
