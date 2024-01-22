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

  username    = "root"
  secret_name = "/db/prod/password"
  secret_type = "SecureString"

  publicly_accessible     = false
  subnet_ids              = module.vpc.private_subnet_ids
  rds_port                = 5431
  allowed_security_groups = module.ecs.aws_security_group
  vpc_id                  = module.vpc.vpc_id
}

module "ecs" {
  source = "./modules/ecs"

  app_name       = "Hello-world"
  container_name = "${module.ecs.app_name}-container"
  image          = "public.ecr.aws/aws-containers/hello-app-runner:latest"

  cpu           = 512
  memory        = 1024
  desired_count = 2

  assign_public_ip   = true
  containerPort      = 8000

  allowed_ingress_security_groups = module.alb.security_groups

  egressPort         = 0
  egress_protocol    = -1
  network_mode = "awsvpc"

  execution_role_arn = "arn:aws:iam::${module.ecs.aws_caller_identity}:role/ecsTaskExecutionRole"
  task_role_arn = "arn:aws:iam::730335498415:role/ecs-roleee"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnet_ids

  target_group_arn = module.alb.target_group_arn
}

module "alb" {
  source = "./modules/lb"

  lb_name  = "${module.ecs.app_name}-lb"
  internal = false

  subnets = module.vpc.public_subnet_ids

  vpc_id            = module.vpc.vpc_id
  listener_protocol = "HTTP"
  target_type       = "ip"

  lb_protocol = -1
  ingress_port = 0
  egress_port = 0

  target_group_name           = "${module.ecs.app_name}-tg"
  allowed_ingress_cidr_blocks = "0.0.0.0/0"
}


# TO DO:

# Create SSL cert with ACM and attach to ALB, enforce HTTPS and enable SSL termination

# Verify ECS task connection to RDS endpoint with following
# https://repost.aws/knowledge-center/ecs-fargate-task-database-connection

# Consider putting ECS service in private subnet and enable internet output access (to download docker image from ECR etc..) via NAT GW in the public subnet .. 
# OR .. automate docker image push in ECR to be used as base for ECS tasks

# When calling modules, consider using var.tf to assign value to variables there and not in main.tf. This allows for reusability of this architecture layout in stages / different envs.

# Architecture diagram

# Task role