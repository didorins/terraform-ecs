variable "lb_name" {
  description = "Name for the Load Balancer"
}

variable "subnets" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name for the Target Group"
}

variable "target_group_port" {
  description = "Port on which targets receive traffic"
  default     = 80
}

variable "target_group_protocol" {
  description = "Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP. Required when target_type is instance, ip, or alb. Does not apply when target_type is lambda"
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID in which to deploy the Load Balancer"
  type        = string
}

variable "internal" {
  description = "Set to true if Load Balancer is internal. Set to false if Load balancer is public facing"
  type        = bool
}

variable "load_balancer_type" {
  description = "The type of load balancer to create"
  type        = string
  default     = "application"
}

variable "listener_port" {
  description = "Which port Load Balancer listens to"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = <<EOF
    Which protocol is used to connect to the Load Balancer. valid values are HTTP and HTTPS, with a default of HTTP. 
    For Network Load Balancers, valid values are TCP, TLS, UDP, and TCP_UDP. Not valid to use UDP or TCP_UDP
    EOF
  type        = string
}

variable "allowed_ingress_cidr_blocks" {
  description = "Whitelisted CIDR block for ingress traffic of Load Balancer. Used in Security Group rules"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ingress_port" {
  description = "Whitelisted port for ingress traffic of Load Balancer. Used in Security Group rules"
  type        = number
}

variable "egress_port" {
  description = "Whitelisted port for ingress traffic of Load Balancer. Used in Security Group rules"
  type        = number
}

variable "lb_protocol" {
  description = "Which protocol used for connection to Load Balancer. HTTP is traditional, can use -1 for all"
  default     = "-1"
}

variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group. Use IP for ECS FARGATE"
  type        = string
}