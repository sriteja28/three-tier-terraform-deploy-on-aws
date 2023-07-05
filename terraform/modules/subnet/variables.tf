# modules/subnet/variables.tf
variable "vpc_id" {
  description = "ID of the VPC"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
}
