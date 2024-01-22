variable "region" {
  description = "Default AWS region where backend will be deployed"
  type        = string
  default     = "eu-west-1"
}

variable "backend_bucket" {
  description = "AWS S3 bucket name to store state file"
  type        = string
  default     = ""
}

variable "backend_table" {
  description = "DynamoDB table name used for state locking"
  type        = string
  default     = "terraform-state-lock"
}

variable "rcu" {
  description = "Number of Read Capacity Units for DynamoDB table"
  type        = number
  default     = 1
}

variable "wcu" {
  description = "Number of Write Capacity Units for DynamoDB table"
  type        = number
  default     = 1
}

variable "hash_key" {
  description = "Name of hash key attribute for DynamoDB table"
  type        = any
  default     = "LockID"
}

variable "hash_type" {
  description = "Attribute type. Valid values are S (string), N (number), B (binary)."
  type        = string
  default     = "S"

  validation {
    condition     = can(regex("S|N|B|", var.hash_type))
    error_message = "Allowed values are S (string), N (number), B (binary)"
  }
}