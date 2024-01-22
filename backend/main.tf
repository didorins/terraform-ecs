# The following initializes Terraform backend used to store remote state file in S3 with DynamoDB for locking.

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "this" {

  bucket_prefix = var.backend_bucket
}

resource "aws_dynamodb_table" "this" {
  name           = var.backend_table
  hash_key       = var.hash_key
  read_capacity  = var.rcu
  write_capacity = var.wcu

  attribute {
    name = var.hash_key
    type = var.hash_type
  }
}