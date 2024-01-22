# AWS RDS module. 

## Creates: RDS instance, RDS SG, generate random password for superuser and store it in SSM as secure string.

#### Example usage

```hcl
module "rds" {
  source = "./modules/rds"

  instance_identifier = "postgrerds"
  name                = "postgredb"
  engine              = "postgres"
  engine_version      = "15.4"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  multi_az            = true
  skip_final_snapshot = true

  username            = "root"
  secret_name = "/db/prod/password"
  secret_type = "SecureString"

  publicly_accessible = false
  subnet_ids = module.vpc.private_subnet_ids
  rds_port                = 5431
  allowed_security_groups = module.ecs.aws_security_group
  vpc_id                  = module.vpc.vpc_id
}
```