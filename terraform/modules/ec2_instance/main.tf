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
