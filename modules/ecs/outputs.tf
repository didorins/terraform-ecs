output "aws_security_group" {
  description = "Security group of ECS"
  value       = aws_security_group.this.id
}

output "app_name" {
  description = "Designated name for the application"
  value       = var.app_name
}

output "aws_caller_identity" {
  description = "Who am I ?"
  value = data.aws_caller_identity.current.account_id
}

output "ecs_task_role" {
  description = "ARN of the IAM Role used by ECS task"
  value = aws_iam_role.this.arn
}