variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "name" {
  default = "aidana"
}

variable "public_cidrs" {
  default = []
}

variable "private_cidrs" {
  default = []
}
