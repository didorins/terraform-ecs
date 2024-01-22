output "s3_name" {
  value       = "Use this string in ./ecs-task/backend-init.tf: ${aws_s3_bucket.this.id}"
  description = "Backend S3 name. Refer to module output for backend initialization"
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.this.name
  description = "Backend DynamoDB table name. Refer to module output for backend initialization"
}