# modules/vpc/variables.tf
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
}
