terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-20240122150508249500000001" ## Replace with your bucket ID. Run terraform init in ./backend dir first to get that value
    dynamodb_table = "terraform-state-lock"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
  }
}
