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
