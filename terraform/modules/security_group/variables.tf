# modules/security_group/variables.tf
variable "name" {
  description = "Name of the security group"
}

variable "description" {
  description = "Description of the security group"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "from_port" {
  description = "Start of port range for ingress traffic"
}

variable "to_port" {
  description = "End of port range for ingress traffic"
}

variable "protocol" {
  description = "Protocol for ingress traffic"
}

variable "cidr_blocks" {
  description = "CIDR blocks for ingress traffic"
  type        = list(string)
}
