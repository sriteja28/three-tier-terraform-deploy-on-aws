# three-tier-terraform-deploy-on-aws
AWS | Terraform | Bash Scripting

```bash
#!/bin/bash

# Create root directory
mkdir -p terraform
cd terraform

# Create main files in the root directory
cat <<EOT > main.tf
# main.tf
EOT

cat <<EOT > variables.tf
# variables.tf
variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}
EOT

cat <<EOT > outputs.tf
# outputs.tf
output "web_instance_id" {
  description = "ID of the web tier EC2 instance"
  value       = module.ec2_instance_web.instance_id
}

output "app_instance_id" {
  description = "ID of the application tier EC2 instance"
  value       = module.ec2_instance_app.instance_id
}

output "db_instance_id" {
  description = "ID of the database tier EC2 instance"
  value       = module.ec2_instance_db.instance_id
}
EOT

cat <<EOT > providers.tf
# providers.tf
provider "aws" {
  access_key = var.aws_access_key
  secret_access_key = var.aws_secret_access_key
  region = var.aws_region
}
EOT

cat <<EOT > backend.tf
# backend.tf
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "three-tier-architecture.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}
EOT

# Create module directories
mkdir -p modules/vpc
mkdir -p modules/subnet
mkdir -p modules/security_group
mkdir -p modules/ec2_instance

# Create module files for the VPC module
cat <<EOT > modules/vpc/main.tf
# modules/vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}
EOT

cat <<EOT > modules/vpc/variables.tf
# modules/vpc/variables.tf
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
}
EOT

cat <<EOT > modules/vpc/outputs.tf
# modules/vpc/outputs.tf
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
EOT

# Create module files for the Subnet module
cat <<EOT > modules/subnet/main.tf
# modules/subnet/main.tf
resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnet_cidr_block
}
EOT

cat <<EOT > modules/subnet/variables.tf
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
EOT

cat <<EOT > modules/subnet/outputs.tf
# modules/subnet/outputs.tf
output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}
EOT

# Create module files for the Security Group module
cat <<EOT > modules/security_group/main.tf
# modules/security_group/main.tf
resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
EOT

cat <<EOT > modules/security_group/variables.tf
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
EOT

cat <<EOT > modules/security_group/outputs.tf
# modules/security_group/outputs.tf
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.main.id
}
EOT

# Create module files for the EC2 Instance module
cat <<EOT > modules/ec2_instance/main.tf
# modules/ec2_instance/main.tf
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [var.web_security_group_id]

  tags = {
    Name = "web-instance"
  }
}

resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  vpc_security_group_ids = [var.app_security_group_id]

  tags = {
    Name = "app-instance"
  }
}

resource "aws_instance" "db" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  vpc_security_group_ids = [var.db_security_group_id]

  tags = {
    Name = "db-instance"
  }
}
EOT

cat <<EOT > modules/ec2_instance/variables.tf
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
EOT

cat <<EOT > modules/ec2_instance/outputs.tf
# modules/ec2_instance/outputs.tf
output "web_instance_id" {
  description = "ID of the web tier EC2 instance"
  value       = aws_instance.web.id
}

output "app_instance_id" {
  description = "ID of the application tier EC2 instance"
  value       = aws_instance.app.id
}

output "db_instance_id" {
  description = "ID of the database tier EC2 instance"
  value       = aws_instance.db.id
}
EOT

echo "Directory structure and files created successfully."

```
