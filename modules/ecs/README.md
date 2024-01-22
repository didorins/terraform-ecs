# AWS RDS module. 

## Creates: ECS cluster, service, task definition, ECS SG.

#### Example usage

```hcl
module "ecs" {
 source = "./modules/ecs" 
  
  app_name = "Hello-world"
  container_name = "${module.ecs.app_name}-container"
  image = "public.ecr.aws/aws-containers/hello-app-runner:latest"

  cpu = 512
  memory = 1024
  desired_count = 2

  assign_public_ip = true
  containerPort = 8000
  egressPort = 0
  egress_protocol = -1
  execution_role_arn = "arn:aws:iam::730335498415:role/ecsTaskExecutionRole"

  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnet_ids
}
```