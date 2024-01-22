output "load_balancer_arn" {
  value       = aws_lb.this.arn
  description = "ARN of the Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "ARN of the Target Group"
}

output "security_groups" {
  value = aws_security_group.this.id
}

output "load_balancer_dns_name"{
  value = aws_lb.this.dns_name
  }