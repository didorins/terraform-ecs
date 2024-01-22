output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "rds_port" {
  description = "On which port to connect to RDS"
  value       = var.rds_port
}

output "security_groups" {
  description = "Security Group of RDS"
  value = aws_security_group.this.id
}