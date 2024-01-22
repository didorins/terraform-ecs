# AWS LB module. 

## Creates: LB, target group, listener rule, listener rule.

#### Example usage

```hcl
module "alb" {
  source = "./modules/lb" 
  
  lb_name = "${module.ecs.app_name}-lb"
  internal = false

  subnets = module.vpc.public_subnet_ids

  vpc_id = module.vpc.vpc_id
  listener_protocol = "HTTP"
  target_type = "ip"

  lb_protocol = -1
  lb_port = 0

  target_group_name = "${module.ecs.app_name}-tg"
  allowed_ingress_cidr_blocks = "0.0.0.0/0"
}
```