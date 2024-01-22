variable "cidr_block" {
  description = "CIDR Block range for VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable / Disable DNS support in VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable / Disable DNS Hostnames in VPC"
  type        = bool
}

variable "public_subnet_cidr_blocks" {
  description = "Map of CIDR / AZs for public subnets."
  type        = map(string)
}

variable "private_subnet_cidr_blocks" {
  description = "Map of CIDR / AZs for private subnets."
  type        = map(string)
}

variable "create_igw" {
  description = "If set to true, resource will be created" # To be implemented
  type        = bool
  default     = false
}