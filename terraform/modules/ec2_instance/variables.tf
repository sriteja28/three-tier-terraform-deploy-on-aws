# modules/ec2_instance/variables.tf
variable "ami" {
  description = "AMI for the EC2 instances"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
}

variable "web_security_group_id" {
  description = "ID of the security group for the web tier"
}

variable "app_security_group_id" {
  description = "ID of the security group for the application tier"
}

variable "db_security_group_id" {
  description = "ID of the security group for the database tier"
}
