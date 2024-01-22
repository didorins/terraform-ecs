variable "instance_identifier" {
  description = "Name of the RDS instance"
  type        = string
}

variable "engine" {
  description = "Define Database engine"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "Compute and memory capacity of the RDS instance"
  type        = string
}

variable "username" {
  description = "Master username for the database"
  type        = string
  default     = "root"
}

variable "allocated_storage" {
  description = "Amount of storage to allocate to the RDS instance in gigabytes"
  type        = number
}

variable "name" {
  description = "Name of the Database."
  type        = string
}

variable "multi_az" {
  description = "If RDS is highly available"
  type        = bool
}

variable "publicly_accessible" {
  description = "If RDS is accessible from Internet"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "EBS type for the RDS instance"
  type        = string
  default     = "gp2"
}

variable "secret_name" {
  description = "Name of secret used for DB master password. Used as path when storing in SSM parameter store"
  type        = string
}

variable "secret_type" {
  description = "Type of secret used for DB master password. Valid types are String, StringList and SecureString"
  default     = "SecureString"

  validation {
    condition     = can(regex("String|StringList|SecureString|", var.secret_type))
    error_message = "Allowed values are are String, StringList and SecureString"
  }
}

variable "subnet_ids" {
  description = "ID of subnets in which RDS DB will be deployed"
  type        = list(string)
}

variable "rds_port" {
  description = "On which port to connect to RDS"
  type        = number
}

variable "rds_protocol" {
  description = "Which protocol used for connection to RDS. TCP is tradition, can use -1 for all"
  default     = "tcp"
}

variable "allowed_security_groups" {
  description = "Security Group from which traffic is allowed. Referenced in RDS Security Group ingress rule"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Whether to create final snapshot when DB is deleted"
  type        = bool
}

variable "vpc_id" {
  description = "Which VPC to create the SG in"
  type        = string
}