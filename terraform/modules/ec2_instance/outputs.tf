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
