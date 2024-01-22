# AWS VPC module.

## Creates: VPC, private/public subnet(s), IGW, RT and RT assoc.

#### Example usage

```hcl
module "vpc" {
  source = "./modules/vpc"

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_cidr_blocks = {
    "eu-west-1a" = "10.0.10.0/24"
    "eu-west-1b" = "10.0.11.0/24"
  }
  private_subnet_cidr_blocks = {
    "eu-west-1a" = "10.0.20.0/24"
    "eu-west-1b" = "10.0.21.0/24"  
  }
}
```