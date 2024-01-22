output "vpc_id" {
  description = "ID of AWS VPC"
  value       = aws_vpc.this.id
}

# Extract values from variable map
output "public_subnet_ids" {
  description = "IDs of the created subnets."
  value       = values(aws_subnet.public)[*].id
}

output "private_subnet_ids" {
  description = "IDs of the created subnets."
  value       = values(aws_subnet.private)[*].id
}