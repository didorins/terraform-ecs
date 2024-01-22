data "aws_caller_identity" "current" {}

data "aws_iam_policy" "this" {
  name = "AmazonECS_FullAccess"
}