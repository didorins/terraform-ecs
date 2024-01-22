output "load_balancer_dns_name" {
  description = "Loadbalancer DNS name"
  value = <<EOF
  Access your application from here:
  ${module.alb.load_balancer_dns_name}
  EOF
}