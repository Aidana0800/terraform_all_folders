variable "vpcCidr" {
  description = "vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}


variable "subnet_public_cidr" {
  description = "subnet 1 cidr"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_private_cidr" {
  description = "subnet 2 cidr"
  type        = string
  default     = "10.0.2.0/24"
}


variable "resource_name_pub" {
  description = "isntance name"
  type        = string
  default     = "aidana_resource_pub"
}

variable "resource_name_pr" {
  description = "isntance name"
  type        = string
  default     = "aidana_resource_pr"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "igw_name" {
  description = "igw_name"
  default     = "igw-aidana"
}

variable "av-zone-pb-subnet" {
  default = "us-east-1a"
}

variable "av-zone-pr-subnet" {
  default = "us-east-1c"
}
