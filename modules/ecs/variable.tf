variable "app_name" {
  description = "Application name"
}

variable "container_name" {
  description = "Name of the container used in task definition"
}

variable "image" {
  description = "The Docker image to use for the container"
}

variable "cpu" {
  description = "Amount of CPU units to allocate for the task"
  default     = 512
}

variable "memory" {
  description = "Amount of memory to allocate for the task"
  default     = 1024
}

variable "desired_count" {
  description = "Desired number of tasks to run in the service"
  default     = 1
}

variable "execution_role_arn" {
  description = "ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  type        = string
}

variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = "awsvpc"

  validation {
    condition     = can(regex("none|bridge|awsvpc|host", var.network_mode))
    error_message = "Allowed values are are none, bridge, awsvpc, and host"
  }
}

variable "requires_compatibilities" {
  description = "Set of launch types required by the task. The valid values are EC2 and FARGATE"
  type        = string
  default     = "FARGATE"

  validation {
    condition     = can(regex("EC2|FARGATE", var.requires_compatibilities))
    error_message = "Allowed values are EC2 and FARGATE"
  }
}

variable "containerPort" {
  description = "Port mappings allow containers to access ports on the host container instance to send or receive traffic"
  type        = number
}

variable "subnets" {
  description = "Subnets associated with the task or service"
  type        = list(string)
}

variable "vpc_id" {
  description = "Which VPC to create the SG in"
  type        = string
}

variable "ecs_protocol" {
  description = "Which protocol used for connection to ECS. TCP is traditional, can use -1 for all"
  default     = "tcp"
}

variable "egress_protocol" {
  description = "Which protocol is allowed ECS to use for outbound connections. TCP is traditional, can use -1 for all"
}

variable "allowed_ingress_security_groups" {
  description = "Security Group FROM which traffic is allowed. Referenced in ECS task Security Group ingress rule"
  type        = string
  default = ""
}

# variable "allowed_egress_security_groups" {
#   description = "Security Group TO which traffic is allowed. Referenced in ECS task Security Group ingress rule"
#   type        = string
#   default = ""
# }

variable "allowed_egress_cidr_blocks" {
  description = "Whitelisted CIDR block for egress traffic of ECS tasks"
  type        = string
  default     = "0.0.0.0/0" 
}

# variable "allowed_ingress_cidr_blocks" {
#   description = "Whitelisted CIDR block for egress traffic of ECS tasks"
#   type        = string
#   default     = "0.0.0.0/0"
# }

variable "egressPort" {
  description = "Allowed port to used for egress traffic by ECS task"
  type        = number
}

variable "assign_public_ip" {
  description = "Set to true to assign public IP to tasks. Used in service configuration"
  type        = bool
}

variable "target_group_arn" {
  description = "ARN of the Target Group for Loadbalancer to be infront of ECS service tasks"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of IAM Role to assume by ECS service. Used to grant permissions to ECS to modify LB target groups and more"
  type = string
}

